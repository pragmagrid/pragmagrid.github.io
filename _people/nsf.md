---
layout: default
title: NSF PRAGMA Award Investigators 
categories:
 - "nsf"
---

<div class="border">
  <h4><a name="nsf"></a>NSF PRAGMA AWARD INVESTIGATORS</h4>
</div>

{% assign nsf = site["people"] | where: "categories", "nsf" | sort: "title" %}
  <ul>
  {% for pi in nsf %}
      <li><a href="{{ pi.url }}" title="{{ pi.title }}">{{pi.firstname}} {{ pi.title }}</a> - {{pi.affiliation}}</li>
  {% endfor %}
  </ul>


<br>
<p> <a href="/people"> Back to People </a> </p>

