---
layout: post
title: Continuous TDD and Commit
tags: 
- TDD
- Continuous Integration
---

# What this is about

I recently felt the urge to experiment with my TDD workflow and eventually come up with something that's better from what I currently do.
The many manual steps I did in between like running the tests, making a commit and writing its message, pulling and pushing it, felt boring already.
I wanted to find a way to eliminate the waste and to automate more.
My inspiration was mainly driven by the idea of continuous testing, [continuous integration](https://martinfowler.com/articles/continuousIntegration.html), [limbo on the cheap](https://medium.com/@kentbeck_7670/limbo-on-the-cheap-e4cfae840330) and [tcr](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864). 
There has to be a way to get actually continuous, and to decrease risk even further.
Integrating at least daily is just not good enough in my opinion.
We need to aim higher.

Eventually I came up with a way that drastically increased my commit frequency.
Practicing this way I managed to create *63 commits* in just *25 minutes* where I peaked at *6 commits per minute*. 
At a few points literally every keystroke went live, and it was all working, covered by tests.

# Actually integrating continuously

The thing I came up with is based on the following Ideas:

- No manual saving (Code saves itself automatically).
- No manual test running (Tests run continuously as they restart automatically as soon as the code changes).
- No manual commits (The code is committed automatically when the tests pass).
- No manual pull (Changes are pulled automatically prior to test runs).
- No manual push (Every commit is automatically pushed to remote right away).

Not a hard to reach goal actually.
I just needed proper tooling and a little bit of scripting.
The language I would be using for this experiment was Java.

# Tooling

As I use IntelliJ, which is a great IDE (that became a little buggy as of recent *cough*), it already saves my files automatically. 
So that problem's solved.
For the continuous test running I had a few options.
IntelliJ already offers a way to run the tests automatically, but it's really slow.
Then there is this IDE Plugin [infinitest](https://infinitest.github.io/), but I needed something for the commandline to be able to script it.
And it should be really fast.
[Incremental compilation](https://en.wikipedia.org/wiki/Incremental_compiler) would be key.
[Gradle](https://blog.gradle.org/introducing-continuous-build) has it, and it's quite fast.
With gradle I could also make my test-report pretty using this [test-logger plugin](https://github.com/radarsh/gradle-test-logger-plugin). 
![Nice test report with the gradle test logger](/assets/nice-test-report.png)
I like that.
Another option would be the [quarkus continuous test runner](https://quarkus.io/guides/continuous-testing) which is fairly new at this time and its test-report is ugly and I don't know how to customize or script it.
So I went with gradle.

On top of the incremental compilation, gradle already ships with a continuous test runner in `gradle -t test`.
But since I need to script it I chose to go with [watchexec](https://github.com/watchexec/watchexec) instead.
The basic Idea is to run `watchexec -e java ./gradlew test`.
Watchexec watches for file changes and then runs the tests.
I made some benchmarks and its just as fast as the gradle continuous test runner.

Next I need to commit as soon as the tests pass. 
A simple bash script would do, but I like to use a modern task runner for the job.
I'm using [just](https://github.com/casey/just) here. 
In case you don't know it its basically a modern *make*.
So you just create one `justfile` and specify your tasks in it.
The commit command with just looks like this.

```justfile
commit:
    @git add . 
    -@git commit -am "wip"
```

To run it you just execute `just commit`.
The @ means that the command is not printed.
By default just exits on an error exit code, whereas the - tells it to ignore it and continue.
I need this so it does not break in the case where the tests pass, but I haven't changed anything.
For example when I added something and deleted it right away.
Then there would be nothing to commit, and `git` would throw the error, leading to `just` aborting the task.
Another way would be to allow those empty commits using the [--allow-empty](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---allow-empty) flag.
But I don't want empty commits for no reason.
Here are the first commands in a `justfile`.

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

## First Try

Now we're able to just code in a TDD fashion.
Small steps.

- Start the script `just tdd-commit`.
- Write a very simple failing test -> tests fail.
- Make the test pass -> changes commit automatically.
- Rename the test method; Tests pass -> changes commit automatically.
- Add another test; Tests fail -> I am shown the failure-report.
- In a first attempt to make it pass I see I can't make it as easily. I need a preparatory refactoring first.
- So I disable the failing test; Tests pass -> changes commit automatically.
- I do the preparatory refactoring; Tests pass -> changes commit automatically.
- I enable the failing test again; Tests fail -> I am shown the failure-report. 
- Make it pass now; Tests pass -> changes committed automatically.

During all this I had not manually done a single save, test run or commit.
The terminal was open on the side so I could see what was happening.
Feedback was immediate.

## A meaningless commit history
Let's take a look at the git history.

* wip
* wip
* wip
* wip
* wip

Whoops, that's not very expressive.
But I value the flow more than the detailed documentation.
And commit messages are overrated anyhow.
Still, I'd like to improve that by sneaking in descriptive empty commits every once in a while.

We are used to use git messages that describe what we did.
But for this mode I propose to use messages that describe whats next; that is the current goal.
So let's add a command to easily create empty yet descriptive commit messages so that we can explain what is going on.

```justfile
goal +MESSAGE:
    git pull --rebase
    git commit --allow-empty -m "{{MESSAGE}}"
    git push
```

That should do the trick.

So from now on, everytime I start working on a new goal, I want to first write it to my git history.
The other commit messages stay 'wip' commits, and I want to push them like this.
One Idea would be to use this little [refactoringinsight plugin](https://plugins.jetbrains.com/plugin/14704-refactorinsight.) to decode the refactoring done in a commit. 

## Let's Integrate
Lots of small commits on my computer are great.
But if I work in a team I need to integrate my changes, too.
I want to pull before I run my tests, and I want to push after each commit.
It's continuous integration, right?

So let's add that to the justfile.

```
test-commit:     
    git pull --rebase
    just test    
    just commit  
    git push
```
And now we're done. 
Here's the final [file](https://gist.github.com/gregorriegler/eafaa74250ff166925296dd58d4e62be). 
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


## Conclusion
Now this is really continuous as in continuous integration. 
And it feels super smooth to work with.
Also it's really that complicated to setup.
Imagine remote pair or mob programming with this.
Easy hand-overs, just exchange the screen-sharing.

Probably some people are already doing it.
And you probably already have an Idea to do this even better.
Please let me know!
