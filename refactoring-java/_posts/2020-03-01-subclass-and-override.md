---
layout: post
category: refactoring-java
title: 'Subclass and override'
date: 2020-02-23
---

I like to use [Subclass to Test](https://wiki.c2.com/?SubclassToTest) when i need to refactor first to isolate a proper [Seam](https://wiki.c2.com/?SoftwareSeam).
It helps break a hard dependency and get the legacy code under test.
This pattern is sometimes also called [Test Specific Subclass](http://xunitpatterns.com/Test-Specific%20Subclass.html).

{% include youtube-player.html id="yqzYLm27cGw" %}

[The code on my GitHub](https://github.com/gregorriegler/dependency-breaker-kata)