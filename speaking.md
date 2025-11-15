---
layout: page
title: Public Speaking
sidebar_link: true
sidebar_sort_order: 3
---

{% assign talks = site.data.speaking | sort: 'date' | reverse %}
{% for talk in talks %}
<article class="post-body">
    <h3>{{ talk.title }}</h3>

    <div class="post-meta">
        <span class="post-date">
            {% if talk.display_date %}
                {{ talk.display_date }}
            {% else %}
                {{ talk.date | date: "%-d %B %Y" }}
            {% endif %}
        </span>
    </div>

    {% if talk.youtube_id %}
        {% include youtube-player.html id=talk.youtube_id %}
        <br>
    {% endif %}

    {% if talk.image %}
        <img src="{{ talk.image.src }}" alt="{{ talk.image.alt | escape }}" />
    {% endif %}

    {% if talk.body %}
        {{ talk.body | markdownify }}
    {% endif %}
</article>
{% endfor %}
