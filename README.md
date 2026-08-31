# King's Cross From Below - Digital Garden & Book Publication Platform

This repository is a **Jekyll-based digital garden** designed to publish long-form books with multimedia materials, chapter navigation, and interconnected content. It serves as both a **living document** for collaborative scholarship and a **finished publication** platform.

## Quick Start: Forking This Repository

This repository is designed to be forked and reused for your own book projects. Here's how to get started:

### 1. Fork the Repository
Click the **Fork** button on GitHub to create your own copy. This gives you a complete, independent version of the site with all the Jekyll infrastructure, styling, and content structure.

### 2. Configure Your Site
Edit `_config.yml` to customize:
- **Site title & description** (displayed on all pages)
- **Author name & email**
- **Base URL** (e.g., `https://yourusername.github.io/your-project-name`)
- **Navigation menus** (sidebar navigation, breadcrumbs, footer links)
- **Copyright information** (year, URL, author)

### 3. Rename & Deploy
- Rename the repository to `yourusername.github.io` for a user site, or keep a custom name for a project site
- Push your changes; GitHub Pages automatically builds and deploys your site
- Your site will be live at the configured URL within minutes

## Understanding the Digital Garden Structure

### What Makes This a "Digital Garden"?

Unlike a traditional linear book, this platform supports:
- **Chapter-based organization** with automatic table of contents and breadcrumb navigation
- **Interconnected materials** (PDFs, videos, images) linked to multiple chapters
- **Flexible structuring** – chapters can be reordered, materials can apply to many sections
- **Living revision** – update content at any time; the sitemap automatically reflects changes
- **Multimedia integration** – embed videos, images, and documents alongside text

Think of this as a **curated knowledge graph** that stays organized and navigable even as your content grows.

---

## Content Architecture

### Directory Structure

```
_chapters/          # Your book chapters (one file per chapter)
_materials/         # Supporting resources: PDFs, images, videos
_layouts/           # Jekyll templates (chapter, material, default pages)
_includes/          # Reusable HTML components (navigation, chapter lists)
_config.yml         # Site configuration & metadata
sitemap.txt         # Auto-generated sitemap of all pages
```

### Chapters

Each chapter is a Markdown file in `_chapters/` with a numbered prefix:
- `001-introduction.md`
- `010-chapter-one.md`
- `020-chapter-two.md`

The numerical prefix controls the chapter order in navigation. The chapter filename also becomes the chapter slug (e.g., `chapter-one`).

**Chapter Frontmatter Example:**
```yaml
---
layout: chapter
title: The Rise of New Economy Politics
---

# Your chapter content in Markdown
```

### Materials (Multimedia Resources)

Materials are resources linked to one or more chapters. Each material file lives in `_materials/` with structured metadata.

**Material Frontmatter Example:**
```yaml
---
layout: material
id: 1-risebero
title: Risebero Documentary
type: video
chapters:
  - 001-introduction
  - 010-chapter-one
file: https://example.com/video.mp4
alt: A documentary about urban change
caption: "This video explores the gentrification of inner cities."
copyright: © 2026 Example Author
archive: YouTube Channel Name
---

Optional notes or description in Markdown.
```

**Supported Material Types:**
- `video` – Embedded videos (renders as `<video>` tag)
- `photo` – Images (renders as `<figure>` with caption)
- `document` – PDFs and other downloadable files
- `link` – External resources

---

## Working with Materials

### Overview of the Numbered Slug System

Each material is assigned a unique numbered slug that provides a structured way to reference it across chapters. This system ensures consistent linking and makes materials discoverable.

**Slug Format:**
- `1-risebero`
- `2-edwards-regeneration`
- `3-edwards`
- ...
- `12c-williams`

The numbering allows for flexibility (e.g., `12c` for subcategories) while keeping materials in a logical order.

### Linking Materials to Multiple Chapters

To link a material to several chapters, include their slugs in the frontmatter:

```yaml
chapters:
  - 001-introduction
  - 010-chapter-one
  - 020-chapter-two
```

