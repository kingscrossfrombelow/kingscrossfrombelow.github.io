---
layout: page
title: Materials Archive
slug: materials
---

A collection of primary sources, photographs, maps, and documents referenced throughout the book.

## Documents
{% assign docs = site.materials | where: "type", "document" %}
{% for doc in docs %}
- [{{ doc.id }}: {{ doc.title }}]({{ doc.url }})
{% endfor %}

## Photographs
{% assign photos = site.materials | where: "type", "photo" %}
{% for photo in photos %}
- [{{ photo.id }}: {{ photo.title }}]({{ photo.url }})
{% endfor %}

## Maps
{% assign maps = site.materials | where: "type", "map" %}
{% for map in maps %}
- [{{ map.id }}: {{ map.title }}]({{ map.url }})
{% endfor %}
