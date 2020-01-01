---
layout: post
category: refactoring-java
title: 'conditional to polymorphism'
date: 2019-12-02
---

A conditional, like a switch statement can sometimes be fraudulent. 
It appears to be a nice and simple solution when it is in fact hiding and provoking duplication.
By refactoring to polymorphism we adhere to the 'Tell Don't Ask' principle and get rid of the duplicated parts.

{% include youtube-player.html id="YEPaGWYkL74" %}
[the code on my GitHub](https://github.com/gregorriegler/refactoring-conditional-to-polymorphism)