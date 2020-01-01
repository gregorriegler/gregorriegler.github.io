---
layout: post
category: refactoring-java
title: 'split phase'
date: 2019-11-24
---

In a split phase refactoring, we split a tangled piece of code that does more than one thing into distinguished phases that only do a single thing.
As a result we can more easily and independently change each of the resulting phases.

{% include youtube-player.html id="sIceCgI6QO0" %}
[the code on my GitHub](https://github.com/gregorriegler/refactoring-split-phase)