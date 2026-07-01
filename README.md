# NOMAD-ComRepo

Example `.com` files for the NOMAD platform.

**Official repository from [@DimensionDevices](https://github.com/DimensionDevices).**

---

## Table of Contents

- [What is a .com file?](#what-is-a-com-file)
- [Quick Start](#quick-start)
- [File Size Limit](#file-size-limit)
- [Metadata Directives](#metadata-directives)
- [Content Blocks](#content-blocks)
  - [Headings](#headings)
  - [Text Elements](#text-elements)
  - [Links & Buttons](#links--buttons)
  - [Media](#media)
  - [Alerts & Progress](#alerts--progress)
  - [Dividers](#dividers)
- [Complex Structures](#complex-structures)
  - [Lists](#lists)
  - [Tables](#tables)
  - [Grids](#grids)
  - [Cards](#cards)
- [Custom Code](#custom-code)
  - [CSS](#style-css)
  - [JavaScript](#script-javascript)
  - [Raw HTML](#customhtml)
- [Markdown Support](#markdown-support)
- [Full Example](#full-example)
- [Tips & Limitations](#tips--limitations)
- [NOMAD Extensions](#nomad-extensions)

---

## What is a .com file?

A `.com` file is a plain-text document that renders as a full web page inside the NOMAD interface. You write it using simple directives (like `PAGE:`, `TEXT:`, `IMAGE:`) and save it with a `.com` extension. No HTML, no build tools-just text.

---

## Quick Start

1. Create a new text file.
2. Add at least a `PAGE:` directive at the top.
3. Add content using the directives below.
4. Save with a `.com` extension (max 6 characters before the dot).
5. Upload or serve it through your NOMAD device.

> 💡 **Tip:** Use the NOMAD Studio's visual editor if you prefer a GUI; it generates these directives for you.

---

## File Size Limit

**All `.com` files must stay under 20 KB.**  
This includes embedded images (base64), custom CSS, and JavaScript. Compress images before embedding, and minify any custom code.

---

## Metadata Directives

Place these at the very top of your file. They control page-level settings and are **not** rendered in the body.

| Directive | Format | Example | Purpose |
|-----------|--------|---------|---------|
| `PAGE:` | `PAGE: Title` | `PAGE: My Dashboard` | Browser tab title (required) |
| `COLOR:` | `COLOR: #hex` | `COLOR: #ff6b6b` | Primary theme color (links, buttons, accents) |
| `AUTHOR:` | `AUTHOR: Name` | `AUTHOR: Jane Doe` | Author metadata |
| `DATE:` | `DATE: YYYY-MM-DD` | `DATE: 2024-01-15` | Publication date |

**Example:**
```
PAGE: NOMAD Tips
COLOR: #2ecc71
AUTHOR: BigJohn
DATE: 2024-12-01
```

---

## Content Blocks

Each block starts with a directive on its own line.

### Headings

| Directive | Renders As | Example |
|-----------|------------|---------|
| `BIGHEADER:` | Large H1 | `BIGHEADER: Welcome` |
| `HEADER:` | Medium H2 | `HEADER: Features` |
| `SUBHEADER:` | Small H3 | `SUBHEADER: Getting Started` |
| `SUBTITLE:` | Subtitle text | `SUBTITLE: A beginner's guide` |

### Text Elements

| Directive | Renders As | Example |
|-----------|------------|---------|
| `TEXT:` | Paragraph | `TEXT: This is a sentence.` |
| `PARAGRAPH:` | Paragraph (alias) | `PARAGRAPH: Another paragraph` |
| `QUOTE:` | Blockquote | `QUOTE: To be or not to be` |
| `CODE:` | Code block | `CODE: const x = 42;` |

### Links & Buttons

| Directive | Format | Example |
|-----------|--------|---------|
| `LINK:` | `LINK: URL \| Text` | `LINK: https://example.com \| Click here` |
| `BUTTON:` | `BUTTON: Label \| URL` | `BUTTON: Download \| /files/myfile.txt` |

> `BUTTON:` uses the label first, then the URL-note the order.

### Media

| Directive | Format | Example |
|-----------|--------|---------|
| `IMAGE:` | `IMAGE: Alt \| dataURL` or `IMAGE: URL \| Alt` | `IMAGE: My photo \| data:image/png;base64,...` |

**Important:** Images **must** be embedded as Data URLs (base64). Due to the 20 KB limit, use small, compressed images.

### Alerts & Progress

| Directive | Format | Example |
|-----------|--------|---------|
| `ALERT:` | `ALERT: type \| message` | `ALERT: warning \| Low battery!` |
| `PROGRESS:` | `PROGRESS: value` | `PROGRESS: 75` |

**Alert types:** `info`, `warning`, `error`, `success`

### Dividers

| Directive | Effect |
|-----------|--------|
| `DIVIDER` | Horizontal rule (`<hr>`) |

---

## Complex Structures

These use start/end blocks with content in between.

### Lists

```
LIST-START
ITEM: First item
ITEM: Second item
ITEM: Third item
LIST-END
```

Renders as a bulleted list.

### Tables

```
TABLE-START
HEADER: Name | Age | City
ROW: Alice | 28 | London
ROW: Bob   | 34 | Paris
TABLE-END
```

Separate columns with the pipe character `|`.

### Grids

```
GRID-START
COLUMN: First column content
COLUMN: Second column content
COLUMN: Third column content
GRID-END
```

Creates equal-width columns that wrap on mobile. Useful for dashboards or feature comparisons.

### Cards

```
CARD-START
## Inside a card

This text is inside a bordered, rounded box.
CARD-END
```

Cards support markdown formatting inside them. Great for highlighting key information.

---

## Custom Code

Use these blocks when the built-in directives aren't enough.

### STYLE (CSS)

```
STYLE-START
.block:hover { background: #f0f0f0; }
.custom-class { padding: 1rem; }
STYLE-END
```

Add custom CSS. **Minify** your CSS to save space.

### SCRIPT (JavaScript)

```
SCRIPT-START
console.log("Hello from NOMAD!");
document.querySelector('h1').style.color = 'red';
SCRIPT-END
```

Add JavaScript. **Minify** to stay under 20 KB.

### CUSTOMHTML

```
CUSTOMHTML-START
<div class="my-widget">
  <button onclick="alert('Clicked!')">Click me</button>
</div>
CUSTOMHTML-END
```

Insert raw HTML for complex widgets or layouts. **Minify** your HTML.

> **Note:** All custom HTML/CSS/JS runs in a sandboxed environment.

---

## Markdown Support

You can use basic Markdown inside `TEXT:`, `QUOTE:`, and other text blocks:

| Syntax | Result |
|--------|--------|
| `**bold**` | **bold** |
| `*italic*` | *italic* |
| `` `code` `` | `code` |
| `[text](url)` | [text](url) |

---

## Full Example

Here's a complete `.com` file screenshot and template code that combines many of the features above, note that this uses the default styling, which may be overwritten by using the STYLE-START and STYLE-END directives:

![Hillside Veggie Trade screenshot](example.png)

```
PAGE: Hillside Veggie Trade
COLOR: #2e7d32
AUTHOR: GreenValley Farm
DATE: 2025-06-01

BIGHEADER: 🌱 Hillside Veggie Trade

SUBTITLE: Available this week!

DIVIDER

GRID-START
COLUMN: 🥬 **This Week's Harvest**  
Kale • Swiss Chard • Lettuce
COLUMN: 🍅 **Coming Soon**  
Tomatoes (2 weeks) • Peppers (3 weeks)
COLUMN: 🔄 **Looking For**  
Honey • Eggs • Firewood
GRID-END

ALERT: success | New batch of pickled beets ready - trade 2:1 for eggs

DIVIDER

HEADER: Available Produce

TABLE-START
HEADER: Item | Quantity | Trade For
ROW: Kale | 5 bunches | 1 doz eggs per bunch
ROW: Swiss Chard | 3 bunches | 1 jar honey per bunch
ROW: Lettuce | 8 heads | 2 firewood logs per head
ROW: Herbs (mixed) | 6 bundles | 1 candle per bundle
TABLE-END

TEXT: *All produce grown without pesticides. Harvested fresh each morning.*

CARD-START
**Trade Info**  
📍 Pickup at the farm stand (7am-10am, Sat-Sun)  
📡 Send a NOMAD message to confirm trades  
🔄 Open to barter, just ask!
CARD-END

QUOTE: "Good food, good folks, good trade."
```

---

## Tips & Limitations

- **20 KB hard limit**: every byte counts. Minify CSS/JS/HTML and compress images before embedding.
- **Max 6 characters** for the filename (before the `.com` extension).
- **Always preview** before saving to your device.
- **Use the Studio** for visual editing; it writes these directives for you.
- **Data URLs for images only**: no external image hosting.
- **Sandboxed environment**: your custom code runs safely.

---

## NOMAD Extensions

### What Are `.ext` Files?

`.ext` files are **UI extensions** for your NOMAD device. They allow you to add custom sections, widgets, and functionality to the web interface without modifying the device's firmware.

Think of them as "plugins" that can:
- Add new sections to the dashboard
- Inject custom HTML, CSS, and JavaScript
- Monitor device activity
- Add custom buttons and interactions
- Integrate with the NOMAD API

**Key Properties:**
- Each `.ext` file is a JSON object
- They're uploaded like any other file (`.txt`, `.md`, `.com`)
- Multiple `.ext` files can be active simultaneously
- They're loaded when you refresh the web page

---

### Extension File Format

```json
{
  "html": "<your HTML here>",
  "css": "<your CSS here>",
  "js": "<your JavaScript here>",
  "target": "footer"
}
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `html` | string | The HTML to inject into the page (uses `.ext` format) |
| `target` | string | Where to inject the HTML (see targets below) |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `css` | string | CSS styles to add to the page |
| `js` | string | JavaScript to execute (runs in browser context) |

---

### Injection Targets

These are the available insertion points in the NOMAD UI:

| Target | Location | Use Case |
|--------|----------|----------|
| `header` | Top of page (below status bar) | Add global widgets, top-level buttons |
| `status-bar` | Inside the status bar | Add custom metrics, indicators |
| `directory` | Inside the files/directory section | Add file management tools, extra controls |
| `nodes` | Inside the nodes section | Add node visualization, custom node data |
| `footer` | Bottom of page (before closing `</body>`) | Dashboard sections, activity logs, custom panels |
| `bookmarks` | Inside bookmarks section | Enhanced bookmark management |

**Example:** To add a new section to the dashboard (like the Activity Log), use `"target": "footer"`.

---

### Step-by-Step: Your First Extension

### 1. Create the JSON File

Create a file called `logger.ext` with this content:

```json
{
  "html": "<details class='section' id='myCustomSection'>\n  <summary>\n    <h2>\n      <svg style='position:relative;top:6px' width='24px' height='24px' viewBox='0 0 24 24' fill='none' stroke='var(--text)' stroke-width='2'>\n        <circle cx='12' cy='12' r='10'></circle>\n        <line x1='12' y1='8' x2='12' y2='12'></line>\n        <line x1='12' y1='16' x2='12.01' y2='16'></line>\n      </svg>\n      &nbsp;My Custom Widget\n    </h2>\n  </summary>\n  <div style='padding:10px;text-align:center;color:var(--text-dim);'>\n    Hello from my extension!\n  </div>\n</details>",
  "target": "footer"
}
```

### 2. Upload to Your NOMAD

- Open the NOMAD web interface
- Click the `+` floating action button
- Select **Upload File** (📤)
- Choose your `logger.ext` file
- Wait for confirmation

### 3. Reload the Page

Restart your NOMAD device. You should see a new section called **My Custom Widget** at the bottom of the page.

---

### Available NOMAD API Endpoints

Your extensions can interact with the NOMAD device via these API endpoints:

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/status` | GET | Device status, node count, memory, temperature |
| `/api/nodes` | GET | List of nearby nodes |
| `/api/files` | GET | List of local files |
| `/api/view-file` | GET | Get file content |
| `/api/beacon-config` | GET/POST | Manage beacon visibility |
| `/api/chat/messages` | GET | Get chat history |
| `/api/chat/send` | POST | Send a chat message |

**Example API Call in JS:**
```javascript
fetch('/api/status')
  .then(r => r.json())
  .then(data => {
    console.log('Nodes found:', data.nodeCount);
  });
```

---

### CSS Styling Guide

NOMAD uses CSS variables for theming. Use these in your extensions for consistency:

```css
/* Available CSS variables */
var(--bg)          /* Background color */
var(--text)        /* Text color */
var(--text-dim)    /* Dimmed text color */
var(--accent)      /* Primary accent color (green) */
var(--accent-light)/* Light accent (for hover effects) */
var(--border)      /* Border color */
var(--surface)     /* Card/surface background */
```

**Example:**
```css
.my-widget {
  background: var(--surface);
  border: 1px solid var(--border);
  color: var(--text);
}
```

---

### Best Practices

### 1. **Keep It Light**
- `.ext` files are loaded all at once
- Keep JavaScript lean and efficient
- Use `var` or `function` for global scope (avoid `const`/`let` in top-level)

### 2. **Use Unique IDs**
- Prefix your IDs to avoid conflicts: `#myextension_xyz`
- Example: `id='myExt_btnSave'` instead of `id='saveBtn'`

### 3. **Respect the UI Theme**
- Use CSS variables for colors
- Follow existing spacing and typography
- Test with both light and dark modes

### 4. **Handle Asynchronous Operations**
- The NOMAD is a resource-constrained device
- Always use `catch()` for API calls
- Avoid blocking the main thread

### 5. **Error Handling**
```javascript
fetch('/api/status')
  .then(r => {
    if (!r.ok) throw new Error('Status: ' + r.status);
    return r.json();
  })
  .catch(err => {
    console.error('API error:', err);
    // Show user-friendly message
  });
```

### 6. **Test Thoroughly**
- Test with multiple extensions loaded simultaneously
- Check on mobile and desktop views
- Verify dark mode compatibility

---

### Common Use Cases & Examples

### 1. Node Status Widget
```json
{
  "html": "<details class='section'>\n  <summary>\n    <h2>🌐 Network Overview</h2>\n  </summary>\n  <div id='nodeOverview' style='padding:10px;'>Loading...</div>\n</details>",
  "css": ".stat-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(120px,1fr)); gap:12px; }",
  "js": "function updateNodeStats(){fetch('/api/nodes').then(r=>r.json()).then(data=>{var html='<div class=stat-grid>';data.nodes.forEach(n=>{html+='<div style=\"background:var(--surface);padding:12px;border-radius:8px;text-align:center;\"><strong>'+n.id+'</strong><br>'+n.signal+'</div>'});html+='</div>';document.getElementById('nodeOverview').innerHTML=html})}setInterval(updateNodeStats,5000);updateNodeStats();",
  "target": "footer"
}
```

### 2. Storage Monitor
```json
{
  "html": "<div style='padding:12px 20px;background:var(--surface);border-radius:12px;margin:8px 0;'>\n  <div style='display:flex;justify-content:space-between;'>\n    <span>📦 Storage</span>\n    <span id='storageStatus'>Loading...</span>\n  </div>\n</div>",
  "css": "",
  "js": "setInterval(function(){fetch('/api/status').then(r=>r.json()).then(data=>{if(data.storage){var used=data.storage.usedKB;var total=data.storage.totalKB;document.getElementById('storageStatus').textContent=used+'/'+total+' KB'}})},10000);",
  "target": "header"
}
```

### 3. Custom Button (Quick Actions)
```json
{
  "html": "<button class='btn btn-primary' onclick='quickRefresh()' style='margin:4px 8px;'>🔄 Quick Refresh</button>",
  "css": "",
  "js": "function quickRefresh(){document.querySelectorAll('.refresh-btn').forEach(b=>b.click());addLogEntry('🔄 Quick refresh triggered','🔄')}",
  "target": "directory"
}
```

### Technical Reference

### Injection Mechanism
The `pluginManager` in the backend:
1. Reads all `.ext` files
2. Parses the JSON
3. Injects HTML/CSS/JS into the appropriate locations
4. Executes JavaScript when the page loads

### Load Order
Extensions are loaded in alphabetical order by filename. If you need dependencies, name your files accordingly (e.g., `01_core.ext`, `02_widget.ext`).

### Security Considerations
- `.ext` files run in the browser context
- They have access to the NOMAD API endpoints
- They cannot access LoRa directly (only via API)
- They cannot modify the device firmware
- They are **not** sandboxed - use trusted sources only

---

### Quick Reference Card

```json
{
  "html": "<!-- Your HTML here -->",
  "css": "/* Your CSS here */",
  "js": "// Your JavaScript here",
  "target": "footer"  // header, status-bar, directory, nodes, footer, bookmarks
}
```

**Target locations:**
- `header` - Top of page
- `status-bar` - Status bar widgets
- `directory` - File management area
- `nodes` - Node display area
- `footer` - Bottom of page (recommended for new sections)
- `bookmarks` - Bookmark section

---

**Happy building with NOMAD!**  