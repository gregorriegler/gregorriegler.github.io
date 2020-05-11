---
layout: post
title: "Outside-In TDD a Consumer"
tags: 
- TDD
- Consumer Driven Contracts 
---

### Consumer Driven Contracts
[Consumer Driven Contracts](https://martinfowler.com/articles/consumerDrivenContracts.html) (CDC) is a pattern that takes [Outside-In TDD](https://8thlight.com/blog/georgina-mcfadyen/2016/06/27/inside-out-tdd-vs-outside-in.html) across boundaries, and is frequently used in Micro Services Architectures.
Note that TDD is not primarily a testing process, but a design technique.
The same is true for Consumer Driven Contracts where Consumers drive the capabilities of Producers by expressing a clear need.
This ties service evolution to business value.
Consumers start by writing [Contract Tests](https://martinfowler.com/bliki/ContractTest.html) and define what a Producer's API should be like.
The Producer is replaced by a [Mock Object](https://martinfowler.com/articles/mocksArentStubs.html) whose configuration generates the Contract.
The interactions described in the Contract are later replayed against the Producer in a test harness.
Both, the Consumer and the Producer are tested in isolation and evolve independently. 

### Driving Client Code Via Consumer Tests
Another thing that the Consumer's Contract Tests are good for is they can help emerge the client code. 
We aim for a client code that hides the technical details such as HTTP messaging and JSON serialization from us.
The client code should represent the remote service within our boundary and hide the fact that it is remote.

### Defining A First Contract
We're building a Book Store, so we need a Book Catalogue as a Producer.
It should serve the Book's information.
Let's start with a happy path for finding a single book.
This is what the Producer Mock would look like using [Pact JS](https://github.com/pact-foundation/pact-js).
The definition of this Mock as well generates the Contract.
I'm skipping the boilerplate, you can look it up in my [github](https://github.com/gregorriegler/cdc-example-typescript).

```javascript
const requestASingleBook = {
    state: "two books",
    uponReceiving: "a request for retrieving the first book",
    withRequest: {
        method: "GET",
        path: "/books/1"
    },
    willRespondWith: {
        status: 200,
        headers: {"Content-Type": "application/json"},
        body: {
            "self": "/books/1",
            "title": "Title"
        }
    }
}
```

### Options, Options, Options
We can now start writing the actual Consumer Test.
But where do we start? 
What do we assert?

We could try to design the client code by [wishful thinking](https://wiki.c2.com/?WishfulThinking).
```typescript
it("finds a single book", () => {
    // represents the producer
    let books = new Books() 

    // executes the http call and does json deserialization
    let book = books.byId(bookId) 
    
    expect(book).to.deeply.eq(expectedBook)
})
```
This could be a first failing test, and a nice design that hides the technical details as desired.
But it certainly is a bit premature.
We haven't even put an API's baseUrl.
Neither did we think about potential errors.
All the HTTP handling code would have to go to the not yet existing `Books` object. 
How would we even go about making a HTTP request?
How would we deserialize the content?
There are many things coming up, and it already feels like a huge leap.  
There has to be a better way.

### Making Smaller Steps
We could just ignore the design for now and focus on the technical details.
Meaning we would start and implement the HTTP call within the test.
This approach puts us closer to the technical details. 
It allows us to fiddle around, and prevents us from designing prematurely.
Later, when we experience duplication, we can extract the implementation code from the test to emerge a more mature design. 
Some would call it [TDD as if you meant it](https://gojko.net/2009/02/27/thought-provoking-tdd-exercise-at-the-software-craftsmanship-conference/) (TDD aiymi).

### A Failing Test
We start by defining our final expectation, that is the book data as a result.
We don't yet know how to get there.
All we know is the url.
Note how we don't assert on any technical details like the HTTP Status Code and Content-Type.
These details don't concern us, they will be hidden once we're finished.

```typescript
const requestASingleBook = {
    state: "two books",
    uponReceiving: "a request for retrieving the first book",
    withRequest: {
        method: "GET",
        path: "/books/1"
    },
    willRespondWith: {
        status: 200,
        headers: {"Content-Type": "application/json"},
        body: {
            "self": "/books/1",
            "title": "Title"
        }
    }
}

// ... boilerplate ...

it("finds a single book", async () => {
    let url = "http://localhost:1234/books/1"
    
    let result // ??

    expect(result).to.deep.eq({self: "/books/1", title: "Title"})
})
```
Run the tests => **<span style="color:red">Red</span>**.

### Make it Green
Let's find the simplest way to make the test green by writing all implementation code into the test.

```typescript
it("finds a single book", async () => {
    const bent = require("bent") // bent is just a http client
    const getJSON = bent("json")

    let result = await getJSON("http://localhost:1234/books/1")

    expect(result).to.deep.eq({self: "/books/1", title: "Title"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

Fabulous!

### Refactor
As it works we can now think of improving it.
Let's create a type for the book.

```typescript
it("finds a single book", async () => {
    const bent = require("bent")
    const getJSON = bent("json")

    type Book = {
        self: string
        title: string
    }

    let result: Book = await getJSON("http://localhost:1234/books/1")

    expect(result).to.deep.eq({self: "/books/1", title: "Title"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

### Sticking To The Robustness Principle
The Robustness Principle says that we should be conservative in sending stuff but liberal in receiving it.
The goal of this is to reduce the risk for messages to fail.
Consumers should be tolerant to API change, able to survive most of it. 
They should only be concerned with the Resources, Methods and Fields they actually consume, and treat even them with care.

In the existing solution a new arriving field would cause the message to fail.   
Let's imagine the server would add a new field: `description`.
Our client code would not expect it and break.
We need to make it more robust and prevent this from happening.

But, should we not write a test first proving that it would break?

Totally!
However, we are currently in the writing of a Consumer Test. 
It generates the Contract for the Producer.
Adding the `description` field to the Contract is not what we want.
We only want to add the fields that we consume.
So let's
1. add the field temporarily to prove that it breaks, 
2. fix the implementation to not break anymore, 
3. and finally remove the field again. 

```typescript
it("finds a single book", async () => {
    const bent = require("bent")
    const getJSON = bent("json")

    type Book = {
        self: string
        title: string
    }

    function decodeBook(object): Book {
        return {
            self: object.self,
            title: object.title
        }
    }

    let response = await getJSON("http://localhost:1234/books/1")

    let book: Book = decodeBook(response)

    expect(book).to.deep.eq({self: "/books/1", title: "Title"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

The `decodeBook` function makes the code robust against any change to fields that we don't consume.

### Aiming For Duplication
Already fiddling around a lot, aren't we?
Let's aim for some duplication by implementing the not found case.
We can just copy and paste the earlier test and adapt it.
Shouldn't have to change much, should we?

```typescript
const requestANonExistingBook = {
    state: "two books",
    uponReceiving: "a request for a non existing book",
    withRequest: {
        method: "GET",
        path: "/books/3"
    },
    willRespondWith: {
        status: 404
    }
}


// ... boilerplate ...


it("finds nothing", async () => {
    const bent = require("bent")

    type Book = {
        self: string
        title: string
    }

    function decodeBook(object): Book {
        return {
            self: object.self,
            title: object.title
        }
    }

    const getStream = bent("http://localhost:1234/books/3", 200, 404)
    let stream = await getStream()
    let book:Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    }

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

That escalated quickly.
The implementation changed quite a bit.
We had to change the way we use bent to support the 404 status code.
Also, we decided to introduce the Option type to make explicit a book might not be returned.
The two tests look quite different now.

### Finding The Common Denominator
Before we can extract it as production code we need to adapt both tests to match each other.

```typescript
it("finds a single book", async () => {
    const bent = require("bent")

    type Book = {
        self: string
        title: string
    }

    function decodeBook(object): Book {
        return {
            self: object.self,
            title: object.title
        }
    }

    const getStream = bent("http://localhost:1234", 200, 404)
    let stream = await getStream("/books/1")
    let book:Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.deep.eq(some({self: "/books/1", title: "Title"}))
})

// ...

it("finds nothing", async () => {
    const bent = require("bent")

    type Book = {
        self: string
        title: string
    }

    function decodeBook(object): Book {
        return {
            self: object.self,
            title: object.title
        }
    }

    const getStream = bent("http://localhost:1234", 200, 404)
    let stream = await getStream("/books/3")
    let book:Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

### Extract Production Code
Ok, great. 
The implementation code is now the same in both cases: Finding a book, and not finding it.
We can finally start and extract the duplicated parts out of the tests.
Let's begin with the Book type, and the `decodeBook` function.

```typescript
const bent = require("bent")

type Book = {
    self: string
    title: string
}

function decodeBook(object): Book {
    return {
        self: object.self,
        title: object.title
    }
}

// ...

it("finds a single book", async () => {
    let baseUrl = "http://localhost:1234"
    let path = "/books/1"
    
    const getStream = bent(baseUrl, 200, 404)
    let stream = await getStream(path)
    let book:Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.deep.eq(some({self: "/books/1", title: "Title"}))
})

// ...

it("finds nothing", async () => {
    let baseUrl = "http://localhost:1234"
    let path = "/books/3"
    
    const getStream = bent(baseUrl, 200, 404)
    let stream = await getStream(path)
    let book:Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

Note how I as well extracted both the `baseUrl` and `path` variables inside the tests.
This allows us to further extract the function that does the actual request.

```typescript
const bent = require("bent")

type Book = {
    self: string
    title: string
}

function decodeBook(object): Book {
    return {
        self: object.self,
        title: object.title
    }
}

async function findBook(baseUrl: string, path: string): Promise<Option<Book>> {
    const getStream = bent(baseUrl, 200, 404)
    let stream = await getStream(path)
    let book: Option<Book>

    if (stream.status !== 200) {
        log("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }
    return book
}

// ...

it("finds a single book", async () => {
    let baseUrl = "http://localhost:1234"
    let path = "/books/1"

    let book = await findBook(baseUrl, path)

    expect(book).to.deep.eq(some({self: "/books/1", title: "Title"}))
})

// ...

it("finds nothing", async () => {
    let baseUrl = "http://localhost:1234"
    let path = "/books/3"

    let book = await findBook(baseUrl, path)

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

### Final Touch
The tests became nice and short.
However, I would prefer having a bookClient object that had the `baseUrl` baked in.
This would allow me to add more functions later.
So I refactor it further, and extract the module.
The final result looks like this:

```typescript
// content of book-client.ts
import {none, Option, some} from "fp-ts/lib/Option"
const bent = require("bent")

export function createBookClient(baseUrl: string) {
    type Book = {
        self: string
        title: string
    }

    function decodeBook(object): Book {
        return {
            self: object.self,
            title: object.title
        }
    }

    return {
        requestBook: async (path: string): Promise<Option<Book>> => {
            const getStream = bent(baseUrl, 200, 404)
            let stream = await getStream(path)
            if (stream.status !== 200) {
                log("received " + stream.status + " " + await stream.text())
                return none
            }
            return some(decodeBook(await stream.json()))
        }
    }
}

// content of tests
import {createBookClient} from "./book-client"

// ...

const client = createBookClient("http://localhost:1234")

it("finds a single book", async () => {
    let book = await client.requestBook("/books/1")

    expect(book).to.deep.eq(some({self: "/books/1", title: "Title"}))
})

// ...

it("finds nothing", async () => {
    let book = await client.requestBook("/books/3")

    expect(book).to.equal(none)
})

```
Run the tests => **<span style="color:green">Green</span>**.

And we are finished.

### Conclusion
We drove a clean client code from writing Consumer Tests.
We used the tests to fiddle around with technical implementation detail.
Once we had tested more cases, we aligned their implementations to extract common code.
The design we arrived at is a little different from the one we had originally anticipated.

TDD leaves us with a choice when to design.<br>
We can do it upfront by wishful thinking - in the Red Phase.<br>
Or we can defer it to a later stage - in the Refactoring Phase.<br>
The latter makes it easier to fiddle around with the details and may lead to a more mature design.


You can find the code on my [github](https://github.com/gregorriegler/cdc-example-typescript).

