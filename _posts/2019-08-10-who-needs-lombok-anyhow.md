Java is quite a verbose language and annotations can solve almost any problem.
Right? - What a dangerous combination that is. 

I understand it, totally. I'm lazy too.
But other than saving all that boilerplate, have you considered the repercussions?

### Magic is harmful
I don't want any magic in my code. 
It is the thing that makes behaviour opaque.
It makes you fire up your debugger, because you don't actually understand what is going on behind the scenes.
There should be no _behind the scenes_.
Everything should be as explicit as possible, for economic reasons.
> Magic is a feature with non-compositional semantics that succeeds in making the common case easy, at the cost of making the uncommon cases surprising, impossible, or ridiculously complex.
>
>~ John A De Goes

### @Data, @Getter and @Setter are a design smell
When I design the objects of my domain I want to avoid accessors.
I want those objects to represent a set of behaviours on nicely encapsulated data. 
I'll occasionally have some public fields on my _Value Objects_, but that's about it. 
Why would I want getters or setters on these objects? They are a backdoor to the data that ought to be modified through specific methods. 
This smells like [Feature Envy](https://refactoring.guru/smells/feature-envy) and [Anemic Domain Model](https://martinfowler.com/bliki/AnemicDomainModel.html).

Also, setters work against my intention of making most of my objects immutable.
After all, immutable objects are easier to refactor.

So where do I need accessors then?
Maybe on my data transfer objects?
Why would I want to go the length of making fields private and creating accessors on a structure that is solely data?
Does this kind of information hiding provide _any_ value? To me, it is just clutter.
`public final` fields without accessors are a much cleaner solution here imho.
And there I am, left without a need for accessors.

### @AllArgsConstructor introduces connascence of position
This awful annotation couples the order of your fields to the order of its generated constructor arguments.
So when you reorder your fields, you effectively break your code.
That's an awful [connascence of position](https://en.wikipedia.org/wiki/Connascence#Connascence_of_Position_(CoP)) right there. 

### Bi-directional object relations cause stack overflows 
So when you use Lomboks _equals_, _hashCode_ or _toString_ implementations, it is interresting that bi-directional associations will cause a stack overflow.
I'm not saying bi-directional associations are desirable, or that those stack overflows aren't obvious.
All I am saying is, that if Lombok was just a little bit smarter, it could probably have avoided those. 

The bad thing is not the stack overflow. It's the fact that it is hidden behind an annotation.

### The Lombok plugin might hit your cpu
If you do use lombok annotations excessively and have a lot of pojos in your code base, the lombok plugin might hit your cpu.
I had one project where it caused the autocomplete drop down to load several seconds in specific areas of the code.
The problem was gone once I deactivated the plugin.
To be fair: Maybe it was just a temporary problem with the plugin that has already been addressed. 

### Compatibility issues with Java versions greater than 8 
When I tried migrating a java 1.8 project that used lombok to java 11, I ran into issues.
And despite the [known issues](https://stackoverflow.com/questions/53866929/unable-to-use-lombok-with-java-11) and [fixes](https://github.com/rzwitserloot/lombok/issues/1723) that I found on the internet, I was not able to get it to work again within 2 hours of trying.
Delombok to the rescue. 

__update:__ seems like i ran into a similar issue like [this](https://github.com/rzwitserloot/lombok/issues/1723), trying to upgrade to java 11. 


## Without lombok, what are the alternatives?
We can just fall back to explicit pojo code. Some libs, ide features and plugins will help us out with the boilerplate. 
Also, we may use Java records starting with Java 14. 

### equals and hashcode
For value objects, where you want all fields included, the apache commons lang [EqualsBuilder](http://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/builder/EqualsBuilder.html) and [HashCodeBuilder](http://commons.apache.org/proper/commons-lang/apidocs/org/apache/commons/lang3/builder/HashCodeBuilder.html) come in handy.
```
@Override
public boolean equals(Object that) {
    return EqualsBuilder.reflectionEquals(this, that);
}
 
@Override
public int hashCode() {
    return HashCodeBuilder.reflectionHashCode(this);
}
```

maybe even use an intellij live template like this:
```
@Override
public boolean equals(Object that) {
    return org.apache.commons.lang3.builder.EqualsBuilder.reflectionEquals(this, that);
}

@Override
public int hashCode() {
    return org.apache.commons.lang3.builder.HashCodeBuilder.reflectionHashCode(this);
}
```

### @Slf4j
I recommend using an intellij live template again.
```
// just put in 'className()' for the $CLASS$ variable
private static final org.slf4j.Logger LOG = org.slf4j.LoggerFactory.getLogger($CLASS$.class);
```

![Logger via live template](/assets/img/log_live_template.gif)

### @Builder
I really like the builder generation plugins that are freely available on the intellij plugin market.

- [Inner Builder](https://plugins.jetbrains.com/plugin/7354-innerbuilder)
- [Builder Generator](https://plugins.jetbrains.com/plugin/6585-builder-generator)

Also, there is a new [__Replace Constructor with Builder__](https://www.jetbrains.com/help/idea/replace-constructor-with-builder.html) refactoring available now.
However, I prefer the __Inner Builder__ plugin.

## A case for Delombok
Thankfully, there is this nice little feature called delombok.
It will transform all your former lombok annotations into the ugly boilerplate they created behind the scenes,
so you can completely get rid of it.
Don't expect a beautiful outcome though, the generated code will contain a lot of `@SuppressWarnings("all")`.
Also, the delombok feature of my intellij plugin caused my ide to freeze.
So I had to use the [Lombok Maven Plugin](http://anthonywhitford.com/lombok.maven/lombok-maven-plugin/usage.html) instead, it worked just fine.
