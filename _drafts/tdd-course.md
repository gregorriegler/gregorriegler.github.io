# TDD Cash Course from the back of the room in 2 hours.

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

I did this all remotely, and it shows in the training plan. However it should be no problem to do this locally, too.
My Principles for this Training Plan where:

- No preparation for participants needed.
- Have learners talk the most.
- Keep everybody engaged from start to finish.
- Learning by doing.
- Focus on the need to knows.
- The 10 minute rule.

### Connections
Two hours is not a lot of time.
So if the group already knows each other, you'd want to jump right into the topic.
If that's not the case, give them at least the opportunity to introduce themselves for a minute or two.

#### WebHunt
Start with a "WebHunt" activity where each learner has 10 minutes to search the web and find 3 facts, and to think of 1 question they have about TDD. 
Prepare a virtual board where the learners can put and share their findings.
Then, take another ~10 minutes to review the facts and questions they had put on the board.
I typically have the participants present the facts they had found.
When somebody states somthing questionable, ask the other participants what they think about it.
Try to stay out of the discussion as much as possible.

For the Questions they put on the Board, ask the other learners if they have an answer for them.
If you have very good answers that you can even back up with weiterführenden Links of high quality content, that's awesome.

After that, take quick 10 minutes to explain how the TDD Workflow works.
This is the only part of the whole training that is dry instructions by the trainer, but it's just 10 minutes long so.

After that you could make a quick 5 minute break, because after that we go on to the Kata and Coding Part.

#### 10 min intro to the kata and the rules.
The Kata I choose is FizzBuzz, because it is very easy. 
--link to FizzBuzz Kata--
I don't want to confuse learners with a design challenge, that's not the focus here.
The focus is on the TDD process.
A bit of sugar on top is the possibility to use Parameterized Tests which could be interresting to learners, too.
So I first teach them the rules of FizzBuzz, and then I tell them how this is going to work out.

#### 60min Practical Fizz Buzz.

The kata is being worked on in a mob (eg 5 Participants).
We like to keep every participant actively engaged throughout the session so we organize it so that every learner has an important Role that needs to stay focused.

Choose 3 people and assign them one of these roles:
RED Referee: responsible to make sure we watch each test fail, and that the error is clear.
GREEN Referee: responsible to make sure we don't write a single line of code that doesn't fulfill a test.
REFACTOR Referee: responsible to make sure we always refactor in the green, and only in the green.

You can have the other participans be Navigators.

##### Trainer is the Driver
The trainer is the Driver/Typist (link to driver/navigator strong style pairing). 
Writing tests by their selves is another important exercise for learners, but it is not the focus of this training.
The focus of this training is to have learners grokk the process of TDD, to learn the decisions we make to have tests drive our design in many very small steps.
And to achieve that, we would like to remove all other obstacles.

So the trainer makes it easy for the learners to write the tests they want.
Another advantage of the trainer being the driver is that they can step in when needed (even though the goal would be to avoid that).
So the Trainer shares their screen, Test Setup Prepared with FizzBuzz Rules as a comment on the dummy Test, font size set very large, test results very visible.
The Trainer is the Driver so they can jump in to have the final word just in case. But the Goal of the trainer is to not take any control. 
As a Trainer I usually say: "I only type when you navigators tell me to".
And when you see something smelly going on which you are not satisfied with, play the ball to the Referee: "GREEN, what do you have to say about this?"
"REFACTOR, Is it okay that we do this refactoring now?"

###### Important Details
Instruct participants to have their mics on!
Sometimes people turn their mics off at other meetings which is fine.
But in this training, this can be harmful. 
If somebody starts talking with their mic off we wont notice if we stare at the code.
And we'd like to avoid that.

After half-time you ask your participans whether they would like to rotate their roles.


After that 20 min Retrospective.
Find out, what the learners have learned what they haven't known before.
How they felt doing the FizzBuzz in TDD?
And if there was anything they didn't like, a.k.a. "Meh"

The only downside I feel I had in this training, is that the learners weren't typing at all.
But after this Crash Course I feel that they understand the workflow, and they are ready to practice it on their own or collaboratively in a Dojo/Coderetreat.

Commitment on retrospective (say out loud your plans, makes you more likely to actually do them)
