---
layout: post
title: Augmented Coding - A Pattern Language
tags: 
- Augmented Coding
---

I was trying to get an LLM to perform TDD first when ChatGPT 3.5 was released in 2022. They added the possibility for the LLM to execute Python code back then. And you could create "GPTs", agents that use your own system prompt kinda. Back then I created a [Software Crafter GPT](https://chatgpt.com/g/g-MWGfe0UQn-software-crafter). It could do simple katas. But its capabilities were quite limited, to be honest. Also, considering that it was previously trained on such kata code before, it was not really something special. In the following months I did not witness much improvement in the LLM space. It felt more like a stagnation. I was sceptical about it all, and still am.

But in the recent weeks I had a few successes with LLM-assisted development, and it was quite fun. Models and tooling have gotten better and actually useful for coding. There are still limits of course, but it's good enough to find joy in trying to get the most out of it. I spent a lot of time doing augmented coding and had quite some learnings. I was trying to make it perform better and better, moving the autonomy slider up. This post introduces a *pattern language* about some of the things I learned work.


## Basics

### 🤖 Agent
**Pattern:** *Give the LLM Agency*

An Agent in its simplest form is nothing more than a loop that facilitates a dialog with a language model that allows it to execute tools. More advanced Agents track context size, embed custom system prompts, provide different modes, let you choose the language model and do advanced context management. The Agent is the engine of augmented work.

### 🧠 To Augment Oneself
**Pattern:** *Project what you are doing.*

For me, augmentation is a learning process where we discover our habits, decisions and workflows and capture them into clear artifacts that are so precise that an agent can follow and thus imitate us. Before asking the agent to take action, pause to explore what you would do if you were doing it yourself. What steps would you take? What considerations matter? Describe that process to the agent. Externalize your own reasoning, step by step, so the agent can pick it up and run with it. Think of it as constructing a functional representation of yourself.
Often we have to go through the motions ourselves to surface unconscious decisions. In augmenting we learn about our own thinking and workflow.

## 🌐 **HATEOAG** (Hypertext as the Engine of Agent Guidance)

Inspired by HATEOAS, this pattern treats hypertext as the driving mechanism for agent navigation and behavior. Hypertext guides the agent through a network of clearly defined, interlinked processes, memory, documentation files and code.

Links invite the agent to jump, read, or act.

### 📄 Process File
**Pattern:** *Externalize the task.*

A *Process File* describes what the agent is supposed to do. It can live alongside your code or documentation, and it should link to all relevant information — source files, goals, constraints, etc.

A good Process File is small and focuses on a single thing.

### 📍 Starter Symbol
**Pattern:** *Process Identity*

Leading emojis are what LLMs are known for. You look at an article containing a lot of leading emojis and immediately think: "Generated!!" When the agent starts its message with an emoji, this symbol becomes a declaring header about the state of the process. It gives us feedback on where the agent is right now—and what it is doing.
Also, when it's missing, you know there's something not quite right. Maybe the context has gotten too large, and the agent started forgetting things.
This is a lot of valuable feedback you receive just for a single character.

### 🪃 Boomerang / SubTask
**Pattern:** *Context engineering via delegation.*

A SubTask is when the Agent starts its next context at a specific step in the process, often to reduce the size of the context window. Necessary information is passed through [Cross-Context Memory](#-cross-context-memory) or prompt. Once completed, the SubTask summarizes its result and returns it to the initiator.

### ⛓️ Taskchain
**Pattern:** *Link SubTasks together.*

A Taskchain is a series of [SubTasks](#-boomerang--subtask) that call one another in sequence. Each task hands off to the next, forming a chain of autonomous steps that proceed without user intervention. This leads to a long list of summaries in the end, as all Tasks close only then.

### 🔁 Loop
**Pattern:** *Keep going.*

A Loop is a Task or Task Chain that reinitiates itself. Its nature is recursive in order to maintain longer autonomy while preventing context drift. It typically progresses by changing [Cross-Context Memory](#-cross-context-memory) across iterations, refining results or advancing through a workflow.

### 🔀 Condition
**Pattern:** *Fuzzy decision making.*

Use natural language conditions to guide agent behavior. This can be rigid boolean logic, or very fuzzy. These conditions can be contextual and interpretive. They might be based on a [State Indicator](#-state-indicator) or other implicit context state. This allows for a more human-like decision making in an automated processes.

### ➡️ Goto
**Pattern:** *Exit a loop, or just follow a different path.*

Use a [condition](#-condition) to determine whether to jump out of a [loop](#-loop). A loop may have several exits in different places based on different conditions.

### 🧭 Orchestrator
**Pattern:** *A guiding process launching the correct sub-processes in the right order.*

An *Orchestrator* is a Process whose sole purpose is to initiate other processes using [Boomerang](#-boomerang--subtask), and to do so in the correct order. It acts as a conductor, calling out which [Process File](#-process-file) should run next. It may use a State Machine to keep track of what's been completed and what comes next.

### 💾 Cross-Context Memory
**Pattern:** *Preserve memory between runs.*

AI agents forget everything between contexts. Use Persistent Cross-Context Memory — a file or shared storage — to explicitly write down and reload facts, goals, decisions, and task progress. Treat this as the agent's long-term memory.

### 🚦 State Indicator
**Pattern:** *Build a State Machine by memorizing where you are in the process.*

We may track process state using a State Indicator.
A simple State Indicator consists of a [Starter Symbol](#-starter-symbol) and a descriptive keyword.
A more complicated one could span over many lines and contain structured information.
This enables resilient restarts from any point without losing that context.
The process of course needs to include steps to adapt the State Indicator.

### 🧰 StateMachine as a Tool
**Pattern:** *Use a tool to drive the process.*

State does not have to be just text, and a state machine does not have to be just a description of how the state may change. It can be a tool serving commands that describe the next possible actions and transitions, constraining the agent. This makes the tool a control mechanism.

### 🗣️ Dialog
**Pattern:** *Interactive ideation.*

For human-in-the-loop ideation, it’s helpful to invite the agent to ask questions or critique ideas. Consider that the LLM has read the whole Internet. It knows things that we don't, and it is often helpful to leverage that.

### 🔔 Wake
**Pattern:** *Signal for attention.*

Sometimes the Agent needs your input. Maybe it has a question, or it needs a review. Use a Signal step to make it speak up or play a sound — so you can focus on other things in the meantime.

## Evolving the Process
### 📦 Process as Code

**Pattern:** *Treat process definitions like code.*
Process definitions should be:

* Version controlled
* Incrementally improved
* Tested through usage
* Refactored for clarity and smaller context
* Composed into larger workflows

### ✂️ Split Process
**Pattern:** *Divide to prevent drift.*

Long processes can lead to missing steps. 
Just as we do, agents seem to have limited cognitive capacity. 
The more context the agent has to hold in memory, the more likely it is to forget or skip parts of the process. 
The smaller and more focused the context, the more reliably the agent can follow through and perform. 
Decompose large processes into smaller ones, and track progress between them with explicit markers or checkpoints. Use [Cross-Context Memory](#-cross-context-memory) to remember what's necessary. This can be achieved by moving steps into another [Process File](#-process-file) and using a [Boomerang](#-boomerang--subtask) to invoke it from the original file. Another way to split the process is to put each piece into its own file and coordinate them with an [Orchestrator](#-orchestrator).

### 🧪 Practice Run
**Pattern:** *Refine the process through practice.*

Build a feature not for its own sake, but to test and refine the process. Then, throw the feature away. What did you learn? What went well? Adapt small things in the process and restart.

### 🧾 Expose Decisions
**Pattern:** *Make implicit context explicit.*

As you evolve your workflows, make hidden, implicit context and decisions visible and explicit. Capture the state it's based on and make it persistent. Capture the decisions made and describe them. Explicit state and decisions make the process more resilient.

## What works well

### 🪜 One problem at a time
**Pattern:** *Smaller is better. Refine the refined.*

The LLM typically wants to perform too many changes and do too many things at once. It also tends to plan this way — no wonder, given the world it was trained on. To achieve better results, break big steps into smaller, clearer ones. And when you've done that, take the smallest step and let the agent break it down even further. Always start with the tiniest one, and solve one problem at a time. Vertical slicing and TDD ZOMBIES have proven effective.

### ✅ Test First
**Pattern:** *Start with the end in mind.*

No production code without a failing test. This is now more obvious than ever. The agent needs all the feedback it can get. Make sure it doesn't break things, and keep the code running all the time.

### 🤔 Hypothesize
**Pattern:** *Have the agent state what it expects to happen.*

The Agent is often wrong about a code change. When that happens, it will attempt to recover from the situation, taking several tries. These will inevitably contaminate the context. It may even lead to the agent giving up and making things worse by leaving unintended changes — often stating that it indeed solved the problem. I found it helpful to have the agent express its expectations about a code change first, before it runs the code. For example, before it runs a failing test, it can express what it expects to happen. This reinforces the actual intent in the context.

### ❓ Ask, don’t tell.
**Pattern:** *Don't narrow down the solution space prematurely.*

Don’t tell the agent what to do, unless you're confident in the path forward. Consider that you might be wrong, or missing information. By telling it what to do, you're narrowing the solution space and leading the agent down a failure path. Don’t do that.

Instead, leverage its knowledge.
Ask the right question to withdraw the relevant information into the context. Then use it, or store it in a relevant memory. This not only leads to better results — it creates a learning opportunity.

### 🚧 Constraints
**Pattern:** *Keep it on a short leash.*

The best way to help the agent avoid mistakes is to constrain what it can do. Instead of changing code freely, we can give it access to refactoring tools. We can lock it out of certain files or commands. Constraints are more than just rules — they shape what the agent can do or not do in its environment, enabling better and more reliable outputs.

### ⚙️ Automate
**Pattern:** *Automate whatever can be automated.*

Favor algorithms over stochastic outputs to avoid mistakes and have the agent write its own automation. It's really good at this. What is automated:
 - is deterministic.
 - preserves cognitive capacity for other things.
 - is often faster.

Therefore, we want to automate as much as possible.

### 🖥️ CLI First
**Pattern:** *Let the agent thrive on the CLI.*

Agent tooling should be CLI-first. The LLM’s native medium is chat — text in, text out. This is exactly what the CLI was made for. On top of that, it offers many small, composable Unix-style tools. Agents thrive on the command line — give them tools there.

## Conclusion
I see a lot of "agile" in the things that work well for me. Things like inspect and adapt, continuous improvement, small steps, iterate, TDD. The LLM is trained on and born into a waterfall world. When I look at the tooling people develop around it, and the things people do with it, I often see waterfall, too. And I see a lot of legacy code going to emerge. Maybe we can do better.
