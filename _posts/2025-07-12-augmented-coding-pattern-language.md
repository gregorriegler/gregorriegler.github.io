---
layout: post
title: Augmented Coding - A Pattern Language
tags: 
- Augmented Coding
---

I was trying to get an LLM to perform TDD first when ChatGPT 3.5 was released in 2022. They added the possibility for the LLM to execute Python code back then. And you could create "GPTs", agents that use your own system prompt kinda. Back then I created a [Software Crafter GPT](https://chatgpt.com/g/g-MWGfe0UQn-software-crafter). It could do simple katas. But its capabilities were quite limited, to be honest. Also, considering that it was previously trained on such kata code before, it was not really something special. In the following months I did not witness much improvement in the LLM space. It felt more like a stagnation. I was sceptical about it all, and still am.

But in the recent weeks I had a few successes with LLM-assisted development, and it was quite fun. Models and tooling have gotten better and actually useful for coding. There are still limits of course, but it's good enough to find joy in trying to get the most out of it. I spent a lot of time doing augmented coding and had quite some learnings. I was trying to make it perform better and better, moving the autonomy slider up. This post introduces a *pattern language* about some of the things I learned work. Some of the examples are demoed with the [simple-agent](https://github.com/gregorriegler/simple-agent).


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

### 📍 Starter Symbol
**Pattern:** *Process Identity*

Leading emojis are what LLMs are known for. You look at an article containing a lot of leading emojis and immediately think: "Generated!!" When the agent starts its message with an emoji, this symbol becomes a declaring header about the state of the process. It gives us feedback on where the agent is right now—and what it is doing.
Also, when it's missing, you know there's something not quite right. Maybe the context has gotten too large, and it's drifting.
This is a lot of valuable feedback you receive just for a single character.
Guide the agent which starter symbol to use.

#### Starter Symbol example (excerpt from rules file)

```
ALWAYS start your answers with a STARTER_SYMBOL
The default STARTER_SYMBOL is 🐙
```

### 📄 Process File
**Pattern:** *Externalize the task.*

A *Process File* describes what the agent is supposed to do. It can live alongside your code or documentation, and it should link to all relevant information — source files, goals, constraints, etc.

A good Process File is small and focuses on a single thing.
Describe the high-level intent at first.
Also list all the steps the agent should follow in order to complete the task according to your needs.

The natural and very convenient evolution of Process Files are [slash commands](https://docs.anthropic.com/en/docs/claude-code/slash-commands). They don't fully replace process files, but they can be a convenient entrypoint to a process.

#### Process File example: `simple-task.md`

```md
STARTER_SYMBOL=✅

# Simple Task

Intent: Work on a small task while making sure the tests keep passing.
Make sure we don't accidentally add unwanted changes. 

1. Make sure the `git status` is clean and shows no changes
2. Make sure the tests pass before we start. Run `test.sh`.
3. Execute the given Task.
4. Make sure the tests pass again afterwards.
5. Ask me to commit.
```
**Prompt:** Read and follow **@simple-task.md**; the task is to delete all comments from the code.

### 🪃 Subagent / Subtask / Boomerang
**Pattern:** *Context engineering via delegation.*

A Subagent is when the Agent starts another one with a fresh context to reduce the sizes of the context windows. Necessary information is passed through [Cross-Context Memory](#-cross-context-memory) or prompt. Once completed, the Subagent summarizes its result and returns it to the initiator.

#### Subagent example

**Prompt:** Start a subagent that says hello.

```
❯ ./agent.sh Start a subagent that says hello
Starting new session

Agent: I'll create a subagent with a simple task to say hello.
  🛠️ subagent Say hello to the user in a friendly way.

    Subagent: Let me create a friendly greeting message in a file.
      🛠️ create-file greeting.txt Hello! 👋
      Created file: greeting.txt with content

    Subagent: Let me show you the greeting I created.
      🛠️ cat greeting.txt
          1    Hello! 👋
```

### ⛓️ Taskchain
**Pattern:** *Link SubTasks together.*

A Taskchain is a series of [SubTasks](#-subagent--subtask--boomerang) that call one another in sequence. Each task hands off to the next, forming a chain of autonomous steps that proceed without user intervention. This leads to a long list of summaries in the end, as all Tasks close only then.

#### Taskchain example: Test First

```md
# Write a failing Test

STARTER_SYMBOL=🔴

1. Pick the next item from the testlist.
2. Write the failing test
3. Run the test and see it fail
4. Start a subtask with the prompt 
   "Read and follow `process/make-it-pass.md`, the test is <testname>"
```

See how "Write a failing Test" links to `process/make-it-pass.md` in its fourth step.
It uses the [Subagent pattern](#-subagent--subtask--boomerang) to start a fresh context for this task. 

##### Contents of process/make-it-pass.md
```md
# Make the failing test pass

STARTER_SYMBOL=🟢

1. Run the tests, there should be exactly one failing test.
2. Make the smallest possible change to the production code 
   to make the failing test and all other tests pass
3. Run the tests, and see them pass
```

### 🔁 Loop
**Pattern:** *Keep going.*

A Loop is a Task or Task Chain that reinitiates itself. Its nature is recursive in order to maintain longer autonomy while preventing context drift. It typically progresses by changing [Cross-Context Memory](#-cross-context-memory) across iterations, refining results or advancing through a workflow.

#### Loop example: Counter

##### Contents of count.md
```md
- Increment the prompted number by 1 and remember it as RESULT
- Spawn a subagent with the prompt 
   "Read and follow `count.md`, start with the number <RESULT>"
```

##### Demo run
```
❯ ./agent.sh read count.md and start with the number 1
Agent: Let me read the count.md file first.
Agent: Following the instructions:
  1. Starting number is 1
  2. Incrementing by 1: RESULT = 2
  3. Spawning subagent with the new number
  🛠️ subagent Read and follow `count.md`, start with the number 2

  Subagent: Let me check the contents of count.md first.
  Subagent: The instructions tell me to:
    1. Increment 2 by 1, so RESULT = 3
    2. Spawn a subagent to continue counting with RESULT (3)
    🛠️ subagent Read and follow `count.md`, start with the number 3

    Subagent: Let me check the contents of count.md first.
    Subagent: I'll follow the instructions:
      1. Starting number is 3
      2. Increment by 1: RESULT = 4
      3. Spawn a subagent with the specified prompt
      🛠️ subagent Read and follow `count.md`, start with the number 4
...
Exiting...
```

### 🔀 Condition
**Pattern:** *Fuzzy decision making.*

Use natural language conditions to guide agent behavior. This can be rigid boolean logic, or very fuzzy. These conditions can be contextual and interpretive. They might be based on a [State Indicator](#-state-indicator) or other implicit context state. This allows for a more human-like decision making in an automated processes.

#### Condition example: Stop when uncommitted changes are detected.
Lets take the Simple Task example from above and add a condition with step 2:
```md
...
1. Make sure the `git status` is clean and shows no changes
2. When there are any uncommitted changes, **STOP** immediately.
3. Make sure the tests pass before we start. Run `test.sh`.
...
```

### ➡️ Goto
**Pattern:** *Exit a loop, or just follow a different path.*

Use a [condition](#-condition) to determine whether to jump out of a [loop](#-loop). A loop may have several exits in different places based on different conditions.

#### Loop example: Count til 10

##### Contents of count.md
```md
- Increment the prompted number by 1 and remember it as RESULT
- If the RESULT is 10 end.
- If the RESULT is lower than 10 spawn a subagent with the prompt 
   "Read and follow `count.md`, start with the number <RESULT>"
```

### 🧭 Orchestrator
**Pattern:** *A guiding process launching the correct sub-processes in the right order.*

An *Orchestrator* is a Process whose sole purpose is to initiate other processes using [Subagent](#-subagent--subtask--boomerang), and to do so in the correct order. It acts as a conductor, calling out which [Process File](#-process-file) should run next. It may use a State Machine to keep track of what's been completed and what comes next.

#### Orchestrator example: Basic Refactoring
Each step is just creating another subagent and feeding the result into the next subagent.

```md
# Refactor

STARTER_SYMBOL=🧹

1. Initiate a new subtask to analyze the given code and 
   find a small step that improves its design. 
   Don't implement the change, just report back the 
   result of the analysis.
2. Initiate a new subtask to decompose the proposed 
   design improvement to a plan of many small refactoring steps. 
   Each step should leave the code working. Don't execute yet, 
   just close the task reporting back the plan.
3. Execute the planned refactoring steps, creating a new subtask 
   for each step where you run the tests before and after 
   the changes.
```

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
Decompose large processes into smaller ones, and track progress between them with explicit markers or checkpoints. Use [Cross-Context Memory](#-cross-context-memory) to remember what's necessary. This can be achieved by moving steps into another [Process File](#-process-file) and using a [Boomerang](#-subagent--subtask--boomerang) to invoke it from the original file. Another way to split the process is to put each piece into its own file and coordinate them with an [Orchestrator](#-orchestrator).

### 🎛️ Extract Coordinator
**Pattern:** *Pull coordination logic out of individual chain elements.*

A [Task Chain](#-taskchain) is a good starting point, but orchestration provides better control and maintainability.
The problem with Task Chains is that each element carries dual responsibility: performing its own work and managing the handoff to the next segment. This creates tight coupling and makes recovery complex.
We can separate these concerns by extracting the coordination responsibility into an [Orchestrator](#-orchestrator).
The individual segments then focus solely on their core work, while the orchestrator manages the sequence, and recovery logic from a single location.
Use a [State Indicator](#-state-indicator) to track progress through the orchestrated workflow.

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
**Pattern:** *Keep the solution space open.*

Don’t tell the agent what to do, unless you're confident in the path forward. Consider that you might be wrong, or missing information. By telling it what to do, you're narrowing the solution space and leading the agent down a failure path. Don’t do that.

Instead, leverage its knowledge.
Ask the right question to withdraw the relevant information into the context. Then use it, or store it in a relevant memory. This not only leads to better results — it creates a learning opportunity.

### 🚧 Constraints
**Pattern:** *Keep it on a short leash.*

The best way to help the agent avoid mistakes is to constrain what it can do. Instead of changing code freely, we can give it access to refactoring tools. We can lock it out of certain files or commands. Constraints are more than just rules — they shape what the agent can do or not do in its environment, enabling better and more reliable outputs.

### 🛑 Abort
**Pattern:** *Keep your finger on the abort button.*

When the agent goes off the rails, for example when it does something it should not do, I like to stop it as quickly as I can.
The earlier I do that, the better I avoid contamination of the context.
Then I am more likely to help it recover without messing up the process.
I like to use [Ask, don't tell](#-ask-dont-tell) when giving it recovery instructions.

### ⚙️ Algorithmify
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

## Influences & Inspirations

It was LLewellyn Falco who first showed me the starter symbol as well as the process file pattern. The idea and framing of Augmented Coding was at first sparked by Kent Beck. I discovered subtasking through the usage of Roo Code which already had this feature. 
