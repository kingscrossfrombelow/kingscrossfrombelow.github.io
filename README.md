## Working with Materials

### Overview of the New Links Field System
In our new materials linking system, each material is assigned a unique numbered slug that provides a structured way to reference them across chapters. This system enhances navigation and ensures that materials are consistently linked to their respective chapters.

### Material Frontmatter Example
Each material should include the following fields in its frontmatter:
```yaml
id: 1-risebero
title: Risebero
type: video
links:
  - url: https://example.com/risebero
    caption: Introduction to Risebero
copyright: © 2026 Example Author
```

### Complete Numbered Chapter Slug Format
The numbered chapter slug format follows this structure:
- **1-risebero**
- **2-edwards-regeneration**
- **3-edwards**
- ...
- **12c-williams**

This format allows for easy referencing and is essential in maintaining an organized materials library.

### Instructions on Linking to Multiple Chapters
To link a material to multiple chapters, simply include each chapter slug in the links array:
```yaml
links:
  - url: https://example.com/resource 
    caption: Resource Title 
    chapters: [1-risebero, 2-edwards-regeneration, 3-edwards]
```

### How to Display Materials Using the chapter-materials.html Include
To display materials in your HTML pages, use the following include:
```html
{% include chapter-materials.html slug='1-risebero' %}
```
This will render the materials associated with the specified chapter slug at the desired location in your template.