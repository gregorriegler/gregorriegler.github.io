---
layout: post
title: "Levels of Modularity"
tags: 
- Modularity
- Design
- Architecture
---

Modularity is the property of a system that tells to which degree it is composed of modules. 

But what does that mean?
What is a module, and what are its attributes?

A module is a composable system that focuses on doing but one thing.

In Software, Modularity is all about change, and to make it easy by reducing its scope.

A System of Systems. Modularity is recursive.

It matters where the boundaries are.

Stable dependency rule.

## How to read it

| Drawing                       | What it means                                                |
| :---------------------------- | ------------------------------------------------------------ |
| Circles in Colors             | This is Code. The Color represents what the Code is doing work for. Every Color signifies another Feature / Behaviour. |
| Grey Boxes with Black Borders | An Artifact. The Unit of Deployment                          |
| Lines connecting things       | These are Dependencies                                       |
| The Database                  | The Database 🙂                                               |


## Level 0

### The Big Ball of Mud

![Big Ball of Mud](/assets/modularity/modularity_level0.svg){:width="25%" .textwrap}

This animal is organised and does not show a uniform structure. There are no clear abstractions, dependencies are intertwined.

This is often the result of several developers with different views on design working independently on the same code-base without doing proper coordination.

### The Distributed Monolith

![Distributed Monolith](/assets/modularity/modularity_level99_distributed_monolith.svg){:width="25%" .textwrap}

The structure itself already tells that there has been an attempt to decompose the system in a useful manner.
But what it apparently does is it tears apart cohesive pieces of software that usually change together and puts thick walls between them. 
These parts are not able to perform useful work on its own leading to a strong coupling onto their dependencies. 
It leads to *Shotgun Surgery*[^ShotgunSurgery], meaning one has to touch various places in the code when changing a single feature.
Another effect is that despite being separated into multiple services, it is not possible to deploy those services independently.
From a maintenance perspective this might be even worse than the Big Ball of Mud.

In an attempt to fix the situation a feasible first step would be to first join the separated parts again before making proper extractions.

This Architecture may be the result of a Team that had different developers working on different layers of the same thing. It might also be the case that there was just a lack of understanding.

[^ShotgunSurgery]: [Shotgun Surgery](https://refactoring.guru/smells/shotgun-surgery): A Design Smell where one has to make lot's of changes in various places to change a single feature.

### Monolith packaged by Layer

![Layered](/assets/modularity/modularity_level0_layered.svg){:width="25%" .textwrap}

This is probably the most common monolith out there. It's package structure is often guided by frameworks and code generators that propose having packages like `controllers`, `domain` and `repositories` on the top level. This framing proposes *Separation of Concerns*[^SeparationOfConcerns] which is a good thing. But the proposed way of having those packages on the top level obfuscates what the application is doing. "Controllers" does not provide any clue about what the app is doing.

[^SeparationOfConcerns]: [Separation Of Concerns](https://wiki.c2.com/?SeparationOfConcerns)

## Level 1

### Package by Feature

![Package by Feature](/assets/modularity/modularity_level1.svg){:width="25%" .textwrap}

Package by Feature is much more desirable. It puts the names of features like Order, Cart and User at the top level which are screaming: "I am a Shop!". It helps us to quickly find the code we need to change. As the cohesion is increased, we typically just have to touch a single top level package when changing a feature. There is no information hiding going between the features though. A code within one feature knows about the internals of another feature and has access to it. It may fetch the other features persistent data, or use its business logic. So there is still some coupling going on.

#### Often Layered inside

![Features, but layered inside](/assets/modularity/modularity_level1_layered.svg){:width="25%" .textwrap}

As the amount of files in a feature increases it might be appropriate to divide them into layers again. But this time, the layers are done within the feature. 
Achieving both structure and high cohesion at the same time.

## Level 2

### Modular Monolith

![Modular Monolith](/assets/modularity/modularity_level2.svg){:width="25%" .textwrap}

Feature packages turn into modules. Each module now has a clear api which is the only way to access it. So one module does not anymore know about the inner details of another module. The coupling is further reduced. It is still a monolith though, and it's still coupled by a shared database.

## Level 3

### Modular Persistent Data

![Modular Persistent Data](/assets/modularity/modularity_level3.svg){:width="25%" .textwrap}

Here the coupling of a shared database is removed. Each module now uses its own data. Could be a separate database, could be just separate tables in the same database. As long as there is no hidden coupling like a foreign key, this is fine.

Its still a monolith, but a very decoupled one. It's very easy to extract a module as a microservice from this level.

## Level 4

### Microservices

![Microservices](/assets/modularity/modularity_level4_microservice.svg){:width="25%" .textwrap}



