# NOMAD Extensions

## Table of Contents
- [What Are `.ext` and `.thm` Files?](#what-are-ext-files)
- [Extension File Format](#extension-file-format)
- [Required Fields](#required-fields)
- [Optional Fields](#optional-fields)
- [Injection Targets](#injection-targets)
- [Step-by-Step: Your First Extension](#step-by-step-your-first-extension)
- [Available NOMAD API Endpoints](#available-nomad-api-endpoints)
- [CSS Styling Guide](#css-styling-guide)
- [Best Practices](#best-practices)
- [Common Use Cases & Examples](#common-use-cases--examples)
- [Technical Reference](#technical-reference)
- [Quick Reference Card](#quick-reference-card)

---

### What Are `.ext` Files?

`.ext` and `.thm` files are **UI extensions** for your NOMAD device. They allow you to add custom sections, widgets, and functionality to the web interface without modifying the device's firmware.

Think of them as "plugins" that can:
- Add new sections to the dashboard
- Inject custom HTML, CSS, and JavaScript
- Monitor device activity
- Add custom buttons and interactions
- Integrate with the NOMAD API

**Key Properties:**
- Each file is a JSON object
- They're uploaded like any other file (`.txt`, `.md`, `.com`)
- Multiple `.ext` files can be active simultaneously
- A single `.thm` file can be active at any given time
- They're loaded when you refresh the web page

The key difference between `.ext` and `.thm` files are that you may have multiple `.ext` files on your NOMAD device at any point, but you may only have ONE `.thm` file at a time. `.thm` files are for theme layouts. This ensures that the user cannot load more than one layout changing extension at once. 

---

### Extension File Format

```json
{
  "description": "A brief extension description",
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
| `description` | string | A brief description of what the extension does |
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
  "html": "<details class='section' id='myCustomSection'><summary><h2><svg style='position:relative;top:6px' width='24px' height='24px' viewBox='0 0 24 24' fill='none' stroke='var(--text)' stroke-width='2'><circle cx='12' cy='12' r='10'></circle><line x1='12' y1='8' x2='12' y2='12'></line><line x1='12' y1='16' x2='12.01' y2='16'></line></svg>&nbsp;My Custom Widget</h2></summary><div style='padding:10px;text-align:center;color:var(--text-dim);'>Hello from my extension!</div></details>",
  "target": "footer"
}
```

Note that this is created inside a `<details class='section'><summary>`, this gives the section the same collapsible look as the rest of the main screen.

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
| `/api/chat/messages` | GET | Get chat history |

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
  "html": "<details class='section'><summary> <h2>🌐 Network Overview</h2></summary><div id='nodeOverview' style='padding:10px;'>Loading...</div></details>",
  "css": ".stat-grid { display:grid; grid-template-columns:repeat(auto-fit,minmax(120px,1fr)); gap:12px; }",
  "js": "function updateNodeStats(){fetch('/api/nodes').then(r=>r.json()).then(data=>{var html='<div class=stat-grid>';data.nodes.forEach(n=>{html+='<div style=\"background:var(--surface);padding:12px;border-radius:8px;text-align:center;\"><strong>'+n.id+'</strong><br>'+n.signal+'</div>'});html+='</div>';document.getElementById('nodeOverview').innerHTML=html})}setInterval(updateNodeStats,5000);updateNodeStats();",
  "target": "footer"
}
```

### 2. Storage Monitor
```json
{
  "html": "<div style='padding:12px 20px;background:var(--surface);border-radius:12px;margin:8px 0;'><div style='display:flex;justify-content:space-between;'> <span>📦 Storage</span><span id='storageStatus'>Loading...</span></div></div>",
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

## Data Storage

Every `.com` page can save and load its own small JSON "database" on the device-no external server needed. This is handy for things like counters, saved settings, high scores, or simple guestbooks that persist between visits.

Storage lives separately from your page file, so it isn't counted against your page's 20 KB limit-but it has its own cap:

> 💡 **10 KB hard limit** per site's stored JSON document.

### How it works

Your page's own JavaScript (inside a `SCRIPT-START`/`SCRIPT-END` or `CUSTOMHTML-START`/`CUSTOMHTML-END` block) talks to a small set of endpoints using `fetch()`. Each site gets its own isolated document, automatically matched to the page you're viewing-**you don't need to tell it your own filename** if you're viewing the page through its own address. If you're testing through the Studio or an IP address directly, pass `filename` explicitly instead (see [Testing Locally](#testing-locally) below).

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/api/db/get` | GET | Read the whole document, or a single key |
| `/api/db/set` | POST | Save/update one or more keys |
| `/api/db/remove` | POST | Delete one or more keys |
| `/api/db/clear` | POST | Wipe the entire document |

All four respond with the same JSON envelope:

```
{ "success": true, "filename": "yoursite.com", "data": <whatever you asked for> }
```

or, on failure:

```
{ "success": false, "error": "..." }
```

### Reading data

```
SCRIPT-START
async function loadScore() {
  const resp = await fetch('/api/db/get?key=score');
  const json = await resp.json();
  const score = (json.success && json.data !== null) ? json.data : 0;
  document.getElementById('score').textContent = score;
}
loadScore();
SCRIPT-END
```

Leave off `?key=` to get the whole document back instead of a single value.

### Saving data

```
SCRIPT-START
async function saveScore(value) {
  await fetch('/api/db/set', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ data: { score: value } })
  });
}
SCRIPT-END
```

`set` merges whatever keys you send into the existing document-it won't touch other keys you've already saved.

### Removing data

```
SCRIPT-START
async function resetScore() {
  await fetch('/api/db/remove', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ key: 'score' })
  });
}
SCRIPT-END
```

Pass `"keys": ["a", "b"]` instead of `"key"` to remove several fields at once.

### Testing locally

If you're previewing a file directly (rather than visiting your site's own address), the device can't tell which site is asking, so add `filename` to every call:

```
fetch('/api/db/get?filename=yoursite.com&key=score')

fetch('/api/db/set', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ filename: 'yoursite.com', data: { score: 10 } })
});
```

Match `filename` to whatever you actually named your `.com` file, or you'll end up reading/writing a different site's data.

### Limits & notes

- **10 KB per site**, enforced on save-if a `set` would push the document over the limit, it's rejected and your existing data is left untouched.
- Storage is a flat set of keys and values-there's no nesting rules enforced, but keep it simple (numbers, strings, small objects/arrays) for reliability.
- Data persists across page reloads and device reboots, but isn't backed up anywhere else-treat it as convenient, not durable.
- Each site's storage is isolated; you can't read or write another site's data unless you explicitly pass its `filename`.

**Happy building with NOMAD!**