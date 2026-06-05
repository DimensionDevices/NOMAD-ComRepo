# NOMAD-ComRepo

A repository of example NOMAD .com files.

Offical Repo From @DimensionDevices.

---

# NOMAD .com File Format Guide

## Overview

The NOMAD .com file format lets you create full-featured web pages using simple plain-text directives. Files are saved with the `.com` extension and served through the NOMAD web interface. All `.com` files **MUST** stay under **20KB** (about 2,000 packets over LoRa).

---

## Quick Start

Create a new `.com` file via the **Studio** button on the NOMAD dashboard, or manually write a text file with the directives below.

---

## Metadata Directives

These go at the top of your file and control page-level settings.

| Directive | Format | Example | Purpose |
|-----------|--------|---------|---------|
| `PAGE:` | `PAGE: Title` | `PAGE: My Cool Site` | Sets the browser tab title |
| `COLOR:` | `COLOR: #hex` | `COLOR: #ff6b6b` | Primary theme color (links, buttons, accents) |
| `AUTHOR:` | `AUTHOR: Name` | `AUTHOR: Jane Doe` | Author metadata |
| `DATE:` | `DATE: YYYY-MM-DD` | `DATE: 2024-01-15` | Publication date |
| `DESCRIPTION:` | `DESCRIPTION: Text` | `DESCRIPTION: A guide to NOMAD` | Short description (shown in file listings) |

**Example:**
```
PAGE: NOMAD Tips
COLOR: #2ecc71
AUTHOR: John
DATE: 2024-12-01
DESCRIPTION: Essential tips for NOMAD users
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

### Media

| Directive | Format | Example |
|-----------|--------|---------|
| `IMAGE:` | `IMAGE: Alt \| dataURL` or `IMAGE: URL \| Alt` | `IMAGE: My photo \| data:image/png;base64,...` |

> **Note:** Images must be embedded as Data URLs (base64). Keep them small (<5KB recommended) due to the 20KB file limit.

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

### List

```
LIST-START
ITEM: First item
ITEM: Second item
ITEM: Third item
LIST-END
```

Renders as an unordered bullet list.

### Table

```
TABLE-START
HEADER: Name | Age | City
ROW: Alice | 28 | London
ROW: Bob | 34 | Paris
TABLE-END
```

Separate columns with the pipe character `|`.

### Grid (responsive columns)

```
GRID-START
COLUMN: First column content
COLUMN: Second column content
COLUMN: Third column content
GRID-END
```

Creates equal-width columns that wrap on mobile.

### Card (styled container)

```
CARD-START
## Inside a card

This text is inside a bordered, rounded box.
CARD-END
```

Supports markdown formatting inside the card.

---

## Custom Code

### STYLE (CSS)

```
STYLE-START
.block:hover {
    background: #f0f0f0;
}
.custom-class {
    padding: 1rem;
}
STYLE-END
```

Adds custom CSS to your page.

### SCRIPT (JavaScript)

```
SCRIPT-START
console.log("Hello from NOMAD!");
document.querySelector('h1').style.color = 'red';
SCRIPT-END
```

Adds JavaScript. Runs in an isolated iframe context.

### CUSTOMHTML

```
CUSTOMHTML-START
<div class="my-widget">
    <button onclick="alert('Clicked!')">Click me</button>
</div>
CUSTOMHTML-END
```

Inserts raw HTML. Use this for complex layouts or interactive widgets not covered by other directives.

---

## Markdown Inside Text

You can use basic markdown in `TEXT:`, `QUOTE:`, and other text blocks:

| Syntax | Result |
|--------|--------|
| `**bold**` | **bold** |
| `*italic*` | *italic* |
| `` `code` `` | `code` |
| `[text](url)` | [text](url) |

---

## Example: Complete .com File

```
PAGE: NOMAD Weather Station
COLOR: #3498db
AUTHOR: WeatherBot
DATE: 2024-12-01
DESCRIPTION: Live weather data from my NOMAD node

BIGHEADER: Weather Station

GRID-START
COLUMN: 📡 **Temperature**  
22.4°C
COLUMN: 💧 **Humidity**  
58%
COLUMN: 🌬️ **Wind**  
12 km/h
GRID-END

ALERT: info | Last updated 2 minutes ago

DIVIDER

HEADER: Weekly Forecast

TABLE-START
HEADER: Day | High | Low | Condition
ROW: Mon | 24° | 16° | ☀️ Sunny
ROW: Tue | 22° | 15° | 🌧️ Rain
ROW: Wed | 23° | 14° | ⛅ Partly cloudy
TABLE-END

TEXT: Data updates every hour via LoRa. *Check back soon!*

CARD-START
**About this station**  
Located in the backyard garden. Reports every 60 minutes.
CARD-END
```

---

## Tips & Limitations

- **File Size Limit: 20KB** — Keep images compressed (use the Studio's image compressor)
- **Max 6-character filenames** (plus `.com` extension)
- **Max 150 characters** per chat message (if using messenger features)
- **Test in preview mode** before saving to device
- **Use the .com Studio** for visual editing — it auto-generates these directives

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| File won't save (size error) | Remove large images or shorten text |
| Images not loading | Ensure data URLs are complete and valid |
| Layout breaks on mobile | Use `GRID:` instead of fixed-width tables |
| Custom HTML doesn't render | Check closing tags — malformed HTML breaks the parser |

