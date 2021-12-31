---
layout: post
title: Running a Coding Dojo
tags: 
- Coding Dojo
---

Two years ago in 2019 I ran the first Coding Dojo at my company [ebcont](http://www.ebcont.com). 
Corona wasn't a thing back then, so it happened to be an offline event that lasted 4 hours on a thursday afternoon. 
All the brilliant people came together in the same location to practice coding fundamentals and enjoy themselves.
How awesome is that?
A lot has changed since then. 
When the pandemic happened I had to adapt and turn it into an online event.
I decided to make it a whole day thing and started doing it on a regular basis.
Luckily I had already collected plenty of experience from my friends at the [Vienna Software Crafts Community](https://www.softwerkskammer.org/groups/wien) where we regularely run Coderetreats in a similar fashion.

The ebcont coding dojo turned out to be a success story.
When I started it I had approximately 10 people join, many of which are now regular attendees.
But lately, there was a small hype around the event.
People liked it so much, they came up with the Idea to create a Coding Dojo T-Shirt and shoot a group photo with it.
Of course, we did so.
I had 25 employees join in the latest event, and it was a lot of fun.
*Insert Group Photo*

##Coding Dojo???
So what is a Coding Dojo, how do I do it and what can you take away from my experience?
The term [Dojo](https://en.wikipedia.org/wiki/Dojo) originates in japan and stands for a training facility where they perform katas, 
choreographed patterns of martial art movements designed for practice.
A [Coding Dojo](https://codingdojo.org/WhatIsCodingDojo/) is a similar thing, we just performing coding katas.
It is a great opportunity to practice the widely underrepresented but fundamental technical skills like TDD, design and refactoring.
Invaluable skills that are mostly not taught in school and left behind the things that turned out to have higher demand: Tools and frameworks. 
The thing is: Under pressure we fall back to old habits, even if they'll lead to worse outcomes.
We better take our time to practice and get more comfortable in these fundamentals. 
So that when it counts, we will be confident to apply them.
This is where the Dojo comes in, a space for developers to do just that: Practice the fundamentals of programming, away from the pressure of getting things done.
While the traditional Coding Dojo is a short ~2 hour event, the one I do lasts almost a whole day.

##But why not full day?
I had the experience that an intense full day practice event can become tiring in the end.
Closing sooner leaves the participants with more energy in the final retrospective and the evening after the event.
There are similar whole-day events in the name of coderetreat and mobretreat.
The classical coderetreat has the notion of throwing away your code after a timeboxed session, and to start from scratch with a different pair.
So you don't finish, but get to see different perspectives within a short time - quite intense.
That's a little different from what I do.
I like to provide the participants the opportunity to dive deeper into a kata, so we stay within the same teams and exercise throughout the day.
This reduces the relative amount of setup time which allows us to get more coding done.
And when you manage to accomplish something, learning tends to stick longer.

## The Dojo Plan
I decide on the topic and kata in advance, taking the attendees skill levels into account.
Prior to the event I send them information about what we're gonna do.
The Dojo starts with a short welcome where we have a few minutes of smalltalk before the intro session begins.
In the intro session we discuss the topic and kata we will be working on.
I also like to walk over a minimum of theory that everybody should understand.
The most effective way to do this is to just keep throwing questions at the group, and have them provide the answers themselves.

## Balancing Teams
In the end of the intro session we form the teams that will be working together throughout the day.
I want less experiened people to learn from more experienced people, and I want more experienced people to strengthen their understanding by having to communicate their decision making.
So I like to equally balance the skill levels among the teams, but I also have to take into account which programming language people want to practice with. 
The tool I use (Gather Town) helps me with that.
I ask the people to assess their abilities and to take a position in the room that matches their confidence to work on the given kata.
The right end of the room means "very confident" and the left end means "I'm lost".
This creates an overview that makes it fairly easy to form balanced teams.
The optimal team size in my opinion is 3, but 4 works too. 
5 is kind of big, you might want to assign a designated facilitator for a team of this size.

### Tip: Assign a Facilitator for a Team
It is not possible for me as a single person to facilitate the programming in every team.
Especially when the people are not used to collaborative coding it makes sense to assign a designated facilitator.
The responsibility of this person is to provide just enough guidance for the team to work well together.
This can be anyone who knows a bit of mob programming. 
The role can be rotated, so that everybody gets the chance to contribute.
When the team is small and most of the people are already used to this, it might not be necessary to assign a facilitator.

## Coding Sessions & Retrospectives
Typically we manage to have three coding sessions, each of which is followed by a short retrospective.
In these retros we discuss anything that was interesting.
How we feel, what we discovered and learned and how we approached the exercise.
We might also take a look at the code we had written so far.
The first session includes setup, which regardless of how the teams are deciding to code together, will always take its time.
The goal should be to minimize this setup time in order to maximize the actual coding time.
A setup should absolutely not take longer than 60 minutes. 
If you try to setup every team members computer and it doesn't work out within this time, I recommend that you skip and get to coding with what you already have.
There are lots of ways to get to code together quickly, and you probably already know some.
However, I would like to share 3 ways I really like.

### Single Driver Mode
A way to get to code quickly is to have just a single person who already has a setup prepared share their screen.
The downside of this is the risk for other people to fall behind in inactivity.
The avoid that, the person sharing should behave as a passive driver and the other people rotate the navigator role.
I prefer when everybody gets the chance to drive, but this usually takes more setup time.

### Cyber-Dojo
[Cyber-dojo](http://www.cyber-dojo.org) works really well for TDD Katas, as it allows you to create and share a setup for any language in no time.
However, it wont provide you with all the conveniences your IDE has.
Things like continuous compilation, autocompletion, automated refactoring and so on are not available.

### Virtual Dev Environment
Another way to get to code together quickly is to join the same virtual development environment.
For example: A virtual machine running in the cloud that has everything setup and people connect to it through a remote desktop software.
[Remdev for azure](https://github.com/gregorriegler/remdev-azure)

## One hour lunch break
While its not a big deal to be a little late with the schedule in this kind of event, there is one event that I really want to hit, and this is the start of the lunch break.
This allows people to plan with their families.

## My Role as a Facilitator
As a facilitator I am not actively participating in solving the exercise.
Instead my Job is to make sure that the other attendees get the chance to do so.
So I am merely an organizer and enabler, but other than that my goal is mostly to get out of the way.
I watch out that we keep the schedule. 
Also, I am there to help when people get stuck or have questions.
During the coding sessions I walk from team to team and watch what they're up to. 
Occasionally I see things I am concerned with, and bring that up.
I try to do this by asking questions and spark their creativity and to come up with their own solutions.
Or I may see something interesting, for example a pattern that is being introduced, that I find worthy of discussing in more detail for everybody to understand.
If you want to learn more about facilitation in this regards I recommend Peters [Coderetreat-Facilitation Podcast](https://coderetreat-facilitation.code-cop.org/).
Many of the things I'm doing are things I learned from him.

## Gather Town
I use gather town as a remote video conference tool.
It works like a multiplayer version of Zelda, the oldschool role playing game, where you can move around a 2d map and talk to people in your vicinity.
So it creates that feeling of meeting somebody at a conference on the hallway again, just online.
It allows us to split up and go to different rooms, and I as a facilitator can actually walk from room to room.
Also, it gives you the freedom to customize the map.
I use an altered version of a map that Christian Haas once made for Viennas Global Day of Coderetreat.

## Choosing a Kata/Topic
The Coding Dojo should be a place to practice fundamentals.
The perfect kata is one that you, as a facilitator already know, is not too hard for the audience to tackle, and is small enough to finish within the dojo.
But it doesn't have to be perfect.
As a refactoring exercise I like the [Expense Report Kata](https://github.com/christianhujer/expensereport) or the [Order Dispatch Kata](https://github.com/gregorriegler/order-dispatch-refactoring-kata) for example.
As TDD Katas I like Snake, Game of Life or Mars Rover.
But I also did completely different things, for example the [Elephant Carpaccio Exercise](https://docs.google.com/document/u/1/d/1TCuuu-8Mm14oxsOnlk8DqfZAA1cvtYu9WGv67Yj_sSk/pub) which is about vertical Story Slicing.

## Selling a Coding Dojo
If you want to start a Coding Dojo at your company, I'd recommend to get your Boss agree that it will happen during work-day, and that it will be considered work-time.
Know-how is a bottleneck in our industry, where the majority has less than 5 years of experience.
Fresh developers have to learn so many things about their tech, tools and frameworks these days, that there is little room left for coding fundamentals like TDD and Refactoring.
Those are the things that are mostly not taught in school either.
When people get to practice these, they become better programmers.
They get better at writing code that works, is more maintainable and more secure in less time.
What boss wouldn't want that?

Feel free to contact me if you have more Questions.
