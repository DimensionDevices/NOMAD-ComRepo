# NOMAD User Manual

## Table of Contents

1. [System Dashboard](#1-system-dashboard)
2. [Bookmarks](#2-bookmarks)
3. [File Management](#3-file-management)
4. [Messenger (LoRa Chat)](#4-messenger-lora-chat)
5. [File Transfers](#5-file-transfers)
6. [Nodes & Discovery](#6-nodes--discovery)
7. [Action Buttons](#7-action-buttons)
8. [Interface Customization (Settings)](#8-interface-customization-settings)
9. [.com Studio: Website Builder](#9-com-studio-website-builder)
10. [.com File Viewer](#10-com-file-viewer)
11. [Markdown, Image & AVIF Rendering](#11-markdown-image--avif-rendering)
12. [.ext / .thm Files (Extensions & Themes)](#12-ext--thm-files-extensions--themes)
13. [.com Site Database (Persistent Storage)](#13-com-site-database-persistent-storage)
14. [File Compression](#14-file-compression)
15. [Offline Detection & Recovery](#15-offline-detection--recovery)
16. [Configuration Mode](#16-configuration-mode)
17. [Privacy & Security Settings](#17-privacy--security-settings)
18. [Admin File Panel](#18-admin-file-panel)
19. [App Repository](#19-app-repository)
20. [Status Overlay](#20-status-overlay)
21. [Advanced File Operations](#21-advanced-file-operations)
22. [File Beaconing](#22-file-beaconing)
23. [LoRa Radio Settings](#23-lora-radio-settings)
24. [Creating Files](#creating-files)

## 1. System Dashboard

The main dashboard displays your NOMAD's status in real time. All stats auto-refresh every 10 seconds.

- **Device ID** - your unique 10-character node identifier
- **Router IP** - your NOMAD IP address when connected to WiFi
- **Nearby Nodes** - count of discovered LoRa nodes within range
- **Local Files** - number of files stored on your device
- **Duty Cycle** - LoRa transmission usage percentage
- **Free Memory** - available heap memory in kB, with a visual indicator bar
- **Storage Space** - Shows used/total space on device, with a visual indicator bar
- **LoRa Frequency** - current radio frequency
- **Spreading Factor** - current Spreading Factor (SF) value
- **Temperature** - onboard temperature reading
- **Child-Safe Filter** - ENABLED/DISABLED status

## 2. Bookmarks

Save frequently-accessed files as favorites. Bookmarks persist across browser sessions and are stored *locally* in your browser's `localStorage`. Click the star icon (☆/★) on any file in the directory list to toggle its bookmark status.

## 3. File Management

### Supported File Types

| Extension | Icon | Viewer Mode |
|---|---|---|
| `.txt` | 📝 | Plain text viewer |
| `.md` | 📋 | Markdown renderer |
| `.com` | 🌐 | Pseudo-website viewer |
| `.img` | 🖼️ | Image viewer (DataURL) |
| `.avif` | 🖼️ | Image viewer (AVIF images) |
| `.ext` / `.thm` | 🧩 | Site extension / theme package (see [Section 12](#12-ext--thm-files-extensions--themes)) |

### File Operations

- **Upload** - add files up to 20KB (larger files may still fit if they compress under the limit - see [Compression](#14-file-compression))
- **✏Create** - create new files (max 6-character filename)
- **🗑Delete** - remove files with confirmation
- **⬇Download** - save files to your connected/local device
- **👁View** - display file contents (cached locally for 24h for quicker access)
- **Search** - filter files by name with live search
- **Sort** - sort by name/size, ascending/descending (persists in localStorage)

### View Modes

- **List View** - detailed list with size, packet count, and action buttons
- **Folder View** - grouped by file extension (e.g. `.com`, `.md`, `.txt`)
- **Grid View** - card-based visual layout with icons and file size
- **Category View** - grouped by user-defined categories (see below)

### File Caching & Management

Files are cached locally in your browser for 24 hours. Manual cache clearing is available per-file or globally via the refresh button.

- **Individual Cache** - click the "📁 Cached" indicator in the file viewer to clear the cache for that file
- **Global Cache Clear** - click the refresh button in the Directory section to clear all cached files
- **Refresh All** - the refresh button updates all dashboard data: status, nodes, and files

### User-Defined Categories

You can categorize your files locally in your browser. This is a purely organizational feature and does *not* affect the device's storage.

- **Categorize** - click the "Category" badge on any file (e.g. "Game", "Info") to open the category picker
- **Create Category** - from the picker, choose "New category…" to define your own categories (e.g. "Projects", "Recipes", "Manuals")
- **Remove Category** - use the "✕" next to a category in the picker to delete it; files become uncategorized

## 4. Messenger (LoRa Chat)

Send and receive text messages over LoRa radio to other NOMAD devices.

- **Node Selection** - choose a target node from the dropdown, automatically populated by discovered devices
- **Broadcast** - selecting "Broadcast to all nodes" sends your message to every node in range
- **Message Limit** - maximum 150 characters per message
- **Real-time Polling** - new messages are fetched automatically every 3 seconds
- **Fullscreen Mode** - click the fullscreen icon to expand the chat interface (press Escape to exit)

> **Note:** When Child-Safe Filter is enabled, profanity is censored, URLs are masked, and images are blurred.

## 5. File Transfers

Shows real-time status of ongoing LoRa file transfers between nodes.

- **State Tracking** - displays current state (Requesting/Receiving/Complete/Error) for each transfer
- **Progress Bar** - visual indicator of download progress
- **Automatic Handling** - transfers are managed by the device's LoRa manager

## 6. Nodes & Discovery

### Node Information Display

- **Node ID** - remote device identifier (format: `NMD-XXXXXXX`)
- **Signal Strength** - RSSI-based quality indicator: Excellent/Good/Fair/Weak/Very Weak
- **RSSI** - received signal strength in dBm
- **SNR** - signal-to-noise ratio in dB
- **Estimated Distance** - approximate range in meters
- **Last Seen** - seconds since the last beacon was received; stale nodes are automatically removed
- **File Count** - number of files available on the remote node
- **Uptime** - remote node uptime in minutes

### Node Actions

- **Discover/Refresh Files** - request the file list from a remote node, with a progress overlay indicating request status
- **Get File** - download a specific file from a remote node (e.g. `.txt`, `.md`, `.com`)
- **Refresh Nodes** - manually refresh the node list; node cards update dynamically
- **Auto-cleanup** - stale nodes are automatically removed after a timeout

## 7. Action Buttons

Clicking the large `+` button in the lower right corner will open a radial menu with the following options:

| Button | Function |
|---|---|
| Upload | Trigger file upload dialog |
| Create  | Open file creation modal with .com Studio tools |
| Studio | Open .com website builder in a modal |
| Repo | Open NOMAD app repository (requires WiFi connection) |
| Help/Settings | Open help modal with interface customization options |

## 8. Interface Customization (Settings)

The help modal provides persistent interface customization options stored in your browser.

- **Dark Mode** - toggle between light and dark themes
- **Left-Handed Mode** - move (and flip) the floating action button and attached menu to the left side
- **Reorder Sections** - use arrow buttons to rearrange dashboard sections (e.g. put Messenger at the top)
- **Hide Sections** - uncheck a section in the arrange interface to hide it from the dashboard
- **Reset to Default** - revert all interface arrangements to the factory order
- **Clear ALL Local Storage** - reset all browser settings, favorites, and cached data, this may not clear all .com/.ext/.thm local storage data, you may use the official NOMAD lstore.ext extension for more in-depth management of your data

## 9. .com Studio: Website Builder

The .com Studio lets you build simple, self-contained "pseudo-websites" that live entirely on your NOMAD device and render in a sandboxed viewer.

- **Component Library** - headers, text, tables, grids, cards, alerts, buttons, links, images, custom CSS/JS, and more
- **Live Preview** - use the "Preview" button in the file creation modal to see how your file will render before saving

**For the full `.com` syntax reference and directive list**, see the official repository:
[https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/COM_README.md](https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/COM_README.md)

## 10. .com File Viewer

The `.com` viewer renders your created websites in a secure sandboxed iframe with full support for all components.

- **Automatic Parsing** - all `.com` directives are parsed and rendered correctly
- **Custom CSS/JS** - your custom style and script blocks are executed
- **Embedded Images** - DataURL images are displayed inline
- **Interactive Elements** - buttons, links, and alerts work as intended
- **Full Responsive** - automatically adapts to mobile and desktop screens
- **Persistent Storage** - `.com` sites can read and write their own persistently saved data; see [Section 13](#13-com-site-database-persistent-storage)
- **Dedicated Viewer** - clicking a `.com` file opens it in a fullscreen-like overlay with a close button (✕)

## 11. Markdown, Image & AVIF Rendering

### Markdown (.md) Files

NOMAD supports a comprehensive set of Markdown features:

- **Headers**
- **Text Formatting**
- **Code Blocks**
- **Links & Images** 
- **Blockquotes**
- **Lists**
- **Horizontal Rules** 

### Image (.img) Files

Store images as DataURLs directly in files. The studio includes a compression tool to resize and optimize images to stay under the size limit.

- **Upload & Convert** - use the "Convert Image" button in the create file modal
- **Size Limit** - max 500×500 pixels and 5KB raw file size (compressed)
- **Preview** - view images directly in the file viewer or the preview modal
- **Child-Safe** - images are blurred and click-blocked when the filter is enabled

### AVIF (.avif) Files

AVIF files are uncompressed, converted to DataURLs and saved directly. Some `.avif` files that look like they might fit into the 20KB limit may end up larger once converted - reduce the source file size further if an upload is rejected.

## 12. .ext / .thm Files (Extensions & Themes)

`.ext` and `.thm` files are add-on packages that extend or restyle your NOMAD dashboard without modifying the core firmware.

- **`.ext` files** are general extensions - they can inject custom HTML, CSS, and JavaScript into the dashboard. Some extensions target the Settings/Help panel directly (their content appears automatically inside the Help modal). **`.ext` files require a device restart to take effect**
- **`.thm` files** are layout/theme packages that change the visual appearance of the dashboard. **`.thm` files require a device restart to take effect** - you'll be prompted to restart after uploading or deleting one.
- Both file types appear in their own dedicated "Extensions" section of the file list (separate from your regular files), marked with a 🧩 icon.

`.ext` and `.thm` files follow a structured JSON format. For the full specification and how to create them, see the official repository:

📎 [https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/EXT_README.md](https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/EXT_README.md)

## 13. .com Site Database (Persistent Storage)

`.com` sites are not limited to static content - they can save and retrieve their own data on the device, so a site's own JavaScript can persist state (scores, settings, notes, etc.) across visits without needing a filename hardcoded in.

- Each `.com` site gets its own private data store, automatically inferred from the site being viewed.
- Sites can **set**, **get**, **remove**, and **clear** their stored data.
- This enables interactive apps built entirely as `.com` files - trackers, journals, small games with saved progress, and similar tools - all running locally on your NOMAD.

For the syntax used inside a `.com` file to read and write this storage, see the `.com` repository documentation linked in [Section 9](#9-com-studio-website-builder).

## 14. File Compression

To help larger files fit within the size limit, NOMAD automatically compresses eligible files during upload/creation, on browsers that support it.

- **Eligible Types** - `.txt`, `.md`, and `.com` files are gzip-compressed automatically before upload
- **.ext and .thm** - extensions and layout themes are not eligable for compression
- **Automatic** - compression happens transparently; you'll see the compressed size in the byte counter as you type
- **Transparent Decoding** - compressed files are automatically decompressed when viewed, so they display normally
- **Browser Support** - requires a browser with native `CompressionStream`/`DecompressionStream` support; if unsupported, files upload uncompressed and must fit the raw 20KB limit
- Images (`.img`, `.avif`) are **not** compressed, since they're already binary data encoded as DataURLs

## 15. Offline Detection & Recovery

If connection to your NOMAD device is lost, a warning appears with auto-retry functionality.

- **Automatic Detection** - the dashboard detects network failures during API calls
- **Auto-Retry** - attempts to reconnect every 10 seconds, displaying a countdown
- **Dismiss** - the modal can be manually dismissed when the connection is restored
- **Seamless Recovery** - once reconnected, the dashboard automatically refreshes all data

## 16. Configuration Mode (First Boot)

When no WiFi configuration exists, the device enters Access Point mode with a unique SSID (`NMD-CONFIG-XXXXXX`) at IP `192.168.4.1`. Connect to this network and navigate to `/config` to set up your WiFi credentials and LoRa settings.

## 17. Privacy & Security Settings

### Child-Safe Filter

When enabled, this filter automatically:

- Censors profanity in chat messages and file content
- Blurs images inside of .com, .md, .img and .avif file types
- Masks URLs in text
- Affects all rendered content and LoRa messenger chat messages

### Public File Management

Controls whether anyone on the network can create, modify, or delete files.

- **Enabled (Default)** - all users can upload, create, and delete files
- **Disabled** - file operations require admin authentication

## 18. Admin File Panel

An administrator-facing view of the device's complete filesystem, useful for troubleshooting and management beyond what the standard file list shows.

Accessible from: http://YOUR_NOMAD_IP/config

- Lists **every** file stored on the device, including files in subdirectories not normally surfaced in the main dashboard view (i.e. NOMAD WiFi & configuration files)
- Useful for diagnosing storage issues or locating files outside the standard flat file list
- Intended for administrative/diagnostic use rather than everyday file browsing
- Viewing a file in the admin file panel will show you the files *raw* contents

## 19. App Repository

Download and install example `.com`, `.ext` and `.thm` files and applications directly from the official NOMAD repository on GitHub.

- **Browse Apps** - view a categorized list of available apps (Info, App, Game, Other, Extension and Layouts)
- **Search** - filter apps by name or description
- **Install** - click the "Install" button to download and save an app/extension (e.g. `calculator.com`, `lstore.ext`)
- **Progress Tracking** - installation progress is shown with a status bar
- **WiFi Required** - requires an internet connection as the repo contents are obtained from the official NOMAD GitHub

## 20. Status Overlay

The status overlay slides in from the bottom of the screen and provides real-time feedback for long-running operations.

- **Operations** - file list requests, file downloads, app installations, multi-file uploads, etc.
- **Progress Bar** - visual representation of the operation's progress
- **Status Messages** - detailed text updates (e.g. "Requesting file list from NMD-1234567...")
- **Dismiss** - can be minimized or closed once the operation completes

## 21. Advanced File Operations

### File Preview & Editing

The file creation modal includes advanced tools for building and editing files.

- **Markdown Toolbar** - insert formatting elements (bold, italic, headings, lists, code, links, images)
- **.com Component Dropdown** - insert pre-built structures (tables, grids, cards, CSS, JavaScript, HTML blocks)
- **Image Converter** - upload and compress images to DataURL format
- **Byte Counter** - real-time display of file size (post-compression, where applicable) and packet count, so you can stay under the size limit

## 22. File Beaconing

NOMAD devices share file availability via LoRa beacons. Control which files are announced to other nodes.

- **Beacon Management** - configured in the NOMAD Configuration page (`/config`)
- **Visual Indicator** - files that are beaconed show a signal icon (📡) in the file list
- **Dynamic Updates** - changes take effect without rebooting the device
- **Byte Limit** - the beacon payload is limited to 180 bytes; if too many files are shared, the oldest are dropped

## 23. LoRa Radio Settings

### Frequency & Region

Choose from a wide range of frequencies optimized for different regions and performance. The device's PCB is optimized for 150-960 MHz. However the limitation on this will be the antenna you use, certain antennas work better with certain frequency ranges.

- **Europe/UK** - 868.1 MHz
- **The Americas** - 915 MHz
- **Australia/New Zealand** - 915 MHz
- **Asia** - 920 MHz (Japan), 923 MHz (Taiwan), 866 MHz (India)
- **Expert Frequencies** - 150-930 MHz with star ratings for optimal performance

### Spreading Factor (SF)

Higher spreading factor values will provide longer range, but will have a trade off of slower data rates.

| SF | Speed | Range |
|---|---|---|
| SF7 | Fastest | Shortest |
| SF8 | Fast | Short |
| SF9 | Balanced (Default) | - |
| SF10 | Slow | Longer |
| SF11 | Slower | Long |
| SF12 | Slowest | Longest |

### Duty Cycle

The percentage of each hour your device can transmit. Lower values conserve battery and comply with regulations.

- **1%-100%** - configurable with a slider
- **Region Recommendation** - the config page automatically adjusts the duty cycle based on the selected region

**Legal Notice:** It is your *sole* responsibility to verify that your use of this device complies with all applicable local laws and regulations governing LoRa radio transmissions. Please research and confirm your local requirements before operating the NOMAD.

## Creating Files

Full syntax references and build tooling for `.com`, `.ext` and `.thm` file types live in the official NOMAD-ComRepo repository:

- **`.com` files** (pseudo-websites): [COM_README.md](https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/COM_README.md)
- **`.ext` / `.thm` files** (extensions & themes): [EXT_README.md](https://github.com/DimensionDevices/NOMAD-ComRepo/blob/main/EXT_README.md)