---
layout: post
category: refactoring-java
title: 'extract value object'
date: 2019-11-24
---

A value object is a reusable, immutable object that does not only encapsulate a primitive value, but also its behaviour.
Identifying and extracting those value objects improve the cohesion in our code, and avoids duplication.
Suppose i created a new component that consumed an already existing value object, i would be able to reuse the values methods instead of implementing duplicated code by accident.

{% include youtube-player.html id="xLSJk1OcAhA" %}
[the code on my GitHub](https://github.com/gregorriegler/refactoring-extract-value-object)