---
layout: default
title: Working Groups
categories:
 - "working-groups"
---

<div class="border">
  <h4><a name="working"></a>WORKING GROUPS</h4>
</div>

{% assign groups = site["groups"] | sort: "order" %}

{% for group in groups %}
<p>
  {% assign leads = site["people"] | where: "groups", group.title | sort: "title" %}
  {% assign numleads = leads | size %}
  <ul>
    <li><strong>{{ group.title | upcase }}</strong>: {{ group.tagline }}.
    {% if numleads > 1 %}
      Co-leaders:
    {% else %}
      Led by:
    {% endif %}
    <ul>
  {% for lead in leads%}
      <li><a href="{{ lead.url }}" title="{{ lead.title }}">{{lead.firstname}} {{ lead.title }}</a> - {{lead.affiliation}}</li>
  {% endfor %}
    </ul>
    </li>
  </ul>
</p>
{% endfor %}

<br>
<p> <a href="/people"> Back to People </a> </p>

