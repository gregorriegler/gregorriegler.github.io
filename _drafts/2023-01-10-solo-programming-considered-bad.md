---
layout: post
title: Solo Programming Considered Bad
tags: 
- Mob Programming
---

I was recently following an interesting discussion of the vienna software crafts community with the title "[How to facilitate a conversation between people, where the byproduct is code?](https://github.com/swkWien/sessions/issues/105)". 
The discussion is held in german, and contains interesting questions and ideas regarding how to code well together and how to facilitate it. 
My Answer got longer and longer, so eventually I decided to write this blog post over answering directly.

## Solo Programming considered bad

> A programmer is a person sitting solo in front of their computer, typing rapidly on their keyboard.
A well known stereotype. You have seen the movies.

Turns out solo programming is quite bad. 
No, I'm serious.
Let's be honest, we're not good at it.
We tend to overcomplicate things, and we make a lot of mistakes.
We rarely understand the problem that needs to be solved, and we don't know our tools well.
Let's face it, we're not that good at programming.
We often end up with crufty code that's not as simple as could be, doesn't work, and addresses the wrong problem.

But hey, don't worry.
We don't mean to.
We do try hard to live up to the expectations.
And we are working to the best of our knowledge.
We're still learning, it's just hard. 🤷‍♂️

## Coding Together As An Answer
Collaborative coding can greatly improve the situation.
By bringing together multiple people with different skills and perspectives we can achieve a deeper understanding of the problem and develop a superior solution.
We can take on different roles and complement each other.
With multiple people working together, there are more eyes to catch bugs and more knowledge of our tools and valuable techniques and practices. 
Collaborative coding is proven to solve complex problems better and more quickly.
We stumble upon those all day while working on simple programs.
The mere learning and knowledge gained from working in a team can already make up for the cost of the collaboration.


![Remote Mob Programming](/assets/mob-programming/remote-mob-programming.png "Image Caption")
*» A team coding together remotely.*

## Coding Together Isn't Easy
Coding together, also known as "Mob Programming" or "Ensemble Programming" is challenging.
It's not simply a matter of one person typing while others observe in silence.
In order to make it work, it's important for all team members to actively engage and collaborate. 
This enables us to utilize all of our minds and build the shared understanding we strive for.
Also, we want to reach a flow state and make continuous progress.
Mob Programming, thus working as an actual team, is a deliberate practice.

### Shared Understanding
It's important to ensure that everyone is on the same page and no one is left behind.
This requires patience, effective communication, and the willingness to listen and explain ideas.
Communication is challenging, but it's a skill we can improve through practice. 
Speak slowly and use simple language. 
Meet the people where they are. 
Use metaphors to help build understanding. 

