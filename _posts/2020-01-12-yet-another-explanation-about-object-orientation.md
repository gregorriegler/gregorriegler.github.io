---
layout: post
title:  "yet another explanation about object orientation"
tags: 
- oo, software design 
---

{% include youtube-player.html id="xlMg1a1flYA" %}

### information/state and behaviour
I like to think of software as a universe of state and behaviour.
State, whether mutable or immutable, is represented in the form of parameters, return values, vars, fields, files and so on and so forth.
Those have many different traits to them.
For example: vars, fields and files are location based, while parameters and return values are flow based. 
But they are all state.


Behaviour is represented in the form of functions that operate on that state. 
There is no behaviour without state.
Try to imagine a program that had no state.
No Vars.
No Input.
No Output.
Not even lambdas... they generate state.
We can't even print a damn thing without passing a string state.


### cohesion
Some state is related.
If we'd increase the cohesion and move related state closer to each other and behaviour towards the state it operates on, groups are emerging.
Groups of related parts.
Groups of state and behaviour. 


### encapsulation
We can wrap them in capsules, which come in many different forms. 
Functions, classes, packages, modules, processes and even servers are all kinds of capsules.
For each capsule we define a minimum viable interface.
The encapsulation serves the purpose of defining usable units that hide their internals which are irrelevant to the outside world.


### objects
We are defining Objects - behavioural capsules that interact with each other at runtime.
So a function is a form of an object.
An instance is a form of an object.
A module is a form of an object.
And even a microservice is a form of an object.


### coupling
Each object is in some way coupled to the neighbours it interacts with.
Coupling prevents independent changeability.
Objects which are strongly coupled to one another cannot be changed independently of each other.
The size of an objects public interface correlates with the strength of this coupling.
The more we close the capsule, the more details we hide, the smaller the interface will be, thus the weaker the coupling will turn out.

#### feature envy
Sometimes, an object accidentally operates on the state of another object. 
We call that a 'Feature Envy', as the object envies the other object.
This increases the coupling between the two.
We can resolve this situation by moving the behaviour to the object that holds the state.


### dependency
When an object knows about another, we call that a dependency. 
But don't confuse 'knows' with 'controls', those are different things.

#### dependency inversion
An object can control another object without even knowing it.
This is called dependency inversion.
Think about a AAA battery. It provides power, but it has no idea who it provides power to.
The form of the battery, AAA, is its interface. 
The flashlight knows the battery, it implements its interface.
And even though the battery knows nothing about the flashlight, the former controls the latter.

