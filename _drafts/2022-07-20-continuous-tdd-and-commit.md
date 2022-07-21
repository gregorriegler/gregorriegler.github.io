---
layout: post
title: Not Continuous Enough !!!1
tags: 
- TDD
- Continuous Integration
---

# Not continuous enough !!!1

I recently felt the urge to experiment with and improve my TDD workflow.
The many manual steps I did like running the tests, starting a commit, writing a commit message, pulling, pushing it ... phew ... BORING!
I wanted to eliminate all the waste and to automate this stuff.
My inspiration was mainly coming from the idea of continuous testing, [continuous integration](https://martinfowler.com/articles/continuousIntegration.html), [limbo on the cheap](https://medium.com/@kentbeck_7670/limbo-on-the-cheap-e4cfae840330) and [tcr](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864). 

We're not aiming high enough with the continuous part. 
Integrate at least daily? ... Come on!
Hourly? ... We can do better than this.
Short lived Feature Branches? ... You got to be kidding. Rather *short lived lies*.
Non of this is continuous.

We need to get better and decrease risk even further.

# Actually continuous

Eventually I came up with a way that drastically increased my commit frequency.
Practicing this way I managed to create *63 commits* in just *25 minutes* where I peaked at *6 commits per minute*. 
Yes it was just a kata, but that's not important.
At many occasions literally every keystroke went live, and it was all working - covered by tests.

What I did is based on the following requirements:

- No manual saving. (The code saves itself automatically)
- No manual test running. (Tests run continuously. They restart automatically as soon as the code changes)
- No manual commits. (The code is committed automatically when the tests pass)
- No manual pull. (Changes are pulled automatically prior to test runs)
- No manual push. (Every commit is automatically pushed right away)

Not that hard to achieve actually.
Just need proper tooling and a little bit of scripting.
The language I'm trying this with is Java.

# The right tools for the job

Since I use IntelliJ which is a great IDE (*cough* it became a little buggy as of recent *cough*), it saves my code automatically. 
So that problem's already solved.
For the continuous test running I know a few options.
IntelliJ already offers a way to trigger the tests automatically, but it's really slow.
Then there's this plugin [infinitest](https://infinitest.github.io/). 
But I want something for the cli so I'm able to script it, and it should be really fast.
[Incremental compilation](https://en.wikipedia.org/wiki/Incremental_compiler) would help with the need for speed.
[Gradle](https://blog.gradle.org/introducing-continuous-build) has it, and it's quite fast.
With gradle I could also make the test-report pretty using this [test-logger plugin](https://github.com/radarsh/gradle-test-logger-plugin). 
![Nice test report with the gradle test logger](/assets/nice-test-report.png)
I like that.
Another option would be the [quarkus continuous test runner](https://quarkus.io/guides/continuous-testing) which is fairly new at this time and its test-report is so ugly.
Also I have no idea how to customize or script it.
So I'm going with gradle for now.

On top of the incremental compilation gradle ships with a continuous test runner in `gradle -t test`.
But since I need more control I chose to use a little helper tool called [watchexec](https://github.com/watchexec/watchexec) instead.
It watches for file changes and then executes some command.
Like this: `watchexec -e java ./gradlew test`.
I made some tests and its just as fast as the gradle continuous test runner.
If you'd like even more control and more lines of script-code, you could also use [inotifywait](https://linux.die.net/man/1/inotifywait).
I however like to keep it as simple as possible.

Next I needed to commit as soon as the tests pass. 
A simple bash script would do, but I like to use a modern task runner for the job.
I settled with [just](https://github.com/casey/just). 
In case you don't know it, its basically a modern version of *make*.
And it's written in rust to whoever that may concern.
The way this works is you just create a `justfile` and specify your tasks in it.
The commit command looks like this.

```justfile
commit:
    @git add . 
    -@git commit -am "wip"
```

Simple and concise. 
To execute it you hit `just commit`.
And I don't even have to remember.
My shell courteously suggests me the available command.
The `@` means that the command is not printed.
By default just exits on an error exit code, whereas the `-` tells it to ignore that and continue.
I need this for the case where the tests pass but I haven't changed anything.
For example when I added something and delete it right away.
Then there would be nothing to commit, and `git` would throw the error, having just abort the task.
I could also the empty commit using the [--allow-empty](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---allow-empty) flag.
But why allow an empty commit for no reason!?
That'd be inventory, wasteful.

So here are the first commands in a `justfile`.

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

Nice! I like it.

## First Try
Now we're able to give it a try.
Small steps.

- Start the script `just tdd-commit` in a terminal that stays visible next to the IDE.
- Write a very simple failing test. -> Tests fail. The test failure is showing in the terminal immediately.
- Make the test pass. Nicely formatted test report is shown immediately. Changes commit automatically. 
- Rename the test method; Tests pass. -> Changes commit automatically.
- Add another test; Tests fail. -> I am shown the failure-report.
- In a first attempt to make it pass I notice I can't make it as easily. I need a preparatory refactoring first.
- So I disable the failing test; Tests pass again. -> Changes commit automatically.
- I do the preparatory refactoring; Tests pass. -> Changes commit automatically.
- I enable the failing test again; Tests fail. -> I am shown the failure-report. 
- Make it pass this time; Tests pass. -> Changes committed automatically.

Wow, this felt smooth.
During all of this I had not manually done a single save, test run or commit.
The terminal was open on the right hand side and I got that feedback immediately, continuously.

## A meaningless commit history
Let's take a look at the git history.

* wip
* wip
* wip
* wip
* wip

Whoops, that's not very expressive.
But honestly, I think that the flow might have more value than the documentation of the git history.
Still, I'd like to improve on that by sneaking in descriptive empty commits every once in a while.
We are used to write git messages that describe what we did, and I could do that here, too.
But for this I would like to propose a different way. 
A new way.
I want to use a commit message to describe whats next; In other words: What my current goal is.
So let's add a command to create those descriptive commits.

```justfile
goal +MESSAGE:
    git commit --allow-empty -m "{{MESSAGE}}"
```

So from now on, everytime I start working on a new goal, I want to first write it to my git history.
Something like `just goal MarsRover can turn`.
The other commit messages would stay 'wip' commits and that's fine.
One Idea would be to use tooling to decode some of the refactoring commits.
For example the [refactoringinsight plugin](https://plugins.jetbrains.com/plugin/14704-refactorinsight).

## What about the Integrate part?
Lots of small commits on my computer are nice.
But if I work in a team I need to integrate my changes.
So I want to pull before I run my tests, and I want to push after each commit.
It's called continuous integration for a reason, right?

Let's add that to the justfile.

```
integrate:     
    git pull --rebase
    just test    
    just commit  
    git push
```
And I think we're done. 

This is complete [file](https://gist.github.com/gregorriegler/eafaa74250ff166925296dd58d4e62be). 
It also contains a tcr task.

```
goal +MESSAGE:
    git pull --rebase
    git commit --allow-empty -m "{{MESSAGE}}"
    git push

commit:
    @git add . 
    -@git commit -am "wip"

test:
    clear
    @./gradlew test
    
integrate:
    git pull --rebase
    just test 
    just commit
    git push
    
tdd:
    watchexec -e java just test

ci:
    watchexec -e java just integrate

revert:
    @git reset --hard &> /dev/null
    @git clean -df &> /dev/null
    @echo -e "\033[0;31m=== REVERTED ==="
    
tcr:
    @just test && just commit || just revert
```


## Conclusion
Notice how I renamed the `tdd-commit` task to `ci`.
Continuous Integration is not about what the build server does, it's about what we do.
Coding with this script feels super smooth to work with. 
It's actually continuous.
Also it's really not that complicated to setup.

Imagine remote pair- or mob programming with this.
Eeeaaasy hand-overs, just exchange the screen-sharing while the tests pass.

Probably some people are already doing it this way? Let me know!


