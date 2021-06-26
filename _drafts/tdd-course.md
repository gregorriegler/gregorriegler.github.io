# TDD Crash Course in 2 hours.  

## How I got here

I was recently doing a two hour TDD Crash Course remotely for a group of 5 people and I find it worked out really well.
So I would like to present to you how I did it.

The way I did the training was inspired by the book [Training from the BACK of the Room!](https://www.goodreads.com/book/show/8141935-training-from-the-back-of-the-room) which i'm currently reading, and really resonates with me.
The book is based on the newest neuro-scientific research of course.
It is basically all about modern effective training, which is highly interactive and has an emphasis on learners talking during the training instead of the teacher.

## The Training Plan

### Goal
The goal of this training is to provide the participants with the understanding of and reasoning behind the TDD workflow, 
and to really grasp the thought process and decision making behind it.
It is not a goal of this training to have the participants get good at writing tests.

### Mode 
I did it remotely. 
However, I don't see a reason why it would not work in the same way locally.

### Group Size
5-6 Participants

### Principles
Knowing the principles used for this training will help you understand the reasoning behind its design.

- Just show up.
   Coding sessions often require technical preparations for participants in advance. 
   When the training starts you somehow always loose those 25 minutes to fix all the issues.
   Two Hours is not enough time for having this kind of technical troubleshooting.
   So for this training there is no preparation for participants needed.
   All participants have to do is to show up.

- Have learners talk the most.
   In a traditional training the trainer talks more than 70% of the time, which is not at all helping learners to learn.
   Participants learn much more effective when they are the ones talking.
   So this training aims at maximizing the amount of time that learners talk instead of the trainer.

- Focus on the need to knows.
   TDD is a very broad topic, but the essentials are actually very few.
   Teaching everything about it from history to styles, testdoubles and so on would just confuse the learners.
   Much more effective is to teach them only the essentials, and have them apply those in a practical exercise.

- Keep everybody engaged from start to finish.
   No participant should be listening passively for more than 10 minutes. 
   We want to keep them engaged so they get the most out of their training.

- Learning by doing.
   The training is designed to have the learners experience TDD in practice.
   This is very important.
   We can explain what a babystep is, or what the value of a fast testsuite is, but it wont make any sense unless they experience it themselves.

- The 10 minute rule.
   This is about optimizing for how long learners are able to keep up their attention while being passive.
   TV has conditioned us to receive information in small segments of ~10 minutes in length.
   We want to avoid direct instruction but when we do it, it should take no longer than 20 minutes. 
   The shorter the better.

### Opening: WebHunt (20-30 minutes)
Two hours is not a lot of time.
If the group already knows each other, we want to jump right into the topic.
When that's not the case, give them at least the opportunity to introduce themselves in a minute or two.

Start with a "WebHunt" activity where learners have 10 minutes to search the web and find three facts, and to come up with one question they have about TDD. 
Prepare a virtual board where the learners can put and share their findings.
Then, take another ~10 minutes to review the facts and questions they had put on the board.
Have the participants present them, and try to stay out of the discussion as much as possible.
When somebody states something wrong instead of correcting it ask the other participants what they think about it.
For the questions they put on the board, ask the other learners whether they have an answer.
Keep in mind that it's not about us (the trainers), it's about the learners.
If you have very good answers that you can back up with quality content such as links to blog posts, articles, talks or books - that's awesome.
Add those in the end.

### Theory (10 minutes)
After that comes the only part of the training that is dry instruction.
Take 10 quick minutes to explain the essentials of the TDD workflow.
That is the rules, and the reasoning behind it.

### Short Break (10 minutes)
At this point you are typically 30-40 minutes into the training, so its a good opportunity to have a 10 minute break.
After that we go on to the practical coding part.

### Practical Fizz Buzz (60 minutes)
The Kata I choose for this exercise is [FizzBuzz](linkToFizzBuzz), as it is very easy and it can be completed within the available time.
This should help with creating the feeling of having accomplished something.
Also we don't want to confuse learners with a design challenge, that's not the focus here.
The focus is on the TDD workflow and the thought process and decision making behind it. 
A bit of sugar on top is the possibility to use a parameterized test which learners often find interresting.
The kata is being worked on in a mob (eg 5 Participants).
As we like to keep every participant actively engaged we assign them roles that require them to stay focused.

Choose 3 people and assign them one of these referee roles:
RED Referee: Responsible to make sure we watch each test fail, and that the error presented is expressive.
GREEN Referee: Responsible to make sure we only write the simplest code to fulfill the test, but not the line we know we need to write.
REFACTOR Referee: Responsible to make sure we always refactor in the green and only in the green.

Have the other participans be collaborative navigators.

Instruct participants to have their mics on!
Sometimes people turn their mics off at other meetings which is fine.
But in this training, this can be harmful. 
If somebody starts talking with their mic off we wont notice if we stare at the code, we'd like to avoid that.

After half-time ask your participans whether they would like to rotate their roles.

#### Trainer is the Driver
The trainer is the [Driver/Typist](link to driver/navigator strong style pairing). 
Writing tests by their selves is another important exercise for learners, but it is not the focus of this training.
The focus of this training is to have learners grokk the workflow of TDD, to learn the decisions we make when we have tests drive our design in very small steps.
And to achieve that, we would like to remove all other impediments.
So the trainer plays the smart input device that makes it easy for the learners to write the tests that they want.
As a driver, the trainer is also able to step in if needed. 
So the trainer shares their screen, test setup prepared with the FizzBuzz rules as a comment on the dummy Test, font size set very large and test results very visible.
Remember, the goal of the trainer is to stay in the background as much as possible.
They might chime in to get things going, but mostly to ask the right questions and delegate control to the participants.

As a Trainer I might say: "I only type when you navigators tell me to".
Or: "What would be an even simpler test case to start with?"
When you see something you are not satisfied with, play the ball to the responsible referee role: "GREEN, what do you have to say about this?",
"REFACTOR, Is it okay that we do this refactoring now?"

### Retrospective (10-20 minutes)
Find out, what the participants have learned that they hadn't known before.
How did they feel doing the FizzBuzz using TDD?
Was there anything they didn't like?
Ask the participants whether they would want to apply it in their real projects, and how.
When they make a commitment like this publicly, the are more likely to actually do it.


## Conclusion
The crash course is obviously just the start for the learners. 
It will provide them the understanding they need to do further hands on practice.
From then on they should feel more comfortable joining a dojo/coderetreat.

Did you like the training design? 
Which parts did you not like?
How are you teaching TDD?
Leave me a comment.
