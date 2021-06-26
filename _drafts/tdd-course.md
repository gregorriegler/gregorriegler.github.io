# TDD Crash Course in 2 hours.  

## How I got there
I am reading this book: "Training from the BACK of the Room!" and it really resonates with me.
Basically it's all about modern Training, which is interactive and where learners talk more instead of the teacher.
And it's based on the newest neuro scientific research of course.
So essentially, Teachers talk way too much, and they should find ways to have the learners talking instead, so they can connect to the topic, to each other and to what they want to learn.
And this makes the learning more effective.
So i'm taking this advice and adapt my trainings to this idea.

I was recently doing a 2h TDD Crash Course for a group of 5 People and I find that it worked out really well.
And I would like to tell you how I did it. It's a training where the people don't have to prepare anything, they just join the training and participate.
And it works very well remotely.

The 10 minute rule ...

## Training Plan

### Mode ??
I did this all remotely, and it shows in the training plan. However it should be no problem to do this locally, too.

### Group Size
5-6 Participants

### Principles
The principles for this training plan where:
- Just show up.
   Coding sessions often require technical preparations for participants in advance. 
   And when the training starts you somehow always loose those 30 minutes to fix the problems.
   Two Hours is not enough time for having technical troubleshooting.
   So for this training there is no preparation for participants needed.
- Have learners talk the most.
   In most trainings the trainer talks more than 70% of the time, which is not helping learners remembering things.
   Learners learn much better when they are the ones active, when they are talking instead.
   So I want to maximize the amount that learners talk.
- Keep everybody engaged from start to finish.
   No participant should be passive for more than 10 minutes. I want to keep them engaged so they get the most out of their training.
- Learning by doing.
   The Training is designed to have the learners experience TDD in practice.
   This is very important.
   We can explain them what a babystep is, or what the value of fast tests is, but they wont understand unless they experience it themselves.
- Focus on the need to knows.
   TDD is a very broad topic, but the essentials are actually very few.
   Telling everything about it, from history to styles, testdoubles and so on would just confuse the learners.
   Much more effective is to teach them only the essentials, and have them apply the essentials in a practical exercise.
- The 10 minute rule.

### Connections
Two hours is not a lot of time.
So if the group already knows each other, we want to jump right into the topic.
If that's not the case, give them at least the opportunity to introduce themselves in a minute or two.

#### WebHunt
Start with a "WebHunt" activity where each learner has 10 minutes to search the web and find three facts, and to come up with one question they have about TDD. 
Prepare a virtual board where the learners can put and share those.
Then, take another ~10 minutes to review the facts and questions they had put on the board.
I typically have the participants present the facts they had found.

Try to stay out of the discussion as much as possible.
So when somebody states something wrong, instead of correcting it ask the other participants what they think about it.
For the Questions they put on the board, ask the other learners if they have an answer.
Keep in mind that it's not about us (the trainers), it's about the learners.
If you have very good answers that you can back up with quality content such as links to blog posts, articles, books - that's awesome.
Add them in the end.

#### Theory
After that comes the only part of the training that is dry instructions.
Take 10 quick minutes to explain the TDD workflow.

#### Short Break
At this point you are typically 30-40 minutes into the training, so its a good opportunity to have a 5 minute break.
After that we go on to the practical coding part.

#### 60 min Practical Fizz Buzz.
The Kata I choose for this exercise is [FizzBuzz](linkToFizzBuzz), as it is very easy and it can be completed within the available time.
This should help with creating the feeling of having accomplished something.
Als we don't want to confuse learners with a design challenge. 
That's not the focus here.
The focus is on the TDD workflow, and the toughtprocess behind it. 
The decisions we make when we Test Drive a code.
A bit of sugar on top is the possibility to use a Parameterized Test which learners typically find interresting.
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

##### Trainer is the Driver
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

#### 20 min Retrospective

Find out, what the participants have learned that they hadn't known before.
How did they feel doing the FizzBuzz using TDD?
Was there anything they didn't like?
Ask the participants whether they would want to apply it in their real projects, and how.
When they make a commitment like this publicly, the are more likely to actually do it.


## Conclusion
The Crash Course is obviously just the start. 
It will provide the participants with the understanding they need to do further hands on practice.
They should be more comfortable joining a Dojo/Coderetreat.

