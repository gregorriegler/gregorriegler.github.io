---
layout: post
title: Running a Company Coding Dojo
tags: 
- Coding Dojo
---

Two years ago in 2019, I ran the first Coding Dojo at my company [ebcont](http://www.ebcont.com). 
Corona wasn't a thing back then, so it happened to be an offline event that lasted 4 hours on a Thursday afternoon. 
All the brilliant people came together in the same location to practice the fundamentals of programming and enjoy themselves doing so.
How awesome is that?

![Local Coding Dojo at Ebcont](/assets/coding-dojo/coding-dojo1-2.jpg)

A lot has changed since then. 
When the pandemic happened I had to adapt and turn it into an online event.
I decided to make it a whole day thing and started doing it regularly.
Luckily I had already collected plenty of experience from my friends at the [Vienna Software Crafts Community](https://www.softwerkskammer.org/groups/wien) where we also run coderetreats.

The ebcont coding dojo turned out to be a small success story.
When I started it I had approximately 10 people join, many of which are now regular attendees.
But lately, there was a small hype around the event.
People liked it so much, they came up with the idea to create a Coding Dojo T-Shirt and shoot a group photo with it.
Of course, we did so.
I had 25 employees join in the latest event, and it was a lot of fun.

![Local Coding Dojo at Ebcont](/assets/coding-dojo/ebcont_remote_dojo.jpg)

Again, take a closer look at these sweet t-shirts!

![Ebcont Coding Dojo T-Shirts](/assets/coding-dojo/sweet-tshirts.jpg)

## Coding Dojo???
So what is a Coding Dojo, how do I do it and what can you take away from my experience?
The term [Dojo](https://en.wikipedia.org/wiki/Dojo) originates in Japan and stands for a training facility where they perform katas, 
choreographed patterns of martial art movements designed for practice.

A [Coding Dojo](https://codingdojo.org/WhatIsCodingDojo/) is a similar thing, we just perform coding katas.
It is a great opportunity to practice technical skills like TDD, design, and refactoring.
Invaluable fundamentals that are mostly not taught in school and are left behind the things that turn out to have higher demand: Frameworks and tools. 

Under pressure, we naturally fall back to old and maybe poor habits, even though it'll lead to worse results.
So we take our time to practice and get comfortable with good programming techniques so that when it counts we will be confident to apply them.
While the traditional Coding Dojo is a short ~2-hour event, the one I do lasts almost a whole day.
>The Coding Dojo creates space for developers to practice the fundamentals of programming, away from the pressure of getting things done.

## But why not a full day?
I had the experience that an intense full-day practice event can become tiring in the end.
Closing just a little bit sooner leaves the participants with more energy in the final retrospective and the evening after the event.
There are similar whole-day events in the name of coderetreat and mobretreat.
The classical coderetreat has the notion of throwing away your code after a timeboxed session and starting from scratch with a different pair.
So you don't finish, but get to see many different perspectives within a short time - quite intense.
That's a little different from what I do.
I like to provide the participants the opportunity to dive deeper into a kata. 
So we stay within the same teams and kata throughout the day.
This reduces the relative amount of setup time which allows us to get more coding done.

## The Dojo Plan
I decide on the topic and kata in advance, taking the attendees' skill levels into account.
Prior to the event, I send them information about what we're gonna do.
The Dojo starts with a short welcome where we have a few minutes of small talk before the intro session begins.
In the intro session we discuss the topic and kata we will be working on.
I like to walk over a minimum of the theory that I believe everybody should know.
The most effective way to do this is to just keep throwing questions at the group, and have them provide the answers themselves.
At the end of the intro session, we form the teams that will be working together in the following coding sessions.

## Balancing Teams
I want less experienced people to learn from more experienced people, and I want more experienced people to get challenged by curious less experienced people so they can refresh and deepen their understanding.
So I like to equally balance the skill levels among all teams, but I also have to take into account which programming language people want to practice with. 
The tool I use [gather-town](https://www.gather.town/) helps me with that.

>Gather Town is a remote video conference tool that works like a multiplayer version of Zelda.
>You can move around on a 2d map and talk to people in your vicinity.
>It creates that feeling of meeting somebody at a conference in the hallway again, just online.
>And it allows us to split up and go to different rooms.
>Also, it gives me the freedom to customize the map.
>I use an altered version of a map that Christian Haas once made for Viennas Global Day of Coderetreat.

I ask the people to assess their abilities and to take a position in the room that matches their confidence to work on the given kata.
Standing on the right end of the room means *"very confident"* and the left end means *"I'm lost"*.
The rest of the spectrum is in between.
This creates an overview that makes it fairly easy to form balanced teams.
The optimal team size in my opinion is 3, but 4 works too. 
5 is kind of big, you might want to assign a designated facilitator for a team of this size.

### Tip: Assign a Facilitator for a Team
It is not possible for me as a single person to facilitate the programming in every team.
Especially when the people are not used to collaborative coding it makes sense to assign a designated facilitator.
The responsibility of this person is to provide just enough guidance for the team to work well together.
This can be anyone who knows a bit of mob programming. 
The role can be rotated so that everybody gets the chance to contribute.
When the team is small and most people are already used to this, it might not be necessary to assign a facilitator.

## Coding Sessions & Retrospectives
Typically we manage to have three coding sessions, each of which is followed by a short retrospective.
In these retros, we discuss anything that was interesting.
How we feel, what we discovered and learned, and how we approached the exercise.
We might also share and review the code we had written so far.
The first session always includes setup, which is the time spent until the team actually starts coding together in some way.
Somehow, setup always takes a fair amount of time - regardless of how well you are prepared.
The goal should be to minimize this time in order to maximize coding time.
Setup should absolutely not take longer than 60 minutes. 
If you try to set up every team member's computer and it doesn't work out within this time, I recommend that you skip and get to coding with what you already have.
There are lots of ways to code together quickly, and you probably already have some in mind.
However, I would like to share some ways with you I found work well.

### #1 Single Driver Mode
A way to get to code quickly is to have just a single person who already has a setup prepared to share their screen.
The downside of this is the risk for other people to fall behind in inactivity.
The avoid that, the person sharing should behave as a passive driver and the other people make decisions and rotate the navigator role.
I prefer when everybody gets the chance to drive, but this usually takes more setup time.

### #2 Cyber-Dojo
[Cyber-Dojo](http://www.cyber-dojo.org) works really well for TDD katas, as it allows you to create and share a setup for any language in no time.
However, it won't provide you with all the conveniences your IDE does.
Things like continuous compilation, autocompletion, automated refactoring, and so on are not available.

### #3 Virtual Dev Environment
Another way to get to code together quickly is to join the same virtual development environment.
Could be a virtual machine running in the cloud that has everything already set up and people just connect to it through some remote desktop software.
I did something like this, where I spawn an immutable Linux dev system in azure: [Remdev on Azure](https://github.com/gregorriegler/remdev-azure)

## One hour lunch break
While it's not a big deal to be a little late in the schedule, I really want to nail the 1-hour lunch break.
This allows people to plan and spend that time with their families.

## My Role as a Facilitator
As a facilitator, I am not there to actively perform katas. 
Instead, my job is to make sure that every participant gets the chance to learn and practice.
So I am merely the organizer and enabler.
I watch out that we keep the schedule (which I'm terrible at) and mostly try to get out of the peoples' way.
Also, I'm there to help the participants when they get stuck or have questions.
But this doesn't mean I'm not learning ... far from the truth.
I learn a lot as I get to see amazing ideas, experience new tech, observe sociotechnical patterns, discover and rediscover non-obvious details. 

During the coding sessions, I switch from team to team and observe what they're up to. 
This works really well with gather town as I can literally walk from room to room.
Occasionally I see things I am concerned with and bring that up.
I try to do this by asking questions, sparking their creativity, and having them come up with their own solutions.
Or I may see something interesting, for example, a pattern being introduced that I find worthy of a discussion, so everybody understands.
If you want to learn more about facilitation in this regard I recommend Peters [Coderetreat-Facilitation Podcast](https://coderetreat-facilitation.code-cop.org/).
Many of the things I'm doing are things I learned from him.

## Choosing a Kata/Topic
The coding dojo should be a place to practice the fundamentals.
The perfect kata is one that is not too hard for the attendees to tackle, is small enough to finish within the event, and is one that you as a facilitator already know well.
But it doesn't have to be perfect.
As a refactoring exercise, I like the [Expense Report Kata](https://github.com/christianhujer/expensereport) which is nice and small.
Or the [Order Dispatch Kata](https://github.com/gregorriegler/order-dispatch-refactoring-kata) which is about [Tell don't ask](https://wiki.c2.com/?TellDontAsk).
As TDD katas I like [Snake](https://en.wikipedia.org/wiki/Snake_(video_game_genre)), [Game of Life](https://codingdojo.org/kata/GameOfLife/), or [Mars Rover](https://kata-log.rocks/mars-rover-kata).
But I also did completely different things, for example, the [Elephant Carpaccio Exercise](https://docs.google.com/document/u/1/d/1TCuuu-8Mm14oxsOnlk8DqfZAA1cvtYu9WGv67Yj_sSk/pub) which is about vertical story slicing and iteration.

## Selling a Coding Dojo
If you want to start a Coding Dojo at your company, let me tell you that I think that's awesome!
I'd recommend getting your Boss to agree that it will happen during the work-day, and that it will be considered work-time.
Missing know-how is a bottleneck in our industry, where the majority have less than 5 years of experience.
Fresh developers have to learn so many things about their tech, tools, and frameworks these days, that there is little room left for coding fundamentals like TDD and refactoring.
Those are the things that are mostly not taught in school either.
When people get to practice these, they become better programmers.
They get better at writing code that works, is more maintainable, and more secure, in less time.
What boss wouldn't want that?

TBD: Conclusion

Are you also running a Coding Dojo / Coderetreat at your company? Awesome, let me know how you do it!
Feel free to contact me if you have more questions.
