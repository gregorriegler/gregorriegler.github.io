---
layout: post
title:  "shower thoughts on agility"
tags: 
- agile
---


## unexpected

<p>we've seen developers writing unit tests, and it has worked out well for them.</p>  
<p>we've seen developers writing those unit tests before writing any production code, and it has worked out well for them.</p>
<p>we've seen developers spending time in improving the code, without getting any new feature done, and it has worked out well for them.</p>  
<p>we've seen developers doing pair programming - costing twice as much to solve the same problem? - and it has worked out well for them.</p>  
<p>we've seen developers doing mob programming, having a small group of people working at the same time, on the same problem and on the same computer, and it has worked out well for them.</p>  
<p>we've seen developers spending their work time in learning and practice, and it has worked out well for them.</p>  
<p>we've seen developers quit doing estimates, and it has worked out well for them.</p>  
<p>we've seen developers managing to deliver useful versions early and often.</p>  
<p>we've seen developers managing to deliver value to their customers every single day.</p>  
<p>we've seen organizations giving power to their development teams, and it has worked out well for them.</p>  
<p>we didn't expect those things to work out this way - yet here we are.</p>

this is very refreshing in my opinion, and i am very interested in exploring why those things worked out the way they did.  
it seems like we really suck at predicting what would work and what wouldn't.  
but if we are so bad at those predictions, shouldn't we just try things out?

## the industrial age
first of all, i believe that our thinking has been stuck in the industrial age of [taylorism](https://en.wikipedia.org/wiki/Frederick_Winslow_Taylor) and militarism, and that these ideas have shaped our way of thinking, teaching, working and just everything, up until today.
taylorism might have worked well in factories, where every new produced thing was exactly the same, and it was finished at some point.
this however seems not to be the case with software.
software is never the same, and if it was you'd reuse it.
software is never finished, it keeps changing and improving.
software development is just fundamentally different to factory work.
it is about knowledge, communication, experimentation, discovery and learning.

## knowledge refineries
software starts with somebody having a need.
this need unfolds in an idea, a vision.
in a traditional world this vision leads to the creation of requirements.
the requirements are used to create specifications.
the specifications guide the writing of the code.
each of these steps could be seen as refinements of knowledge.
the knowledge starts very vague and becomes gradually more specific until it ends in code.
the knowledge is transferred, refined, stored, and it decays (thanks to Alex Bolboacă [@alexboly](https://twitter.com/alexboly) for this [observation](https://mozaicworks.com/blog/software-engineering/knowledge-refinery/)).

## the risk of bugs
in a traditional world, those refinements are done by different people of different skills with distance among them.
we know that communication is lossy, and that the devil is in the details.
needs are often lost in communication, resulting in instructions without context.
instructions without context are likely the source of speculative assumptions.
bugs may not only occur in code, but in specification, requirements, and ideas as well.
thus each refinement step has a risk of bugs.
the amount of people involved, and the distance between those people increase the risk of bugs.
the amount of refinement steps in the process, and the length of interval between them, increase the risk of bugs.
the damage of bugs in early stages of the development process grows if left undiscovered.
the damage of bugs is reduced when the code is in a maintainable state.
one way to discover bugs early, and to prevent them from doing lots of damage, is continuous feedback.
the faster the feedback, the smaller the risk.
a waterfall process hides bugs until the last possible moment, it maximizes the risk of bugs, and the damage those bugs inflict.

## code as a byproduct
if software development is so much about discovering bugs, maybe code is just a byproduct.
the real product would be the learning, and the discovery of a bug-free vision.

## the many minds problem
too many cooks spoil the broth, and it's the same with code.
different programmers have different opinions, styles and knowledge.
many disconnected minds working on the same system can only make it unnecessarily complex.
code is duplicated, when the existing implementation is not known or disliked.
styles of design in areas of the code deviate from one another.
programmers of all levels of experience have a hard time creating quality output, while quality output has a lot of attributes.
mob programming helps solving these issues in an attempt to create a single mind of many.

## storing knowledge
storing knowledge in brains is risky as brains are bad at remembering details.
knowledge stored in just a single brain is even more risky, as it gets lost in fluctuation ([bus factor](https://en.wikipedia.org/wiki/Bus_factor)).
documentation quickly becomes dated. facts change, but no one updates the documentation.
the only trustworthy long term store for knowledge is the code, as it never gets old. same with executable specification in the form of tests that change with the code.

## transferring knowledge: meetings
when programmers get in the zone, their short-term memories become stuffed with details about a specific problem and the code.
meetings often cause damage by tearing programmers out of this context, which took a long time to setup in the first place.
to make things worse, the details discussed in those meetings are typically unrelated to the programmers recent context.
so, not only will the programmer spend a lot of time getting back into the zone after the meeting, also parts of the knowledge gained within the meeting will get lost in that process anyhow.

## transferring knowledge: email
a good way to avoid lossy communication is to have the recipient repeat in their own words what they have understood.
the sender then has immediate feedback if there was a misunderstanding or not.
email does not provide this way of feedback, it is typically 'send and forget', sometimes even disregarded.

## knowledge refactoring
refactoring is a vital practice to make code more comprehensible, and to discover bugs.
but what about requirements and specification?
if they are similar to code, just not as refined - shouldn't we refactor them, too?

## estimation
the things we estimate are typically not the things that cause most of our effort.
the things we estimate are naturally known things.
but it is about the things we don't know, that make the effort.

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Does this seem about right? <a href="https://t.co/PEtgTBX9eM">pic.twitter.com/PEtgTBX9eM</a></p>&mdash; Oluf Nissen (@GeekTieGuy) <a href="https://twitter.com/GeekTieGuy/status/1176895878478450688?ref_src=twsrc%5Etfw">September 25, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## derived principles?
- less people involved -> smaller teams.
- less distance between people.
- write code together.
- continuous collaboration, share knowledge.
- continuous and fast feedback using smaller batches.
- idea to code as soon as possible.
- avoid meetings and emails.
- avoid estimation.
- have the courage to question input.

