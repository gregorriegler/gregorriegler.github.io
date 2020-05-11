---
layout: post
title: "TDD a consumer as if you mean it"
tags: 
- TDD
- TDD aiymi
- Consumer Driven Contracts
- Design by Contract
- Contract Testing 
---

### Consumer Driven Contracts
[Consumer Driven Contracts](https://martinfowler.com/articles/consumerDrivenContracts.html) (CDC) is a pattern that takes [Outside-In TDD](https://8thlight.com/blog/georgina-mcfadyen/2016/06/27/inside-out-tdd-vs-outside-in.html) across boundaries, and is frequently used in Micro Services Architectures.
Note that TDD is not primarily a testing process, but a design technique.
Same is true for Consumer Driven Contracts.
Consumers drive the design of Producers by expressing a clear need, which ties service evolution to business value.
The [Contracts](https://martinfowler.com/bliki/ContractTest.html) emerge from writing Consumer Tests that describe what a Producers API should be.
For the Consumer these Contracts act as Mock Objects that mimic the behaviour of the Producer but also verify whether it was called accordingly.
For the Producer they act as a ??? TBD.
Both can be tested in isolation and developed independently. 

### Driving Client Code Via Consumer Tests
Another thing that Consumer Tests are good for is they can help emerge the Consumers' client code. 
We aim for a client code that hides the technical details such as HTTP messaging and JSON deserialization from us.
The client code should represent the remote service within our boundary and hide the fact that it is remote.

### Defining A First Contract
We're building a Book Store, so we need a Book Catalogue as a Producer.
It should serve the Books' information.
Let's start with a happy path for finding a single book.
This is what the Contract would look like using [Pact JS](https://github.com/pact-foundation/pact-js).
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
            "title": "Hello Book 1"
        }
    }
}
```

### Options, Options, Options
We can now start writing the actual consumer test.
But where do we start? 
What do we assert?

We could try to design the client code by [wishful thinking](https://wiki.c2.com/?WishfulThinking).
```typescript
it("finds a single book", () => {
    let books = new Books() // represents the producer
    let book = books.byId(bookId) // executes the http call and does json deserialization
    
    expect(book).to.deeply.eq(expectedBook)
})
```
This would make a failing test, and a nice design that hides the technical details as desired.
At the same time it puts us at a great distance from a working code.
All the HTTP handling code will have to go to the not yet existing `Books` object. 
And where does the base url belong?
How would we even go about making a HTTP request?
How would we deserialize the content? 
Solving all of this to get the test green might take some time. 
Are we even confident in the design, or is it not a bit premature? 
What about other scenarios like error cases?
 
There has to be a better, safer way.

### Making Smaller Steps
Indeed, there is another way.
We could just ignore the design for now and focus on the technical details.
We would just start and implement a proper client code within the test.
Later, when we experience duplication, we can extract it to emerge a more mature design.
This approach puts us closer to the technical details like HTTP and JSON deserialization. 
It allows us to fiddle around before thinking about design, preventing us from doing it prematurely. 
Some would call this [TDD as if you mean it](https://gojko.net/2009/02/27/thought-provoking-tdd-exercise-at-the-software-craftsmanship-conference/) (TDD aiymi).

### A Failing Test
We start by defining our final expectation, that is the book data as a result.
We don't yet know how to get there.
All we know is the url.
Note how we don't assert on any technical details like the HTTP Status Code and Content-Type.
These details don't concern us, they will be hidden once we're finished.

```typescript
it("finds a single book", async () => {
    let url = "http://localhost:1234/books/1"
    
    let result // ??

    expect(result).to.deep.equal({self: "/books/1", title: "Hello Book 1"})
})
```
Run the tests => **<span style="color:red">Red</span>**.

#### Make it Green
Let's find the simplest way to make the test green by writing all implementation code into the test.

```typescript
it("finds a single book", async () => {
    const bent = require("bent") // bent is just a http client
    const getJSON = bent("json")

    let result = await getJSON("http://localhost:1234/books/1")

    expect(result).to.deep.equal({self: "/books/1", title: "Hello Book 1"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

#### Refactor
As it works we can think of improving it now.
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

    expect(result).to.deep.equal({self: "/books/1", title: "Hello Book 1"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

#### Sticking To The Robustness Principle
The Robustness Principle says that we should be conservative in sending stuff but liberal in receiving it.
The goal of this is to reduce the risk for messages to fail.
Consumers should be tolerant to change, able to survive most of it. 
They should only be concerned with the Resources, Methods and Fields they actually consume, and treat even them with care.

In the existing solution a new arriving field would cause the message to fail.   
Let's imagine the server would add a field `description`.
Our client code would not expect it and break.
So, we need to make our code more robust and prevent this from happening.

But, should we not write a test first proving that it would break?
Totally!
However, we are currently in the writing of a consumer test. 
It generates a contract for the producer.
Adding the `description` field to the contract in order to test it would be wrong.
We don't want to add fields to the contract we don't consume.
So let's
1. add the field temporarily to prove it breaks, 
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

    expect(book).to.deep.equal({self: "/books/1", title: "Hello Book 1"})
})
```
Run the tests => **<span style="color:green">Green</span>**.

The code is now robust against any change to unused fields.

#### Aiming For Duplication
Already fiddling around a lot, aren't we?
Now let's aim for some duplication by implementing the not found case.
This is what the contract would look like:

```javascript
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
```
We just copy and paste the earlier test and adapt it.
Shouldn't have to change much, should we?

```typescript
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
        console.info("received " + stream.status + " " + await stream.text())
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

#### Finding The Common Denominator
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
        console.info("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.deep.equal(some({self: "/books/1", title: "Hello Book 1"}))
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
        console.info("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

#### Extract Production Code
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
        console.info("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.deep.equal(some({self: "/books/1", title: "Hello Book 1"}))
})

// ...

it("finds nothing", async () => {
    let baseUrl = "http://localhost:1234"
    let path = "/books/3"
    
    const getStream = bent(baseUrl, 200, 404)
    let stream = await getStream(path)
    let book:Option<Book>

    if (stream.status !== 200) {
        console.info("received " + stream.status + " " + await stream.text())
        book = none
    } else {
        book = some(decodeBook(await stream.json()))
    }

    expect(book).to.equal(none)
})
```
Run the tests => **<span style="color:green">Green</span>**.

Note how I extracted both the baseUrl and path variables to allow for further extraction of duplicated code.

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
        console.info("received " + stream.status + " " + await stream.text())
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

    expect(book).to.deep.equal(some({self: "/books/1", title: "Hello Book 1"}))
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

#### Final Touch
The tests became nice and short.
However, I would prefer having a bookClient object that had the baseUrl baked in.
This would allow me to add more functions later.
So I refactor it further, and extract the module.
The final result looks like the following.

```typescript
// content of book-client.ts
import {none, Option, some} from "fp-ts/lib/Option"
const bent = require("bent")

export function bookClient(baseUrl: string) {
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
                console.info(await stream.text())
                return none
            }
            return some(decodeBook(await stream.json()))
        }
    }
}

// content of tests
import {bookClient} from "./book-client"

// ...

const client = bookClient("http://localhost:1234")

it("finds a single book", async () => {
    let book = await client.requestBook("/books/1")

    expect(book).to.deep.equal(some({self: "/books/1", title: "Hello Book 1"}))
})

// ...

it("finds nothing", async () => {
    let book = await client.requestBook("/books/3")

    expect(book).to.equal(none)
})

```
Run the tests => **<span style="color:green">Green</span>**.

And we are finished.

#### Wrap up
We drove a clean client code from writing Consumer Tests.
We used the tests to fiddle around with technical implementation detail.
Once we had tested more cases, we aligned their implementations to extract common code.
The design we arrived at is a little different from the one we had originally anticipated.

You can find the code on my [github](https://github.com/gregorriegler/cdc-example-typescript).

