---
layout: post
title:  "seamer: a refactoring tool for java"
tags: 
- refactoring
- testing
- java
- seamer
---

Just recently i was refactoring some very messy legacy java code and i stumbled upon this really long and complex method.
I had to refactor it but there were no tests, no safety net, what so ever. 
It had so many different paths that adding unit tests would have been a tedious endeavour.

"Would be nice if had something like [suture](https://github.com/testdouble/suture)", i thought.
So i decided to just code it real quick. 

Here is the result: [https://github.com/gregorriegler/seamer](https://github.com/gregorriegler/seamer).  

Seamer is a refactoring tool for java that helps you get complex methods under test in order to make safe refactorings.

### How does it work?
Basically you just wrap a complex method with a lambda and the seamer will then record all your invocations including 
input arguments and return values, serialize and persist them. 
You can later replay those invocations to make sure everything still works. 

Seamer provides an api for you to make suggestions on the arguments you want to pass in. 
The tool will shuffle your suggestions and execute given arguments in all possible combinations.
Or you can just let it run, click around in your application, and record real values.

When you are confident with the data you have recorded, go ahead and start your refactorings. 
Replay the seamer regularly to make sure everything still works.

If you have ideas for further improvements, feel free to do so, or just make a pull request.

