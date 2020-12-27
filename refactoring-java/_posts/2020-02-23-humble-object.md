---
layout: post
category: refactoring-java
title: 'Humble object'
date: 2020-02-23
---

The [Humble Object Pattern](http://xunitpatterns.com/Humble%20Object.html) is used to separate code that is hard to test from code that is easy to test.
We typically apply this at the boundary where we interact with code we don't own. 
For example a framework.
We make our own code testable by moving the code that interacts with the third party code to a humble object.
It does so little we don't have to test it.

> [Only Mock Types You Own](http://jmock.org/oopsla2004.pdf)

{% include youtube-player.html id="sqZrjps449A" %}

[The code on my GitHub](https://github.com/gregorriegler/dependency-breaker-kata)