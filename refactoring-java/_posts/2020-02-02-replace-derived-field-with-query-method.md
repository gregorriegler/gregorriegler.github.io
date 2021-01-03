---
layout: post
category: refactoring-java
title: 'Replace derived with query (coffee machine part 4)'
date: 2020-02-02
---

A derived field is similar to a cache in the sense that you have to actively maintain its state throughout everything that is happening in your domain.
So it is similarly complex to cache invalidation.
We can replace it with a query method, and get rid of the complication.
This doesn't mean we can't add caching to the query method later. 
We can easily add this cross-cutting concern later on using [memoization](https://stackoverflow.com/a/27549948) or a decorator pattern if we really need it.

{% include youtube-player.html id="eXElxR1_qOo" %}

[The code on my GitHub](https://github.com/gregorriegler/coffeemachine-kata)