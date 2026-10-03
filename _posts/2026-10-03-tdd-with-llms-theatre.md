---
layout: post
title: "TDD with LLMs: theatre?"
tags: 
- Software Craft
- AI
- TDD
---

I've recently seen a lot of folks discussing whether TDD is theatre when coding with LLMs:

- [Birgitta's article](https://martinfowler.com/articles/exploring-gen-ai/tdd-in-the-agent-loop.html), which ignited the discussion
- [Alex Bolboaca's video blog](https://www.youtube.com/watch?v=gcCfNzmk4pI)
- [Emily Bache's answer](https://www.youtube.com/watch?v=wK5WgbqtI50)

But I also see a lot of posts and discussions on social media, where people often even have different understandings of what TDD means.

So I want to first explain what I found valuable in following TDD before we had LLMs, and then comparing this to how it changes in a world where we use LLMs to write code.

I don't write code anymore, I let an LLM write my code, at a speed that is adaptive to the importance of the respective code, and allows me to stay on top and interfere.

Now onto the values of TDD.

## Dense coverage and a stable safety net

With TDD we end up with more tests than code, where every test is tied to behavior someone actually needs. Running them answers "does everything still work?" That removes fear, and enables continuous refactoring.

So with LLMs we still want the safety net, and the ability to refactor. And we still want the tests to be written first. A suite generated after the fact, to match what the model wrote, proves little; it most likely just tests implementation. And those tests are bad. Bad tests are worse than no tests. Refactoring without touching the tests is the main lever for letting a model rework code at all: you can ask for a large internal change and know that when the tests weren't changed and stayed green, nothing broke.

## Honest feedback and surprises

In TDD you first have to prove that a feature is missing by writing a failing test. Sometimes this is surprising: The supposedly red test might already pass. That exposes a gap in your understanding: The behavior either already existed, or the test did not check what you thought.

Those surprises happen to LLMs, too. They are sometimes wrong, and we want to reveal the gaps in the model's picture of the code, and trigger this impromptu learning.

## Interface designed from the consumer's perspective

In TDD, the test is the first user of the code you are going to write, so you design for need and ease of use. And you build only what a user requires, so there's no room for speculative API or features.

With LLMs this gets stronger. A test written first is also the cheapest and most exact way to tell a model what is required: it fixes names, arguments, results and behavior, with no room for interpretation. That's why you often have to iterate with the model over a test to land on a good test design. You want to get this right before jumping to implementation. When you can't trust anything, make sure you can trust the tests.

## Testable design

TDD leads to testability which has a strong relationship with modularity. And because tests touch the code only through its interface, you can restructure the inside freely while the tests remain unchanged.

This still holds true with LLMs. Models produce tangled code quickly; nothing in them pulls toward modularity and seams unless something forces it. TDD and human oversight are that force.

## Design questions before, during and after red

A big lever of TDD is that the loop allows you to ask crucial design questions at the right moments.

During writing a failing test, you want to ask: Is it easy or painful to write it? Listen to the test and it will provide valuable design feedback.  
During a hard red: am I fighting the design? A hard red tells me that the step is probably too big. I can go back and try a smaller one. Or adapt the design first.  
After making it green: where could I improve the code? Improve names. Remove duplication. Tackle primitive obsession. And move logic to where it belongs.

This still holds, but the LLM will not feel that pain or ask those questions for you. Given a failing test, a model pushes through. It won't stop to say the design is poor and a refactor should come first. So those questions stay with you. You decide whether it's worth asking the LLM, whether there was a design improvement that would make this change easier. And then the LLM lands the preparatory refactoring. The loop still creates the moments; you have to use them.

## Avoiding waste in overdoing

TDD caps what we build. If a test didn't ask for it, we don't implement it. Full stop.

As the LLM is not trained on TDD, but on generating large volumes of code based on plans, it still typically writes more code than the test demanded: an extra branch or a safety guard nobody asked for. It takes another iteration after the fact to find those: A review by the LLM, or a human asking why the line is there, or a mutation test that indicates the code is dead. Or we acknowledge that the code will be required and add the missing test.

## Avoiding waste in planning

> "It is in the doing of the work that we discover the work that we must do. Doing exposes reality." ~Woody Zuill

TDD keeps you from thinking too far ahead. Plans are nothing but hypotheses. The further you plan, the more likely some of it will be wrong, so deferring decisions until the latest responsible moment means not building, documenting or maintaining things nobody needs.

LLMs are very good at planning large batches, and asking the right questions.  
But I'm still in favor of avoiding too much planning. Because my limited cognitive capacity doesn't allow me to consider it all. With a big plan, when the LLM takes only a small step, it shapes that step to fit the whole plan. So the step might contain decisions you don't understand - for now. This creates confusion. Misalignment and unnecessary correction. It leaves both you and the LLM confused. Planning only as far as the next test avoids this. And it leaves you aligned with the LLM.

## Phases

TDD's focus is to make all code working "being in the green" the default. A test failing "red" is just a brief excursion. And so in TDD we want to go back to green as quickly as possible. A human in a long red loses control and ends up debugging. That's what costs a lot of time and energy.

With LLMs, short reds still matter. A model in a long red thrashes. It rewrites the test to pass, or papers over the failure.

## Step size

A value in TDD is that it allows a human to focus on one thing at a time; everything else waits. Mental load stays small, and when something breaks, it was the last small step. Smaller steps keep a long red from happening. TDD allows us to go back and try a smaller step.

The LLM does not have this need in the same way. It can solve several problems at a time with ease. So steps could be larger. But larger how?  
We could stay on a broader test level such as acceptance tests and avoid granular tests. Or we could write more than one test at a time.  
Either way, large changes are hard to review and understand. When the code is important, we are better off with small reviewable diffs, so that we can stay on top and see what it did poorly.

## Conclusion

A lot of the value TDD gives still holds when coding with LLMs.

Does following TDD slow the LLM down? Yes, necessarily. And the value lies in keeping us humans on top of the loop, in understanding what is going on and in being able to intercept and ask the right questions at the right time.

Could we go faster? Yes, by increasing the batch size. But this comes with a trade-off. The more the LLM generates, the more likely it has flaws, and fixing them might be more effort later. Unnoticed flaws compound and decrease long term maintainability. It can be a conscious trade-off.

Does all code demand the same TDD rigor? No. Not all code is equally important and as likely to change. Code I want to make a living with needs TDD rigor. Code that is small and low risk does not even deserve reading or automated testing.

Tests are more important than code, but this is not necessarily new.
