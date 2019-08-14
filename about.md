---
layout: page
title: about
sidebar_link: true
sidebar_sort_order: 0
---

I learned creating good software the hard way. 

### Mistakes were made

* In 2007 i built websites by writing inline css in html in php in js in html in a php file. It was ajax, well sorta :-).

* In 2008 i was working on a company cms that added parameters to sql queries via string concatenation and very poor sanitization. It obviously got hacked at some point, leading to a disaster for the company.

* In 2010 i wrote my own ORM and it didn't support lazy loading. I think you can imagine what the performance was like. I learned a lot doing it, but thats the only positive aspect i can think of.

* In 2011 i was maintaining a prototype-turned-production incident management system for public transport. It was stuffed with commented out code, and i was afraid to delete it for weeks. Gosh, i should have deleted it right away. It was in this project that i learned feeling more comfortable in throwing code away.

* In 2012 i wrote a 3-figure page long scope statement that got signed by the customer. Turned out it was as worthy as a toiletpaper just a few days later.

* In 2013 i attempted to use an extensive, standardized data-transfer model as the internal model of an application in which the database technology was already decided. Not only was the database a bad fit and chosen way too early, it was also a terrible idea to use this heavy model as the internal model. It would have been ok to keep a copy of the messages, but the business rules should have been based on a separate simplified internal model. 

* In 2014 i developed an enterprise web application in a tdd style using mainly integrated tests that used an embedded database. The tests were nicely decoupled from the structure of the code, but at one point the commit suite took more than 10 minutes to complete. Colleagues started to skip running the tests. It was in this moment i knew i never wanted a commit suite run longer than 1-2 minutes. Sociable unittests are fine, but integrationtests are a scam.

* In 2018 i was working on a project where annotations were heavily used to not only automatically generate constructors, getters, setters and builders on entities, but as well to magically map data from entities to dtos and vice versa. The automated code generation slowed down my IDE so much that in some files it took 15 seconds to load the code completion menu. Getters/Setters are harmful to Objects and hiding such code behind annotations is even worse. Same goes for data mapping - the more magic added, the less maintainable it becomes. You can do almost anything with annotations and it's tempting, i know. But they do more harm than good, as they obscure behaviour, sneak in unwanted dependencies and add too much clutter. 
