#!/bin/bash

# King's Cross from Below: Materials Substrate Setup
# Run this from inside your cloned repo directory

set -e

echo "Setting up materials substrate system..."

# Create directories
mkdir -p _materials _includes _layouts assets/css assets/materials

# Create _includes/chapter-materials.html
cat > _includes/chapter-materials.html << 'EOF'
{% assign chapter_materials = site.materials | where_exp: "item", "item.chapters contains page.slug" %}

{% assign docs = chapter_materials | where: "type", "document" %}
{% assign photos = chapter_materials | where: "type", "photo" %}
{% assign maps = chapter_materials | where: "type", "map" %}
{% assign tables = chapter_materials | where: "type", "table" %}
{% assign quotes = chapter_materials | where: "type", "quote" %}

{% if docs.size > 0 %}
## Documents

{% for doc in docs %}
- **[{{ doc.id }}: {{ doc.title }}]({{ doc.url }})**  
  {{ doc.caption }}  
  *{{ doc.copyright }}*{% if doc.archive %} — {{ doc.archive }}{% endif %}
{% endfor %}
{% endif %}

{% if photos.size > 0 %}
## Photographs

<div class="photo-grid">
{% for photo in photos %}
<figure>
  <a href="{{ photo.url }}">
    <img src="{{ photo.file }}" alt="{{ photo.alt }}" loading="lazy" />
  </a>
  <figcaption><strong>{{ photo.id }}</strong>: {{ photo.caption }}<br/>
  <small>{{ photo.copyright }}{% if photo.archive %} — {{ photo.archive }}{% endif %}</small></figcaption>
</figure>
{% endfor %}
</div>
{% endif %}

{% if maps.size > 0 %}
## Maps

{% for map in maps %}
- **[{{ map.id }}: {{ map.title }}]({{ map.url }})**  
  {{ map.caption }}  
  *{{ map.copyright }}*{% if map.archive %} — {{ map.archive }}{% endif %}
{% endfor %}
{% endif %}

{% if tables.size > 0 %}
## Tables

{% for table in tables %}
- **[{{ table.id }}: {{ table.title }}]({{ table.url }})**  
  {{ table.caption }}  
  *{{ table.copyright }}*{% if table.archive %} — {{ table.archive }}{% endif %}
{% endfor %}
{% endif %}

{% if quotes.size > 0 %}
## Quoted extracts

{% for quote in quotes %}
- **[{{ quote.id }}: {{ quote.title }}]({{ quote.url }})**  
  {{ quote.caption }}  
  *{{ quote.copyright }}*{% if quote.archive %} — {{ quote.archive }}{% endif %}
{% endfor %}
{% endif %}
EOF

# Create _layouts/material.html
cat > _layouts/material.html << 'EOF'
---
layout: default
---

<article class="material">
  <header>
    <h1>{{ page.id }}: {{ page.title }}</h1>
    <p class="material-meta">
      <strong>Type:</strong> {{ page.type | capitalize }}<br/>
      <strong>Date:</strong> {{ page.date }}
    </p>
  </header>

  {% if page.type == "photo" or page.type == "map" %}
  <figure class="material-figure">
    <img src="{{ page.file }}" alt="{{ page.alt }}" />
    <figcaption>{{ page.caption }}</figcaption>
  </figure>
  {% elsif page.file %}
  <p><a href="{{ page.file }}" class="material-download">Download {{ page.type }}</a></p>
  {% endif %}

  <section class="material-details">
    <h2>Details</h2>
    <dl>
      <dt>Caption</dt>
      <dd>{{ page.caption }}</dd>

      <dt>Copyright</dt>
      <dd>{{ page.copyright }}</dd>

      {% if page.archive %}
      <dt>Archive location</dt>
      <dd>{{ page.archive }}</dd>
      {% endif %}

      {% if page.alt %}
      <dt>Alt text</dt>
      <dd>{{ page.alt }}</dd>
      {% endif %}
    </dl>
  </section>

  <section class="material-citations">
    <h2>Cited in</h2>
    <ul>
    {% for ch in page.chapters %}
      <li><a href="/{{ ch }}.html">{{ ch }}</a></li>
    {% endfor %}
    </ul>
  </section>

  {{ content }}

  <nav class="material-nav">
    <a href="/materials/">← Back to all materials</a>
  </nav>