The `chapter-materials.html` include (see below) will automatically render links to the material on each of these chapter pages.

### Displaying Materials on Chapter Pages

To show all materials linked to a chapter, use this include in your chapter Markdown:

```html
{% include chapter-materials.html slug='001-introduction' %}
```

This renders:
- A list of all materials tagged with that chapter slug
- Material title, type icon, and caption
- Links to view the full material page

**Example in a Chapter:**
```markdown
## Recommended Materials

{% include chapter-materials.html slug='010-chapter-one' %}

## Chapter Text

Lorem ipsum dolor sit amet...
```

---

## Sitemap: The Backbone of Your Digital Garden

### What is the Sitemap?

The `sitemap.txt` file (generated automatically by Jekyll) is a complete, searchable list of all pages in your site:
- All chapters (in order)
- All materials
- All static pages (introduction, contents, contributors, etc.)

**Why it matters:**
- **Search engines** use it to discover and index your content
- **Navigation** – readers can see the complete structure at a glance
- **Validation** – ensure all your content is published and linked correctly

### Viewing Your Sitemap

After building your site, visit: `https://yoursite.com/sitemap.txt`

You'll see a complete list:
```
https://yoursite.com/
https://yoursite.com/introduction
https://yoursite.com/chapter-one
https://yoursite.com/chapter-two
https://yoursite.com/materials/risebero/
https://yoursite.com/materials/edwards-regeneration/
https://yoursite.com/contents
...
```

### How the Sitemap is Generated

The `_layouts/sitemap.html` file automatically:
1. Iterates through all chapters (respecting `show_drafts_in_dev` setting)
2. Filters out any draft chapters (marked with `.draft` in the filename)
3. Includes all published pages
4. Generates the complete list

**To hide a draft chapter:**
Rename it from `010-chapter-one.md` to `010.draft-chapter-one.md`. It won't appear in navigation or the sitemap.

---

## Setting Up Your Fork: Step-by-Step

### Step 1: Configure `_config.yml`

```yaml
# Basic site info
title: Your Book Title
longtitle: Your Book Title - Subtitle
author: Your Name
email: your@email.com
description: A brief description of your book

# Deployment
baseurl_canonical: https://yourusername.github.io/your-repo-name

# Copyright
copyright:
  start_year: 2025
  url: /copyright.html

# Navigation (customize for your chapters)
sidebar_nav_top:
  - label: Home
    url: index.html
  - label: Introduction
    url: introduction.html
  - label: Chapter One
    url: chapter-one.html
  - label: Contributors
    url: contributors.html
```

### Step 2: Create Your Chapters

Create files in `_chapters/` with this structure:
- `001-introduction.md`
- `010-part-one.md`
- `020-part-two.md`

Each chapter should have:
```yaml
---
layout: chapter
title: Chapter Title
---

# Chapter Heading

Your content in Markdown, including...

{% include chapter-materials.html slug='010-part-one' %}

More content...
```

### Step 3: Add Materials

Create files in `_materials/` for PDFs, videos, images, etc.:
```yaml
---
layout: material
id: 1-my-resource
title: Resource Title
type: video
chapters:
  - 001-introduction
file: https://example.com/resource.mp4
caption: "A description of this resource."
copyright: © 2026 Your Name
---
```

### Step 4: Deploy

Push to GitHub. GitHub Pages automatically builds and deploys your site. After a few minutes, it's live!

---

## Advanced: Customizing Navigation & Structure

### Add Custom Pages

Static pages (like "Contributors" or "About") go in the root directory as `.md` or `.html` files:
- `introduction.md`
- `contributors.md`
- `backmatter.html`

Update `_config.yml` to include them in sidebar navigation:
```yaml
sidebar_nav_top:
  - label: Home
    url: index.html
  - label: Introduction
    url: introduction.html
  - label: Contributors
    url: contributors.html
```

### Table of Contents (TOC)