### So, It's All About Human Interactions
Be kind, and treat each other with [consideration and respect](https://www.youtube.com/watch?v=oq42E51Ufnk).
Make people feel safe to contribute and to welcome and reward all forms of contribution, including questions.
It is ok to not know something or to not get it.
Be a hero and ask the first question so others feel more safe in doing so, too.
Reward a contribution, especially when the person feels self-conscious about it.
Be open to considering and evaluating potentially disruptive ideas, even if they come up suddenly.
Creating a supportive environment that encourages people to contribute will help to ensure that the best ideas and insights from all team members make it into the code.
Seems like the social skills are where it's at.
Has programming been the easy part all along?

### Agree On A Shared Goal
With many different ideas being shared, it can be challenging for a team to agree on a shared goal. 
Which is yet another team-skill to master.
It's important to be open to stepping back and trying out someone else's idea. 
It's okay to try multiple approaches and see which one works best. 
By being open to different ideas and perspectives, a team can learn and grow together.

### Knowing When To Speak
It's important for everyone to feel comfortable speaking up and sharing their ideas. 
However, it's also important to know when to hold back and listen to others. 
One way to manage this is by keeping a private backlog of ideas that come to mind but may not be relevant at the moment. 
This can help to focus on the task at hand while still being able to capture and consider other ideas for later. 
Developing the ability to know when to speak up and when to hold back is an important skill for effective collaboration.

## Distributing Roles
A logical first step is to distribute participants by what they do.
Somebody needs to type the code, of course. 
A common name for this role is the "Driver" as in the Driver/Navigator relationship of "[Strong Style Pairing](http://llewellynfalco.blogspot.com/2014/06/llewellyns-strong-style-pairing.html)".
I commonly notice people confuse the names of these two roles, so I prefer to call them "Typist" and "Talker" instead.

### The Role Of The Typist
We do not want the typist to just hack away.
If they did, other participants could merely descipher the then buggy code and make faulty assumptions.
Terribly inefficient.
We want the typist to exercise on the instructions of the team.
Being a typist is hard. 
With contradicting ideas they get overwhelmed.
What should they focus on?
We may solve this problem by instating a designated talker.
It's not the only person talking, but they act as the primary input channel for the typist and filters all ideas and makes the final decision.
So even though many things are said, the typist knows which voice to focus on.

#### A Typist Translates
It's a common misconception that the typist stupidly types the code they've been told to type, word by word, character by character. 
Actually, the typist has a lot of thought and decisions to make.
For example: They can run the the tests whenever.
They translate the high level intent of the talker into code, so that the talker can stay on the level of their thinking.
The typist takes care of the details.
This takes a big burden of the talker.
I mean, typing itself is already quite a challenge. 
Knowing your tools well and being good at it is an art. 
Being able to translate the high level intent on top of that is the icing on the cake.

#### Typist Wrapups
A technique I learned at the python approvals mob that improves feedback and shared understanding are typist wrapups.
It means that a typist does a quick explanation of what just had happened and what they did after each rotation.
When a typist explains this in their own words this tends to reveal and solve misunderstandings.

### Being A Talker Isn't Easy Either
So the talker is the actual person programming.
The typist sort of acts as a smart input device for them.
A talker should communicate their thinking.
In other words, they should think out loud.
There's a lot of stages of thinking we go through.
First, we orient ourselves with the current situation - the context.
Second, we envision where we want to go from here - a direction.
Third, we formulate a concrete intent - still on a high level.
This is already what a typist could work with.
Only then we go to the low level details: What actual code to type on what line, Syntax, Code Formatting, Keystrokes to use, Buttons to click, etc.
Every stage of thought is shared with the team.
The talker instructs the typist on the level they can operate on.
The higher, the better. 
Sort of like limbo: How high can you get? 

### Rotation
Everybody should get to type and talk.
This keeps everybody engaged.
When deciding on the rotation interval, think how long it would take for the same person to become typist again.
One hour of waiting to become typist again is probably too much.
It's hard for people to keep up their attention for this long.
Rotating every 2 or 3 minutes works really well, but you have to be able to do it swiftly.
Work hard on getting your rotation time down.
The rotation time is the time between initiating a rotation, and the next typist/talker being able to continue.
The perfect rotation time is 0.

#### Rotations Need Trust
Giving up control can be tough.
As a talker, you not only want to keep the direction of the previous talker, you also need to trust the next talker to do the same. 
Trust them to continue the idea you were working on.
Without trust, rotations bog down which prevents flow.

## Find Out What Works For Your Mob
As stated previously, coding together is a deliberate practice.
You want to keep improving the way you work together.
No preexisting rules, or framework will make that happen.
You'll need to find your working agreements for yourself.
Regular retrospectives are key in this regard.
Do them at least daily.
A two hour mob-programming-session can lead to a three hour retrospective which is superb.
The learning can be massive.
But it doesn't have to be this long.
Do them short, a few minutes maybe, but regularely.
Use them to find out what worked well for you, and turn that up.
Turn up the good.
Keep innovating and find out what you would like to try.
The retrospective is about learning and about change.
Use it, act on its results.

### Microretro
A minimal yet nice format for a retro is a microretro. 
It just takes a few minutes and you can do it at least once a day.
Maybe every few hours even.
In that retro ask two questions: 
1.) How did that feel?
2.) What worked well?
3.) What would you like to try?

## Facilitating a Mob
Start simple.
People new to Mob Programming will already be overwhelmed by the mere socialness of this way of working.
All of a sudden they get to talk their ideas in front of other people.
They're not used to being exposed while typing code either.

It will take some time until they get used to this way of working and to have some spare space up in their minds to keep a protocol intact.
So you want the initial protocol to be absolutely minimalistic, and to guide it so they don't have to.
Too many rules would throw them off the rails.
The less rules you can get away with, the better.
But make the mob do everything by themselves, so they can become autonomous quickly.
Remind people to be patient and to treat each other with kindness, consideration and respect.
Be a role model in the way you treat them.

>Tip: Do not join a mob as a facilitator. 
>Both roles can easily conflict with each other.
>It is better to stay out and behave as a neutral mediator. 


### Further Links

- [Mob Mentality Show](https://www.youtube.com/channel/UCgt1lVMrdwlZKBaerxxp2iQ)
- [Mobbing Discussion](https://www.youtube.com/watch?v=ZnyBoz7wMD0&list=PLzmKmecq34A9rH7MMUYzFjXdV0jdwQoGh&index=7&ab_channel=TsvetanTsvetanov)
- [Resource Collection on Mob Programming and Software Profession](https://trello.com/b/1lfMkCOh/software-profession-resources)