</article>
EOF

# Create _pages/materials.md
cat > _pages/materials.md << 'EOF'
---
layout: page
title: Materials
permalink: /materials/
description: All documents, photographs, maps, and other materials held in the substrate.
---

# Materials

All documents, photographs, maps, and other materials held in the substrate. Each item records its provenance, copyright, and the chapters in which it is cited.

---

{% assign sorted_materials = site.materials | sort: "id" %}

## Documents

{% assign docs = sorted_materials | where: "type", "document" %}
{% if docs.size > 0 %}
{% for doc in docs %}
- **{{ doc.id }}**: [{{ doc.title }}]({{ doc.url }}) ({{ doc.date }})  
  *{{ doc.copyright }}*{% if doc.archive %} — {{ doc.archive }}{% endif %}  
  Cited in: {% for ch in doc.chapters %}[{{ ch }}](/{{ ch }}.html){% unless forloop.last %}, {% endunless %}{% endfor %}
{% endfor %}
{% else %}
*No documents yet.*
{% endif %}

---

## Photographs

{% assign photos = sorted_materials | where: "type", "photo" %}
{% if photos.size > 0 %}
{% for photo in photos %}
- **{{ photo.id }}**: [{{ photo.title }}]({{ photo.url }}) ({{ photo.date }})  
  *{{ photo.copyright }}*{% if photo.archive %} — {{ photo.archive }}{% endif %}  
  Cited in: {% for ch in photo.chapters %}[{{ ch }}](/{{ ch }}.html){% unless forloop.last %}, {% endunless %}{% endfor %}
{% endfor %}
{% else %}
*No photographs yet.*
{% endif %}

---

## Maps

{% assign maps = sorted_materials | where: "type", "map" %}
{% if maps.size > 0 %}
{% for map in maps %}
- **{{ map.id }}**: [{{ map.title }}]({{ map.url }}) ({{ map.date }})  
  *{{ map.copyright }}*{% if map.archive %} — {{ map.archive }}{% endif %}  
  Cited in: {% for ch in map.chapters %}[{{ ch }}](/{{ ch }}.html){% unless forloop.last %}, {% endunless %}{% endfor %}
{% endfor %}
{% else %}
*No maps yet.*
{% endif %}

---

## Tables

{% assign tables = sorted_materials | where: "type", "table" %}
{% if tables.size > 0 %}
{% for table in tables %}
- **{{ table.id }}**: [{{ table.title }}]({{ table.url }}) ({{ table.date }})  
  *{{ table.copyright }}*{% if table.archive %} — {{ table.archive }}{% endif %}  
  Cited in: {% for ch in table.chapters %}[{{ ch }}](/{{ ch }}.html){% unless forloop.last %}, {% endunless %}{% endfor %}
{% endfor %}
{% else %}
*No tables yet.*
{% endif %}
EOF

# Create sample material: photo
cat > _materials/fig-0-1-york-way.md << 'EOF'
---
id: fig-0-1
title: York Way looking north
type: photo
date: 1984

caption: "York Way looking north from Goods Way, showing the derelict railway lands before redevelopment."
alt: "Black and white photograph of an empty street with warehouse buildings and overgrown railway sidings visible to the right."

copyright: "© Camden Local Studies and Archives"
archive: Camden Local Studies and Archives, ref. P/YW/1984/032

chapters: [030-introduction]

file: /assets/materials/fig-0-1-york-way.jpg
---

Optional additional notes about this material can go here.
EOF

# Create sample material: document
cat > _materials/doc-0-1-planning-brief.md << 'EOF'
---
id: doc-0-1
title: King's Cross Railway Lands Planning Brief
type: document
date: 1987