Enable automatic TOC generation in chapters:
```yaml
in_chapter_toc:
  enabled: true
  h_min: 2
  h_max: 3
```

Or disable for a specific chapter in its frontmatter:
```yaml
---
layout: chapter
title: My Chapter
disable_toc: true
---
```

### GitHub Edit Links

Enable "Edit on GitHub" links on every page:
```yaml
github_edit:
  enabled: true
  base_url: https://github.com/yourusername/your-repo/edit/master/
```

Readers can click to suggest edits directly in GitHub!

---

## Material File Types & Formatting

### Video Materials
```yaml
type: video
file: https://example.com/video.mp4
caption: "Video description"
```

Renders as an embedded `<video>` element.

### Photo Materials
```yaml
type: photo
file: /assets/images/photo.jpg
alt: "Alt text for accessibility"
caption: "Photo description"
```

Renders as a `<figure>` with caption.

### Document Materials
```yaml
type: document
file: /assets/documents/whitepaper.pdf
caption: "Click to download the full whitepaper"
```

Renders as a download link.

### Link Materials
```yaml
type: link
file: https://external-site.com/resource
caption: "External resource"
```

Renders as a text link.

---

## Best Practices for Your Digital Garden

1. **Use consistent chapter naming** – Prefix with numbers (`001-`, `010-`, `020-`) to control ordering
2. **Link materials broadly** – Use the `chapters` array to cross-reference resources across sections
3. **Write descriptive captions** – Materials without context are less useful
4. **Keep the sitemap clean** – Draft chapters when content is incomplete
5. **Test locally** – Run `jekyll serve` locally before pushing to GitHub
6. **Version your content** – Use Git commits to track major revisions

---

## Local Development

### Install Jekyll

```bash
gem install bundler jekyll
```

### Build & Serve Locally

```bash
cd your-repo
bundle install
jekyll serve
```

Visit `http://localhost:4000` to preview your site.

### Edit Content

- Add chapters to `_chapters/`
- Add materials to `_materials/`
- Update `_config.yml`
- Refresh your browser; Jekyll rebuilds automatically

---

## Customization & Styling

This theme is built on `jekyll-chapterbook` (configured in `_config.yml`). You can customize:

- **Colors & fonts** – Edit `_sass/` files or override in `extra_css`
- **Layouts** – Modify `_layouts/*.html`
- **Navigation** – Update `_config.yml` and `_includes/`

See the [jekyll-chapterbook documentation](https://github.com/jasongrimes/jekyll-chapterbook) for advanced customization.

---

## Publishing & Sharing

### As a Website
Your book is automatically published as a static website, shareable via URL.

### As a Living Document
Readers can:
- Suggest edits via GitHub (if `github_edit.enabled: true`)
- Fork the entire repository to create a derivative work
- Open issues to discuss content

### Beyond GitHub Pages
You can:
- Export to PDF (using browser print functionality or tools like Pandoc)
- Mirror to other platforms
- Generate an ebook version (EPUB, Mobi)

---

## Troubleshooting

**Site not building?**
- Check `_config.yml` syntax (YAML is whitespace-sensitive)
- Review build logs on GitHub (Settings → Pages → Build logs)
- Run `jekyll build --verbose` locally to see errors

**Materials not appearing?**
- Ensure the `chapters` array matches your chapter slugs exactly
- Check that the material file is in `_materials/`
- Verify frontmatter YAML syntax

**Navigation links broken?**
- Ensure `url:` values in `_config.yml` start with `/`
- Check that page files exist (e.g., `introduction.html`)

---

## License & Attribution

This theme is built on [jekyll-chapterbook](https://github.com/jasongrimes/jekyll-chapterbook), a flexible Jekyll theme for publishing books. See `LICENSE` for details.

---

## Contributing & Support

Found a bug? Have an improvement? Open an issue or submit a pull request!

For questions about this specific implementation, contact the maintainers.

For Jekyll or theme questions, see the [jekyll-chapterbook GitHub repo](https://github.com/jasongrimes/jekyll-chapterbook).
