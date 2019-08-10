Who needs lombok anyhow

Java is such a verbose language, isn't it?
Annotations are nice, aren't they? Annotations can solve any problem. 
Let's save java from it's verbosity using annotations, shall we?

@Data, @Getter and @Setter
Getters are Backdoors.
First of all: When i design the objects of my domain (Entities and Values) i want to avoid accessors.
I want those objects to represent a set of behaviours on specific data, nicely encapsulated. 
I don't want getters on these objects. 
Getters are not behavoiur, they are backdoors to the data. 
Why do i need a backdoor?
Probably because i have a flaw in my design. 
Probably i have some other object that envys this one for its data, a feature envy (link).
If i did design more carefully, maybe i could find a way and put this data and the behaviour acting on it into the same object, avoiding the backdoor.
I don't want setters on these objects either.
If i can make them immutable, that's perfect. Less dependencies, easier refactoring, no need for setters.
If i need mutability in some of the fields, then there probably is some kind of logic involved with changing the data. 
Then i will add specific methods for this which execute the logic AND set the data.
These are not setters anymore, these are behaviour.
So where do i need accessors then?
Maybe on my data transfer objects?
No, those are just data. 
Why would i want to go the length of making the fields private and creating accessors on a structure that is solely data?
Does this kind of information hiding provide ANY value?
Public fields without accessors are a much better design for those data classes.
There we are, no more reason for accessors.
Turns out they are a code smell.


Magic is harmfull

Performance on autocomplete went to hell

@AllArgsConstructor field reihenfolge
bi-directional relation: toString, eq, hashcode overflow
setters as a codesmell
log 
Delombok

alternatives:
eq, hashcode with live templates and apache reflect utils,

log via live template
[img/log_live_template.gif]
public final fields on data
no setters on entities & value
builder with inner builder plugin