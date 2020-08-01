---
layout: post
title: "Levels of Modularity"
tags: 
- Modularity
- Design
- Architecture
---

[Peter \<Code Cop\> Kofler](https://https://code-cop.org/) and I recently facilitated a refactoring workshop, where we guided the participants to incrementally extract a microservice from a monolith.
Our focus was hands on coding, and to practice the refactoring steps needed for this task. 
Similar Workshops often focus on tooling and technology but neglect the so important coding part which we found was sad. 

Of course, design and modularity plays a big role when extracting a microservice.
We identified 4 milestones in this refactoring exercise which we then called the 'Levels of Modularity'.
This model is meant to help and guide participants through the refactoring where we gradually increase the level of modularity.

## Brief Introduction to Modularity
Modularity is the property of a system to which degree it is composed of modules. 
Modularity is recursive - Modules may be further decomposed into submodules.
A module is a cohesive, loosely coupled, encapsulated and composable piece of software that does one thing.  
I don't see Modularity and its aspects as Absolutes. 
I rather see nuances and trade offs.
But all aspects of modularity are about controlling the scope of change.

- Cohesion tells how much code that changes for the same reason, is put together. We aim for high cohesion. 
- Coupling tells to which degree a change to one part of the system affects another. 
When we want to achieve independent changeability we aim for loose coupling.

## Level -1: Distributed Monolith

![Distributed Monolith](/assets/modularity/modularity_level99_distributed_monolith.svg){:width="25%" .textwrap}

The structure itself already tells that there has been an attempt to decompose the system in a useful manner.
But what it apparently does is it tears apart cohesive pieces of software and puts thick walls between them. 
None of the parts is able to perform useful work on its own. They have a strong coupling with their dependencies. 
*Shotgun Surgery*[^ShotgunSurgery] is the result. 
One has to touch all services in the code when changing a single feature.
Another effect is that it's mostly not possible to deploy any of those services independently.

I put this even below level 0. In an attempt to increase its modularity we would first have to join everything again.

How did we get there?
- Maybe we just didn't understand how to properly decompose a system into modules.
- Maybe we drew the boundaries before we had a proper understanding of the domain we're building.
- Maybe there are different developers working on different layers of the same thing.

[^ShotgunSurgery]: [Shotgun Surgery](https://refactoring.guru/smells/shotgun-surgery): A Design Smell where one has to make lot's of changes in various places to change a single feature.

#### Legend for the Graphics

| Drawing                       | What it means                                                |
| :---------------------------- | ------------------------------------------------------------ |
| Grey Box with Black Border    | The Unit of Deployment                                       |
| Colored Circles               | This is Code. The Color represents what the Code is doing work for. Every Color signifies another Feature / Behaviour. |
| Lines connecting Things       | Dependencies                                                 |


## Level 0

This level contains all variants of monoliths that show no modularization.

### Level 0: Big Ball of Mud

![Big Ball of Mud](/assets/modularity/modularity_level0.svg){:width="25%" .textwrap}

This animal is completely disorganized. There is no recognizable structure, no abstraction, dependencies are intertwined. 
Strong coupling is the result. Changes in one Area of the code lead to bugs in several other areas. 
It contains all sorts of Code Smells from God Classes to Feature Envy, Dead Code and Change Preventers.

Developers get there because of many reasons:
- Lack of Experience
- Carelessness after feeling treated unfair
- Rushing Changes to try and meet a deadline 
- Different Developers with different views and opinions working independently on the same codebase (Everybody works their own or just fluctuation).

### Level 0: Monolith packaged by Layer

![Layered](/assets/modularity/modularity_level0_layered.svg){:width="25%" .textwrap}

This is probably the most common monolith out there. 
It's package structure is often guided by frameworks and code generators that propose having packages like `controllers`, `domain` and `repositories` on the top level. 
This framing proposes *Separation of Concerns*[^SeparationOfConcerns] which is a good thing. 
But the proposed way of having those packages on the top level obfuscates what the application is doing. "Controllers" does not provide any clue about what the app is doing.

[^SeparationOfConcerns]: [Separation Of Concerns](https://wiki.c2.com/?SeparationOfConcerns)

## Level 1

This level contains ar

### Package by Feature

![Package by Feature](/assets/modularity/modularity_level1.svg){:width="25%" .textwrap}

Package by Feature is much more desirable. 
It puts the names of features like Order, Cart and User at the top level which are screaming: "I am a Shop!". 
It helps us to quickly find the code we need to change. 
As the cohesion is increased, we typically just have to touch a single top level package when changing a feature. 
There is no information hiding going on between the features though. 
A code within one feature knows about the internals of another feature and has access to it. 
For Example: Feature A may fetch data from the Repository of Feature B, or use its business logic. 
So there is still some coupling going on.

#### Features, but Layered inside

![Features, but layered inside](/assets/modularity/modularity_level1_layered.svg){:width="25%" .textwrap}

We do this when we want to isolate our Domain, our "Happy World" from Infrastructure Code.
Or maybe we just like to put too many files into distinct folders so we have a better understanding what a files responsibility is.

## Level 2

### Modular Monolith

![Modular Monolith](/assets/modularity/modularity_level2.svg){:width="25%" .textwrap}

Feature packages turn modules. 
Each module now has a clear api which is the only way to access it. 
One module doesn't know about the inner details of another module. 
The coupling is further reduced. 
It's still a monolith though, and it's still coupled by a shared database.

## Level 3

### Modular Persistent Data

![Modular Persistent Data](/assets/modularity/modularity_level3.svg){:width="25%" .textwrap}

The coupling of a shared database is removed. 
Each module uses its own data. 
Could be a separate database, or just separate tables within the same database. 
As long as there is no hidden coupling like a foreign key, we consider it as separated.
Sometimes, two or more modules need to access the same data.
In this case they would access the data through the module that owns it, or have a separate copy of the data.
In case of a copy we would choose a different data model.
One that perfectly fits the needs of the respective module. 
The data might be updated through events.

It's still a monolith, but a very decoupled one. 
Extracting a microservice is very easy from this level.

## Level 4

### Microservices

![Microservices](/assets/modularity/modularity_level4_microservice.svg){:width="25%" .textwrap}

The diffences of this level from the previous one are:
- Independent deployability.
- Independent scaleability.
- Each microservice may use the tech that best fits its job.
At the cost of a world of pain:
- Hard to Integrate
- Hard to Maintain 
- Lot's of additional Technology may be needed.
    - API Gateway
    - Event Bus
    - Container Orchestration
    - Configuration Broker
    - Contract Testing
    - Bulkheads
    - Circuit Breakers
    - Distributed Tracing
    - Distributed Logging
    - Service Registry



