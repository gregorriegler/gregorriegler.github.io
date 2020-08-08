---
layout: post
title: "Levels of Modularity"
tags: 
- Modularity
- Design
- Architecture
---

[Peter \<Code Cop\> Kofler](https://code-cop.org/) and I recently facilitated a refactoring workshop where we guided our participants to incrementally extract a microservice from a monolith. Similar workshops were mostly about the technology side of things and neglected the coding part which we found was sad. So we obviously decided to focus on **hands on coding** and to practice the refactoring steps needed for this task. 

We identified several milestones in this refactoring exercise which we then laid out as the **'Levels of Modularity'**.
Each level represents a different kind of architecture that shows stronger or weaker modularity.

The model helps us to reason about our current architecture and decide where we want to go.
But most interestingly it acts as a play book how to extract a microservice.
It is feasible to go through each level and gradually increase the modularity in an attempt to extract the microservice.

## Modularity is about controlling the scope of change
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

The structure tells that there has been an attempt to decompose the system into services.
But what it apparently does is it tears apart cohesive pieces of software and puts thick walls between them. 
None of the parts is able to perform useful work on its own. They have a strong coupling with their dependencies. 
*Shotgun Surgery[^ShotgunSurgery]* is the result. 
One has to touch many services when changing a single feature.
Another effect is that it's mostly impossible to deploy any of those services independently.

I put this even below level 0, as i see negative modularity going on. 
In an attempt to increase its modularity we would first have to join the services again, only to arrive at level 0.

How did we get there?
- We just didn't understand how to properly decompose a system into modules.
- We drew the boundaries before we had a proper understanding of the domain we're building.
- There are different developers working on different layers of the same thing. (*Conways Law[^ConwaysLaw]*)

[^ShotgunSurgery]: [Shotgun Surgery](https://refactoring.guru/smells/shotgun-surgery): A design smell where one has to make lot's of changes in various places to change a single feature.

[^ConwaysLaw]: [Conways Law](https://en.wikipedia.org/wiki/Conway%27s_law): Any organization that designs a system (defined broadly) will produce a design whose structure is a copy of the organization's communication structure.

#### Legend for the Graphics

| Drawing                       | What it means                                                |
| :---------------------------- | ------------------------------------------------------------ |
| Grey Box with Black Border    | The Unit of Deployment                                       |
| Colored Circles               | This is Code. The Color represents what the Code is doing work for. Every Color signifies another Feature / Behaviour. |
| Lines connecting Things       | Dependencies                                                 |


## Level 0

Monoliths with low cohesion and high coupling.

### Level 0: The Big Ball of Mud

![The Big Ball of Mud](/assets/modularity/modularity_level0.svg){:width="25%" .textwrap}

This animal is completely disorganized. There is no recognizable structure, no abstraction, dependencies are intertwined. 
Strong coupling is the result. Changes in one Area of the code lead to bugs in several other areas. 
It contains all sorts of *Code Smells[^CodeSmell]* from *God Classes* to *Feature Envy*, *Dead Code* and *Change Preventers*.

Developers get there because of many reasons:
- Lack of Experience
- Carelessness after feeling treated unfair
- Rushing Changes to try and meet a deadline
- Developers with different views working independently on the same codebase without sufficient alignment.
- Fluctuation

[^CodeSmell]: [Code Smell](https://sourcemaking.com/refactoring/smells): A sign that something might be wrong with the code.

### Level 0: Monolith packaged by Layer

![Monolith packaged by Layer](/assets/modularity/modularity_level0_layered.svg){:width="25%" .textwrap}

This is probably the most common monolith out there. 
Its package structure is often guided by frameworks and code generators that propose having packages like `controllers`, `domain` and `repositories` on the top level. 
This framing proposes *Separation of Concerns[^SeparationOfConcerns]* which is a good thing. 
But the proposed way of having those packages on the top level obfuscates what the application is doing. "Controllers" does not provide any clue about what the app is doing.

## Level 1

Monoliths with high cohesion.

### Level 1: Package by Feature

![Package by Feature](/assets/modularity/modularity_level1.svg){:width="25%" .textwrap}

Package by Feature is much more desirable. 
It puts the names of features like Order, Cart and User at the top level which are screaming[^ScreamingArchitecture]: "I am a Shop!".
It helps us to quickly find the code we need to change. 
As the cohesion is increased, we typically just have to touch a single top level package when changing a feature. 
There is no *information hiding[^InformationHiding]* going on between the features though. 
A code within one feature knows about the internals of another feature and has access to it. 
For Example: Feature A may fetch data from the Repository of Feature B, or use its business logic. 
So there is still coupling going on.

[^InformationHiding]: [Information Hiding](https://wiki.c2.com/?InformationHiding) 
[^ScreamingArchitecture]: [Screaming Architecture](http://blog.cleancoder.com/uncle-bob/2011/09/30/Screaming-Architecture.html)

### Level 1: Features, but layered inside

![Features, but layered inside](/assets/modularity/modularity_level1_layered.svg){:width="25%" .textwrap}

*Separation of Concerns*[^SeparationOfConcerns] again, just inside feature packages.
We do this when we want to isolate our domain, our "Happy World" from infrastructure code.
Or maybe we just like to organize our many files and put them into distinct folders to gain a better understanding of what a file is about.

[^SeparationOfConcerns]: [Separation Of Concerns](https://wiki.c2.com/?SeparationOfConcerns)

## Level 2: The Modular Monolith

![The Modular Monolith](/assets/modularity/modularity_level2.svg){:width="25%" .textwrap}

A Monolith with both low coupling and high cohesion.

Feature packages turn modules. 
Each module now has a clear api which is the only way to access it. 
One module doesn't know about the inner details of another module anymore. 
So they are encapsulated, and the coupling is further reduced. 
But as the module does not encapsulate its data, the modules are still coupled by the shared database.

Increasing the modularity further than this may come with a significant cost.

## Level 3: The Microservice Ready Monolith

![The Microservice Ready Monolith](/assets/modularity/modularity_level3.svg){:width="25%" .textwrap}

The coupling of a shared database is removed. 
Each module now uses its own data. 
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

We can now deploy, as well as scale each service independently.
Each microservice has a strong autonomy and can be developed by its own team that uses the tech that best fits the services job.

But it comes at a cost and a lot of pain:
- Hard to Integrate.
- Hard to Maintain.
- An organizational challenge.
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
    - and so on

> “Don’t even consider microservices unless you have a system that’s too complex to manage as a monolith.” 
>
> ~Martin Fowler

## Conclusion

The **Levels of Modularity** provide a model to help reason about an architecture and decide where to go from there. The higher the level, the more modular an architecture is.

Also, we may use the **Levels of Modularity** as a cook book to refactor to a more modular architecture. We want to go level by level incrementally. 

To get from a *Big Ball of Mud (Level 0)* to a *Modular Monolith (Level 2)*, we first want to find the features and collect them in distinct packages to arrive at *Package by Feature (Level 1)*. Only then would we decouple the feature packages to finally arrive at a *Modular Monolith (Level 2)*. We may even apply the *Strangler Pattern[^StranglerPattern]* and carry one feature through all Levels before attempting the next one.

[^StranglerPattern]: [Strangler Pattern](https://martinfowler.com/bliki/StranglerFigApplication.html): An approach to improve a big system by improving one sub-system at a time until there is no sub-system left to improve.



