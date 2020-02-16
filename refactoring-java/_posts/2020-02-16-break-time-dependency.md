---
layout: post
category: refactoring-java
title: 'break time dependency'
date: 2020-02-16
---

When you need to make changes to legacy code it is often a good idea to start with some refactoring.
But to be able to refactor, we first need to put it under test.
And this can be quite challenging, especially when the code contains hard dependencies.
In this video i am demonstrating a way to break a time dependency and make the code testable again.

{% include youtube-player.html id="zKI6z5tOiG0" %}

[The code on my GitHub](https://github.com/gregorriegler/dependency-breaker-kata)