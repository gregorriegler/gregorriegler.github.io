---
layout: post
title: TDD Crash Course from the BACK of the Room
tags: 
- TDD
- Training
---

I was recently giving a 2 hour TDD crash course remotely for a group of 5 people, and I find it worked out wonderfully!
So I would like to share with you how I did it.

**If you were searching for TDD guidance, this is not it!
It is rather a guide on how to run a TDD crash course.**

I recently read the book *[Training from the BACK of the Room!](https://www.goodreads.com/book/show/8141935-training-from-the-back-of-the-room)*, which resonated with me, and it inspired how I ran the course.
The book is highly innovative and turns traditional training upside down.
The emphasis is on learners being active and talking more during the training instead of the teacher.

## The Training Plan

### Goal
The goal of this training is for participants to understand TDD and be able to practice the red-green-refactor cycle themselves.
It is not a goal of this training to make TDD pros that can test drive their whole projects.
While TDD is easy to start with, it is also hard to master.
To get better, learners will need much more hands-on practice after the training.
The course should provide participants with a smooth start on their learning journey.

### Mode 
I did it remotely. 
However, I don't see a reason why it would not work in the same way locally.

### Group Size
5-6 Participants.

### Principles
Knowing the principles I used for this training will help you understand the reasoning behind its design.

- **Just show up.**
   Coding sessions often require technical preparations for participants in advance. 
   When the training starts, you somehow lose those 25 minutes to fix the issues every time.
   Two hours is not enough time for having this kind of technical troubleshooting.
   So for this training, there is no preparation for participants needed.
   All participants have to do is to show up.

- **Focus on the need to knows.**
   TDD is a broad topic, but the essentials are few.
   Teaching everything from history to styles, test doubles, and so on would merely confuse the learners.
   So in this training, we focus only on the essentials.

- **[Learning by doing](https://en.wikipedia.org/wiki/Learning-by-doing).**
   The training will have the participants experience TDD in practice, which is very important.
   We could explain what a [baby step](http://www.thinkcode.se/blog/2019/05/18/what-is-the-size-of-a-baby-step) is and what the value of a fast test suite is.
   Still, learners won't understand unless they experience it themselves.

- **Have learners talk the most.**
   In traditional training, the trainer talks more than 70% of the time, which doesn't help learners learn.
   Participants learn much more effectively when they are the ones talking.
   So this training aims at maximizing the amount of time that learners talk instead of the trainer.

- **Keep everybody engaged from start to finish.**
   No participant should be listening passively for more than 10 minutes at a time. 
   We want to keep them engaged to get the most out of their training.

- **The [10-minute rule](https://trainingindustry.com/articles/content-development/facilitating-according-to-the-10-minute-rule/).**
   The 10-minute rule helps us to optimize for the approximate attention span of people.
   TV has conditioned us to receive information in small segments of ~10 minutes in length.
   After 10 to 20 minutes, learning begins to diminish.
   So we want to avoid dry instruction that lasts longer than that.

- **[Psychological safety](https://en.wikipedia.org/wiki/Psychological_safety).**
   Create an environment where participants feel comfortable to express their opinions without the fear of being wrong.
   We don't want them to be afraid of making mistakes, so we don't punish those.
   Instead, reward every form of contribution from the very beginning.
   Whatever learners have to say: Unless it's not abusive, it's not wrong - it's interesting.


### Start-Up
Two hours is not a lot of time.
If the group already knows each other, we want to jump right into the topic.
When that's not the case, give them at least the opportunity to introduce themselves in a minute or two.
I like to use one of the following Start-Up activities.

#### Start-Up Activity: Web Hunt (20-30 minutes)
Start with a "Web Hunt" activity where learners have 10 minutes to search the web and find three facts and come up with one question they have about TDD. 
Prepare a virtual board where the learners can put and share their findings.

Then, take another ~10 minutes to review the facts and questions they had put on the board.
Have the participants present them, and try to stay out of the discussion as much as possible.
When you are not satisfied with one of the facts, ask the other participants what they think about it.
Try to have the learners answer all the questions on the board.
If you have some great answers that you can back up with quality content such as links to blog posts, articles, talks, or books - that's awesome.
Add those in the end.

Keep in mind that it's not about us (the trainers). It's about the learners.

#### Alternative Start-Up Activity: What do you already know? (20-30 minutes)
Give learners 10 minutes to think of three facts they already know about TDD and have them put those on a virtual board for everybody to see.
Then, take another ~10 minutes to have participants present the facts they had put on the board.
When you are not satisfied with one of the facts, ask the other participants what they think about it.
This activity connects learners to the things they already know.
Typically, developers have already heard at least something about the topic.
When they connect to these things first, it will help them evaluate what they had learned in the training.

### Theory (10 minutes)
After that comes the only part of the training that is dry instruction.
Take ten quick minutes to explain the essentials of the TDD workflow.
The [three rules of TDD](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd) provide a good start, but you probably want to explain the whole workflow.
This [wiki page](https://wiki.c2.com/?TestDrivenDevelopment) gives a nice overview of all the steps involved.

### Short Break (10 minutes)
At this point, we are typically 30-40 minutes into the training, and it's an opportunity to have a 10-minute break.
After that, continue with the practical coding part.

### Practical FizzBuzz (60 minutes)
The kata I choose for this exercise is [FizzBuzz](https://kata-log.rocks/fizz-buzz-kata), as it is pretty simple and can be completed within the available time.
It should help with creating the feeling of having accomplished something which makes the learning stick longer.
Also, we don't want to confuse learners with a design challenge.
That's not the focus here.
The focus is on the TDD workflow and the thought process and decision-making behind it. 
A bit of sugar on top is the opportunity to use a [parameterized test](https://www.petrikainulainen.net/programming/testing/junit-5-tutorial-writing-parameterized-tests/), which learners often find interesting.
The kata is being worked on in a special [mob](https://mobprogramming.org/mob-programming-basics/) where everybody is assigned a specific role.

#### Roles: Red / Green / Blue / Navigator
As we like to keep all participants engaged, we assign each a responsibility that requires them to stay focused. Choose three people and assign them one of these referee roles:

- **Red Referee**: This role is responsible to make sure we watch each test fail and that the error presented is useful and expressive.
- **Green Referee**: Watches out that we only write the simplest code to fulfill the test, but not the line of code we know we'd need to write.
- **Refactor Referee**: Makes sure we always refactor in the green and only in the green.

The other participants are navigating collaboratively. Take a look at [strong style pairing](https://llewellynfalco.blogspot.com/2014/06/llewellyns-strong-style-pairing.html) to understand the Driver/Navigator relationship.

After half-time, ask your participants whether they would like to rotate their roles.

#### The Trainer is the Driver
The trainer is the Driver/Typist.
Writing down test cases is another important exercise for learners, but it is not the focus of this training.
The focus of this training is to have learners grok the workflow of TDD. 
To learn the decisions we make, when we have tests drive our design in tiny steps.
And to achieve that, we would like to remove all other impediments.
So the trainer plays the smart input device that makes it easy for the learners to write the tests they want.
As a driver, the trainer is also able to step in and take control if needed. 

The trainer shares their screen, test setup prepared with the FizzBuzz requirements as a comment on the dummy test, font size increased, and test result visible.
Remember, the goal of the trainer is to stay in the background as much as possible.
She might chime in to get things going but mostly asks the right questions and delegates control to the participants.

As a trainer, you might say: "I only type when you navigators tell me to.",
or: "What would be an even simpler test case to start with?"
When you see something you are not satisfied with, play the ball to the responsible referee: "Green referee, what do you have to say about this?",
"Refactor referee, Is it okay that we do this refactoring now?"

Instruct participants to have their mics on!
Sometimes people turn their mics off when they are in video calls which could be harmful in this training.
When everybody is starring at the code, we won't notice when somebody starts talking with their mic off.

### Retrospective (10-20 minutes)
Find out what the participants have learned that they hadn't known before.
How did they feel doing FizzBuzz using TDD?
Was there anything they didn't like?
Ask the participants whether they would want to apply it in their real projects and how.
They are more likely to do so, when they commit to it publicly.

## Conclusion
It's astonishing how much you can still teach after getting out of the way.
Of course, the crash course is just the start for the learners. 
It will provide them with the prerequisites to have more hands-on practice.
After the training, they should feel more comfortable joining a dojo/code retreat.

Did you like the training design? 
Which parts did you not like?
How are you teaching TDD?
Leave me a comment.
