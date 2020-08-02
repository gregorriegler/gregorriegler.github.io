---
layout: post
title: "Levels of Modularity"
tags: 
- Modularity
- Design
- Architecture
---

[Peter \<Code Cop\> Kofler](https://https://code-cop.org/) and I recently facilitated a refactoring workshop where we guided the participants to incrementally extract a microservice from a monolith.
Our focus was hands on coding, to practice the design decisions and refactoring steps needed for this task. 
Similar Workshops mostly focus on the technology side of things but neglect the so important coding and design part which we found was sad. 

Of course, modularity plays a big part in extracting a microservice.
We identified several milestones in this refactoring exercise which we then layed out as the 'Levels of Modularity'.
So the model is meant to guide us through the extraction where we gradually increase the level of modularity.
But it can also be used to just reflect on where we are now in terms of modularity, and help decide where we want to go.

## Brief overview of my understanding of Modularity
Modularity is the property of a system to which degree it is composed of modules. 
Modularity is recursive - Modules may be further decomposed into submodules.
A module is a cohesive, loosely coupled, encapsulated and composable piece of software that does one thing.  
I don't see modularity and its characteristics as absolutes. 
I rather see nuances and trade offs.
But it is all about controlling the scope of change.

- Cohesion tells whether code that changes for the same reason, is put closely. We aim for high cohesion. 
- Coupling tells to which degree a change in one part of the system affects another. 
Usually we aim for loose coupling so that we can change things independently. 
But the decoupling may come with a burden, which forces us to make trade offs. 
So we like to find the sweet spot.

## Level -1: The Distributed Monolith

![Distributed Monolith](/assets/modularity/modularity_level99_distributed_monolith.svg){:width="25%" .textwrap}

The structure itself already tells that there has been an attempt to decompose the system in a useful manner.
But what it apparently does is it tears apart cohesive pieces of software and puts thick walls between them. 
None of the parts is able to perform useful work on its own. They have a strong coupling with their dependencies. 
*Shotgun Surgery*[^ShotgunSurgery] is the result. 
One has to touch all services when changing a single feature.
Another effect is that it's mostly impossible to deploy any of those services independently.

I put this even below level 0, as i see negative modularity going on. 
In an attempt to increase its modularity we would first have to join it again, only to arrive at level 0.

How did we get there?
- We just didn't understand how to properly decompose a system into modules.
- We drew the boundaries before we had a proper understanding of the domain we're building.
- There are different developers working on different layers of the same thing. ConwaysLaw[^ConwaysLaw]

[^ShotgunSurgery]: [Shotgun Surgery](https://refactoring.guru/smells/shotgun-surgery): A Design Smell where one has to make lot's of changes in various places to change a single feature.

[^ConwaysLaw]: [Conways Law](https://en.wikipedia.org/wiki/Conway%27s_law): Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure.

#### Legend for the Graphics

| Drawing                       | What it means                                                |
| :---------------------------- | ------------------------------------------------------------ |
| Grey Box with Black Border    | The Unit of Deployment                                       |
| Colored Circles               | This is Code. The Color represents what the Code is doing work for. Every Color signifies another Feature / Behaviour. |
| Lines connecting Things       | Dependencies                                                 |


## Level 0

This level contains variants of monoliths that show no modularization.

### Level 0: The Big Ball of Mud

![The Big Ball of Mud](/assets/modularity/modularity_level0.svg){:width="25%" .textwrap}

This animal is completely disorganized. There is no recognizable structure, no abstraction, dependencies are intertwined. 
Strong coupling is the result. Changes in one Area of the code lead to bugs in several other areas. 
It contains all sorts of Code Smells from God Classes to Feature Envy, Dead Code and Change Preventers.

Developers get there because of many reasons:
- Lack of Experience
- Carelessness after feeling treated unfair
- Rushing Changes to try and meet a deadline
- Developers with different views working independently on the same codebase without sufficient alignment.
- Fluctuation

### Level 0: Monolith packaged by Layer

![Monolith packaged by Layer](/assets/modularity/modularity_level0_layered.svg){:width="25%" .textwrap}

This is probably the most common monolith out there. 
Its package structure is often guided by frameworks and code generators that propose having packages like `controllers`, `domain` and `repositories` on the top level. 
This framing proposes *Separation of Concerns*[^SeparationOfConcerns] which is a good thing. 
But the proposed way of having those packages on the top level obfuscates what the application is doing. "Controllers" does not provide any clue about what the app is doing.

## Level 1: Package by Feature

![Package by Feature](/assets/modularity/modularity_level1.svg){:width="25%" .textwrap}

Package by Feature is much more desirable. 
It puts the names of features like Order, Cart and User at the top level which are screaming: "I am a Shop!". 
It helps us to quickly find the code we need to change. 
As the cohesion is increased, we typically just have to touch a single top level package when changing a feature. 
There is no information hiding[^InformationHiding] going on between the features though. 
A code within one feature knows about the internals of another feature and has access to it. 
For Example: Feature A may fetch data from the Repository of Feature B, or use its business logic. 
So there is still coupling going on.

[^InformationHiding]: [Information Hiding](https://wiki.c2.com/?InformationHiding) 

## Level 1: Features, but layered inside

![Features, but layered inside](/assets/modularity/modularity_level1_layered.svg){:width="25%" .textwrap}

*Separation of Concerns*[^SeparationOfConcerns] again, just inside Feature Packages.
We do this when we want to isolate our Domain, our "Happy World" from Infrastructure Code.
Or maybe we just like to organize our many files and put them into distinct folders to gain a better understanding of what a file is about.

[^SeparationOfConcerns]: [Separation Of Concerns](https://wiki.c2.com/?SeparationOfConcerns)

## Level 2: The Modular Monolith

![The Modular Monolith](/assets/modularity/modularity_level2.svg){:width="25%" .textwrap}

Feature packages turn modules. 
Each module now has a clear api which is the only way to access it. 
One module doesn't know about the inner details of another module anymore. 
So they are encapsulated, and the coupling is further reduced. 
But as the module does not encapsulate its data, the modules are still coupled by the shared database.

## Level 3: The Microservice Ready Monolith

![The Microservice Ready Monolith](/assets/modularity/modularity_level3.svg){:width="25%" .textwrap}

The coupling of a shared database is removed. 
Each module uses its own data. 
Could be a separate database, or just separate tables within the same database. 
As long as there is no hidden coupling like a foreign key, we consider it as separated.
Sometimes, two or more modules need to access the same data.
In this case they would access the data through the module that owns it, or have a separate copy of the data.
In case of a copy we would choose a data model that perfectly fits the needs of the respective module. 
The data might be updated through events.

It's still a monolith, but a very decoupled one. 
Extracting a microservice is very easy from this level.

## Level 4: Microservices

![Microservices](/assets/modularity/modularity_level4_microservice.svg){:width="25%" .textwrap}

We can now independently deploy, as well as scale each service.
Each microservice has a strong autonomy and can be developed by its own team.
We may use the tech that best fits a services job.

But it comes at the cost of a world of pain:
- Hard to Integrate
- Hard to Maintain 
- Lot's of additional Technology might be needed.
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
    - and so on, and so forth