caption: "Camden Council planning brief establishing development parameters for the railway lands site."
alt: ""

copyright: "© London Borough of Camden"
archive: Camden Local Studies and Archives, ref. PL/KC/1987/001

chapters: [030-introduction]

file: /assets/materials/doc-0-1-planning-brief-1987.pdf
---

This planning brief was the first formal policy document addressing the future of the railway lands.
EOF

# Create CSS
cat > assets/css/materials.css << 'EOF'
/* Photo grid on chapter pages */
.photo-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 1.5rem;
  margin: 1.5rem 0;
}

.photo-grid figure {
  margin: 0;
  break-inside: avoid;
}

.photo-grid img {
  width: 100%;
  height: auto;
  display: block;
  border: 1px solid #ddd;
}

.photo-grid figcaption {
  font-size: 0.875rem;
  line-height: 1.4;
  margin-top: 0.5rem;
  color: #444;
}

.photo-grid figcaption small {
  color: #666;
  display: block;
  margin-top: 0.25rem;
}

/* Individual material page */
.material {
  max-width: 48rem;
  margin: 0 auto;
}

.material header h1 {
  margin-bottom: 0.5rem;
}

.material-meta {
  color: #666;
  font-size: 0.9rem;
  margin-bottom: 2rem;
}

.material-figure {
  margin: 2rem 0;
}

.material-figure img {
  max-width: 100%;
  height: auto;
  border: 1px solid #ddd;
}

.material-figure figcaption {
  font-size: 0.9rem;
  color: #444;
  margin-top: 0.75rem;
  font-style: italic;
}

.material-download {
  display: inline-block;
  padding: 0.5rem 1rem;
  background: #333;
  color: #fff;
  text-decoration: none;
  border-radius: 3px;
}

.material-download:hover {
  background: #555;
}

.material-details {
  margin: 2rem 0;
  padding: 1.5rem;
  background: #f9f9f9;
  border-left: 3px solid #333;
}

.material-details h2 {
  font-size: 1rem;
  margin-top: 0;
  margin-bottom: 1rem;
}

.material-details dl {
  margin: 0;
}

.material-details dt {
  font-weight: 600;
  font-size: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: #666;
  margin-top: 1rem;
}

.material-details dt:first-child {
  margin-top: 0;
}

.material-details dd {
  margin: 0.25rem 0 0 0;
}

.material-citations {
  margin: 2rem 0;
}

.material-citations h2 {
  font-size: 1rem;
  margin-bottom: 0.75rem;
}

.material-citations ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.material-citations li {
  display: inline;
}

.material-citations li:not(:last-child)::after {
  content: ", ";
}

.material-nav {
  margin-top: 3rem;
  padding-top: 1.5rem;
  border-top: 1px solid #ddd;
}
EOF

# Update _config.yml - append collections config
if ! grep -q "materials:" _config.yml 2>/dev/null; then
  cat >> _config.yml << 'EOF'

# Materials collection for substrate
collections:
  materials:
    output: true
    permalink: /materials/:name/

defaults:
  - scope:
      path: ""
      type: "materials"
    values:
      layout: "material"
EOF
  echo "Added materials collection to _config.yml"
else
  echo "_config.yml already has materials collection"
fi

echo ""
echo "Done! Files created:"
echo "  _includes/chapter-materials.html"
echo "  _layouts/material.html"
echo "  _pages/materials.md"
echo "  _materials/fig-0-1-york-way.md (sample)"
echo "  _materials/doc-0-1-planning-brief.md (sample)"
echo "  assets/css/materials.css"
echo "  _config.yml (updated)"
echo ""
echo "Next steps:"
echo "  1. Add 'slug: 030-introduction' to your chapter frontmatter"
echo "  2. Add '{% include chapter-materials.html %}' to chapter pages"
echo "  3. git add . && git commit -m 'Add materials substrate' && git push"
echo ""
