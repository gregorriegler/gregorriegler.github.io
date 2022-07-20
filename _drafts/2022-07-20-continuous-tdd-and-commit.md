---
layout: post
title: Continuous TDD and Commit
tags: 
- TDD
---

I recently felt the urge to experiment with my TDD workflow to eventually come up with something better.
I was bored doing so many wasteful manual steps in between like running the tests, making a commit, pulling and pushing it.
I needed to find a way to eliminate the waste and to automate all the things.
My inspiration was mainly coming from continuous testing, limbo on the cheap and tcr. 

Eventually I came up with a thing that drastically increased my commit frequency.
Practicing this way I managed to create *63 commits* in *25 minutes*, where I peaked at *6 commits per minute*. 
At a few points literally every keystroke went live, and they were all working, covered by tests.

The thing I came up with is based on the following Ideas:

- No manual saving (Code saves itself automatically)
- No manual test running (Tests run themselves as soon as a file changes)
- No manual commits (The Code is committed automatically when the tests are green) 
- No manual pull (The Code is automatically pulled prior to test runs)
- No manual push (Every commit is automatically pushed)

I needed proper tooling (the language I was trying this with was Java).

As I use IntelliJ, which is a great great IDE that by the way bugs out some times as of recent *cough*, it already saves my files automatically. So that problem's solved.
For the automated test running I had tried lots of tools throughout the years already. 
There was infinitest for example. Also IntelliJ offers a feature to run the tests automatically, but it's really slow.
So I needed something faster. Incremental Compilation would be key.
Gradle has it, and it's quite fast, so there's that.
Another option would be the quarkus continuous test runner, but it's fairly new and I didn't know how to customize it.
So I went with gradle.

Gradle already has the continuous mode running `gradle -t test`.
However, since I needed to run more things with more control I chose to not use it and use watchexec instead.
The basic Idea is to run `watchexec -e java ./gradlew test`.
watchexec watches for file changes and is just as fast as the gradle continuous test mode.
Maybe a little `clear` in advance so the output is always well aligned and starts at the very top.
With Gradle I can also make my Testoutput pretty using this test-logger plugin. 
TBD Image of tests
I like it.

Now I need to commit as soon as the tests pass. A simple bash script would do, but I like to use a modern task runner for the job.
Don't want to have a complicated script or even scripts laying around. 
A simple configuration file should do.
I'm using just (TBD insert link to just).

```justfile
commit:
    @git add . 
    -@git commit -am "wip"
```

The @ means that the command is not printed.
The - tells just to ignore an error exit code, and just continue.
Why? Because this will enable the case where the tests pass, but I haven't changed anything.
Maybe I added something and deleted it right away.
In that case there would be nothing to commit, ending in an error, aborting the task.
Another way would be to allow those empty commits using the `-allow-empty` flag of git.
But I don't need them, so why have them? It'd be wasteful.

So let's put these commands together in the justfile

```
commit:
    @git add . 
    -@git commit -am "wip"
    
test:
    clear
    @./gradlew test

test-commit:
    just test 
    just commit

tdd-commit:
    watchexec -e java just test-commit
```

Nice! This is already pretty good. 
Now we're able to just code in a TDD fashion.
Small steps.

- start the script `just tdd-commit`.
- write a very simple failing test, tests fail.
- make the the test pass. Changes automatically committed.
- rename the test method. tests pass. Changes automatically committed.
- add another test, tests fail.
- I see I can't make it green as easily, needing a preparatory refactoring.
- disable the failing test. tests pass. Changes automatically committed.
- Making the preparatory refactoring. tests pass. Changes automatically committed.
- Enable the failing test again. Tests fail.
- Make it pass. Changes committed.

During all this I had the test result open on the right hand side.
Seeing my feedback immediately.
Let's take a look at the git history.

* wip
* wip
* wip
* wip
* wip
* wip

Oh, noes. That's not very expressive.
But it wont matter as long as we sneak in descriptive empty commits every once in a while.
We are used to use git messages that describe what we did.
But for this mode I propose to use messages to describe what comes next, our goal that is.
So we need a command to easily add that descriptive commit message inbetween explaining what is going on.
Let's add it.

```justfile
goal MESSAGE:
   @git commit --allow-empty -m "{{MESSAGE}}"
```

That should do the trick.
Now everytime, before I start working on a new goal, I write it to my git history.
The other commit messages stay with 'wip'.
Some of them will be decoded as refactorings by this plugin https://plugins.jetbrains.com/plugin/14704-refactorinsight.
That's ok. Commit messages are overrated anyhow.


One last thing:
Lots of small commits on my computer are great.
But if I work with other people, I need to integrate my changes.
So I want to pull before I run my tests, and I want to push after each commit.

So let's add that to the justfile, too.

```
test-commit:     
    git pull --rebase
    just test    
    just commit  
    git push
```
That should do the trick.
And now we're done. Here's the final file. It also contains a tcr task and some others:
```
goal MESSAGE:
   @git commit --allow-empty -m "{{MESSAGE}}"

commit:
    @git add . 
    -@git commit -am "wip"

test:
    clear
    @./gradlew test
    
test-commit:
    git pull --rebase
    just test 
    just commit
    git push
    
tdd:
    watchexec -e java just test

tdd-commit:
    watchexec -e java just test-commit

revert:
    @git reset --hard &> /dev/null
    @git clean -df &> /dev/null
    @echo -e "\033[0;31m=== REVERTED ==="
    
tcr:
    @just test && just commit || just revert
```
https://gist.github.com/gregorriegler/eafaa74250ff166925296dd58d4e62be

Imagine remote pair or mob programming with this.

TBD: Continuous compilation


This is really continuous. 
It is actually continuous integration.


