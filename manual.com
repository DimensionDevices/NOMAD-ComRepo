PAGE: NOMAD - Complete User Manual
COLOR: #547540
AUTHOR: NOMAD Project
DATE: 2026-06-25
BIGHEADER: NOMAD User Manual

CUSTOMHTML-START
<style>
.quick-links{gap:2px 8px;padding:8px 0;margin:0 0 12px 0;list-style:none;justify-content:center;border-bottom:1px solid rgb(0 0 0 / .08);border-top:1px solid rgb(0 0 0 / .08)}.quick-links li{margin:0;padding:2px 0;font-size:.85em;line-height:1.3}.quick-links li a{color:var(--accent,#547540);text-decoration:none;padding:2px 4px;border-radius:4px;transition:background 0.2s}.quick-links li a:hover{background:rgb(84 117 64 / .12);text-decoration:underline}.quick-links li .sep{color:#aaa;margin-left:6px}.section-anchor{display:block;position:relative;top:-20px;visibility:hidden;height:0}
</style>

<script>
function scrollToSection(e){var t=document.getElementById(e);if(t){var n=t.getBoundingClientRect().top+window.pageYOffset-20;window.scrollTo({top:n,behavior:"smooth"})}return!1}document.addEventListener("DOMContentLoaded",function(){for(var e=document.querySelectorAll(".quick-links a"),t=0;t<e.length;t++)e[t].addEventListener("click",function(e){e.preventDefault();var t=this.getAttribute("href");t&&0===t.indexOf("#")&&scrollToSection(t.substring(1))})});
</script>
<center><svg width="54px" height="54px" viewBox="0 0 685 700" version="1.1" xmlns="http://www.w3.org/2000/svg"><g id="#ffffffff"><path fill="#333333" opacity="1.00" d=" M 280.70 0.00 L 297.00 0.00 C 296.98 17.33 297.04 34.65 296.97 51.98 C 229.41 51.71 162.45 81.02 116.89 130.91 C 68.01 183.31 44.38 257.89 54.09 328.90 C 63.59 406.19 112.81 476.73 181.47 513.23 C 169.30 526.26 156.37 538.55 143.83 551.21 C 60.09 502.38 5.63 409.69 0.00 313.29 L 0.00 280.72 C 4.71 208.49 35.35 138.00 86.98 86.98 C 138.00 35.36 208.48 4.71 280.70 0.00 Z"></path><path fill="#333333" opacity="1.00" d=" M 388.00 0.00 L 404.29 0.00 C 476.52 4.71 547.00 35.36 598.03 86.98 C 649.64 138.00 680.29 208.48 685.00 280.70 L 685.00 313.29 C 679.37 409.68 624.91 502.38 541.17 551.21 C 528.63 538.55 515.70 526.25 503.53 513.23 C 572.19 476.73 621.41 406.19 630.91 328.90 C 640.62 257.89 616.99 183.31 568.11 130.91 C 522.55 81.01 455.59 51.71 388.03 51.98 C 387.95 34.65 388.02 17.33 388.00 0.00 Z"></path><path fill="#333333" opacity="1.00" d=" M 118.68 215.66 C 149.05 146.95 221.86 100.15 296.98 100.98 C 297.02 116.98 297.01 132.97 296.99 148.97 C 227.77 147.22 163.12 201.25 151.38 269.28 C 135.92 341.82 183.95 419.80 255.31 439.34 C 243.19 451.87 231.16 464.84 218.03 476.17 C 162.74 452.76 120.49 401.71 106.57 343.41 C 96.15 301.07 100.47 255.29 118.68 215.66 Z"></path><path fill="#333333" opacity="1.00" d=" M 388.02 100.99 C 450.89 100.56 512.76 132.76 548.51 184.47 C 572.42 218.56 585.14 260.37 583.92 302.02 C 582.84 376.16 535.42 447.43 466.98 476.17 C 453.84 464.85 441.80 451.87 429.69 439.34 C 492.67 421.68 539.25 358.58 536.00 293.00 C 536.18 215.37 465.66 146.63 388.01 148.96 C 387.99 132.97 387.98 116.98 388.02 100.99 Z"></path><path fill="#333333" opacity="1.00" d=" M 322.81 245.78 C 350.15 234.14 384.74 249.99 393.65 278.34 C 403.91 304.43 388.69 335.91 363.07 346.15 C 362.88 405.13 363.10 464.11 362.96 523.10 C 362.35 528.05 366.90 530.97 369.90 534.10 C 390.71 554.74 411.32 575.59 432.13 596.24 C 464.70 581.29 506.62 605.89 507.79 642.03 C 510.70 670.16 488.11 696.53 460.43 700.00 L 447.58 700.00 C 413.13 696.26 389.89 656.84 404.06 624.99 C 390.54 611.17 376.81 597.56 363.09 583.96 C 362.85 617.93 363.12 651.91 362.95 685.88 C 349.99 685.88 337.02 685.88 324.05 685.89 C 323.85 633.16 324.21 580.42 323.87 527.69 C 309.29 541.59 295.30 556.11 281.00 570.30 C 284.42 580.43 286.16 591.34 283.97 601.94 C 278.84 632.94 242.85 654.42 213.35 642.61 C 183.64 633.33 168.05 595.98 182.27 568.29 C 193.89 542.36 227.01 530.45 252.81 541.90 C 276.36 518.11 300.68 494.92 323.56 470.58 C 324.43 429.32 324.03 387.86 323.75 346.54 C 305.61 339.98 291.74 322.95 289.32 303.79 C 285.40 279.67 299.92 254.35 322.81 245.78 Z"></path></g></svg></center>
CUSTOMHTML-END

TEXT: **Quick Links:**
<ul class="quick-links">
<li><a href="#section-1">1. Dashboard</a></li>
<li><a href="#section-2">2. Bookmarks</a></li>
<li><a href="#section-3">3. File Management</a></li>
<li><a href="#section-4">4. Messenger</a></li>
<li><a href="#section-5">5. Transfers</a></li>
<li><a href="#section-6">6. Nodes</a></li>
<li><a href="#section-7">7. Action Buttons</a></li>
<li><a href="#section-8">8. Customization</a></li>
<li><a href="#section-9">9. .com Studio</a></li>
<li><a href="#section-10">10. .com Viewer</a></li>
<li><a href="#section-11">11. Markdown</a></li>
<li><a href="#section-12">12. Offline</a></li>
<li><a href="#section-13">13. Config Mode</a></li>
<li><a href="#section-14">14. Privacy</a></li>
<li><a href="#section-15">15. App Repo</a></li>
<li><a href="#section-16">16. Status Overlay</a></li>
<li><a href="#section-17">17. Advanced Ops</a></li>
<li><a href="#section-18">18. Beaconing</a></li>
<li><a href="#section-19">19. LoRa Settings</a></li>
</ul>

<span class="section-anchor" id="section-1"></span>
HEADER: 1. System Dashboard
TEXT: The main dashboard displays your NOMAD's status in real-time. All stats auto-refresh every 10 seconds.
LIST-START
ITEM: Device ID: Your unique 10-character node identifier
ITEM: Router IP: Your STA mode IP address when connected to WiFi.
ITEM: Nearby Nodes: Count of discovered LoRa nodes within range
ITEM: Local Files: Number of files stored on your device
ITEM: Duty Cycle: LoRa transmission usage percentage
ITEM: Free Memory: Available heap memory in kB, with a visual indicator bar
ITEM: Storage Space: LittleFS used/total space on device, with a visual indicator bar
ITEM: LoRa Frequency: Current radio frequency
ITEM: Spreading Factor: Current SF value
ITEM: Child-Safe Filter: ENABLED/DISABLED status
LIST-END

<span class="section-anchor" id="section-2"></span>
HEADER: 2. Bookmarks
TEXT: Save frequently-accessed files as favorites. Bookmarks persist across browser sessions and are stored locally in your browser's localStorage. Click the star icon (☆/★) on any file in the directory list to toggle its bookmark status.

<span class="section-anchor" id="section-3"></span>
HEADER: 3. File Management
SUBHEADER: Supported File Types
TABLE-START
HEADER: Extension | Icon | Viewer Mode
ROW: .txt | 📝 | Plain text viewer
ROW: .md | 📋 | Markdown renderer
ROW: .com | 🌐 | Pseudo-website viewer (sandboxed iframe)
ROW: .img | 🖼️ | Image viewer (DataURL images)
ROW: .avif | 🖼️ | Image viewer (AVIF images)
TABLE-END
SUBHEADER: File Operations
LIST-START
ITEM: 📤 Upload: Add files up to 20KB
ITEM: ✏️ Create: Create new files (max 6-character filename)
ITEM: 🗑️ Delete: Remove files with confirmation
ITEM: ⬇️ Download: Save files to your local device
ITEM: 👁️ View: Display file contents (cached locally for 24h)
ITEM: 🔍 Search: Filter files by name with live search
ITEM: ⬆️⬇️ Sort: Sort by name/size, ascending/descending (persists in localStorage)
LIST-END
SUBHEADER: View Modes
LIST-START
ITEM: List View: Detailed list with size, packet count, and action buttons
ITEM: Folder View: Grouped by file extension (e.g., .com, .md, .txt)
ITEM: Grid View: Card-based visual layout with icons and file size
ITEM: Category View: Grouped by user-defined categories (see Categories below)
LIST-END
SUBHEADER: File Caching & Management
TEXT: Files are cached locally in your browser for 24 hours. Manual cache clearing is available per-file or globally via the refresh button.
LIST-START
ITEM: Individual Cache: Click the "📁 Cached" indicator in the file viewer to clear the cache for that file
ITEM: Global Cache Clear: Click the refresh button in the Directory section to clear all cached files
ITEM: Refresh All: The refresh button updates all dashboard data: status, nodes, and files
LIST-END
SUBHEADER: User-Defined Categories
TEXT: You can categorize your files locally in your browser. This is a powerful organizational feature that does not affect the device's storage.
LIST-START
ITEM: Categorize: Click the "Category" badge on any file (e.g., "Game", "Info") to open the category picker
ITEM: Create Category: From the picker, choose "New category…" to define your own categories (e.g., "Projects", "Recipes", "Manuals")
ITEM: Remove Category: Use the "✕" next to a category in the picker to delete it; files become uncategorized
ITEM: Filter by Category: Use the dropdown menu in the Directory section to show only files from a specific category
LIST-END

<span class="section-anchor" id="section-4"></span>
HEADER: 4. Messenger (LoRa Chat)
TEXT: Send and receive text messages over LoRa radio to other NOMAD devices.
LIST-START
ITEM: Node Selection: Choose a target node from the dropdown, which is automatically populated by discovered devices
ITEM: Broadcast: Selecting "Broadcast to all nodes" sends your message to every node in range
ITEM: Message Limit: Maximum 150 characters per message
ITEM: Real-time Polling: New messages are fetched automatically every 3 seconds
ITEM: Fullscreen Mode: Click the fullscreen icon to expand the chat interface (press Escape to exit)
LIST-END
TEXT: **Note:** When Child-Safe Filter is enabled, profanity is censored, URLs are masked, and images are blurred.

<span class="section-anchor" id="section-5"></span>
HEADER: 5. File Transfers
TEXT: Shows real-time status of ongoing LoRa file transfers between nodes.
LIST-START
ITEM: State Tracking: Displays current state (Requesting/Receiving/Complete/Error) for each transfer
ITEM: Progress Bar: Visual indicator of download progress
ITEM: Automatic Handling: Transfers are managed by the device's LoRa manager
LIST-END

<span class="section-anchor" id="section-6"></span>
HEADER: 6. Nodes & Discovery
SUBHEADER: Node Information Display
LIST-START
ITEM: Node ID: Remote device identifier (format: NMD-XXXXXXX)
ITEM: Signal Strength: RSSI-based quality indicator: Excellent/Good/Fair/Weak/Very Weak
ITEM: RSSI: Received signal strength in dBm
ITEM: SNR: Signal-to-noise ratio in dB
ITEM: Estimated Distance: Approximate range in meters
ITEM: Last Seen: Seconds since the last beacon was received; stale nodes are automatically removed
ITEM: File Count: Number of files available on the remote node
ITEM: Uptime: Remote node uptime in minutes
LIST-END
SUBHEADER: Node Actions
LIST-START
ITEM: Discover/Refresh Files: Request the file list from a remote node, with a progress overlay indicating request status
ITEM: Get File: Download a specific file from a remote node (e.g., .txt, .md, .com)
ITEM: Refresh Nodes: Manually refresh the node list; node cards are updated dynamically
ITEM: Auto-cleanup: Stale nodes are automatically removed after a timeout
LIST-END

<span class="section-anchor" id="section-7"></span>
HEADER: 7. Action Buttons
TABLE-START
HEADER: Button | Function
ROW: Upload (📤) | Trigger file upload dialog
ROW: Create (✏️) | Open file creation modal with .com Studio tools
ROW: Studio (🌐) | Open .com website builder in a modal
ROW: Repo (🏪) | Open NOMAD app repository (requires WiFi connection)
ROW: Help/Settings (⚙️) | Open help modal with interface customization options
TABLE-END

<span class="section-anchor" id="section-8"></span>
HEADER: 8. Interface Customization (Settings)
TEXT: The help modal provides persistent interface customization options stored in your browser.
LIST-START
ITEM: Dark Mode: Toggle between light and dark themes
ITEM: Left-Handed Mode: Move the floating action button to the left side
ITEM: Reorder Sections: Drag-and-drop or use arrow buttons to rearrange dashboard sections (e.g., put Messenger at the top)
ITEM: Hide Sections: Uncheck a section in the arrange interface to hide it from the dashboard
ITEM: Reset to Default: Revert all interface arrangements to the factory order
ITEM: Clear ALL Local Storage: Reset all browser settings, favorites, and cached data
LIST-END

<span class="section-anchor" id="section-9"></span>
HEADER: 9. .com Studio: Website Builder
SUBHEADER: Available Components
TABLE-START
HEADER: Category | Components
ROW: Metadata | PAGE, COLOR, AUTHOR, DATE, DESCRIPTION
ROW: Headings | BIGHEADER, HEADER, SUBHEADER, SUBTITLE
ROW: Text Elements | TEXT, PARAGRAPH, QUOTE, CODE
ROW: Alerts & Progress | ALERT (info/warn/error), PROGRESS
ROW: Links & Media | LINK, BUTTON, IMAGE, VIDEO
ROW: Structures | LIST, TABLE, GRID, CARD, DIVIDER
ROW: Custom Code | STYLE (CSS), SCRIPT (JS), CUSTOMHTML
TABLE-END
SUBHEADER: Text Formatting (Inline Markdown)
TEXT: Within any text content, you can use:
LIST-START
ITEM: **bold**: Surround text with **double asterisks**
ITEM: *italic*: Surround text with *single asterisks*
ITEM: `code`: Surround text with backticks `
ITEM: [link text](url): Create hyperlinks
LIST-END
SUBHEADER: Live Preview
TEXT: Use the "Preview" button in the file creation modal to see how your .com, .md, .img or .avif file will render before saving.

<span class="section-anchor" id="section-10"></span>
HEADER: 10. .com File Viewer
TEXT: The .com viewer renders your created websites in a secure sandboxed iframe with full support for all components.
LIST-START
ITEM: Automatic Parsing: All .com directives are parsed and rendered correctly
ITEM: Custom CSS/JS: Your custom STYLE and SCRIPT blocks are executed
ITEM: Embedded Images: DataURL images are displayed inline
ITEM: Interactive Elements: Buttons, links, and alerts work as intended
ITEM: Full Responsive: Automatically adapts to mobile and desktop screens
ITEM: Dedicated Viewer: Clicking a .com file opens it in a fullscreen-like overlay with a close button (✕)
LIST-END

<span class="section-anchor" id="section-11"></span>
HEADER: 11. Markdown & Image Rendering
SUBHEADER: Markdown (.md) Files
TEXT: NOMAD supports a comprehensive set of Markdown features:
LIST-START
ITEM: Headers: #, ##, ###, ####, #####, ######
ITEM: Text Formatting: **bold**, *italic*, `code`
ITEM: Code Blocks: ``` fences or indented 4 spaces
ITEM: Links & Images: [text](url) and ![alt](src) (images are blurred if Child-Safe is on)
ITEM: Blockquotes: Lines starting with >
ITEM: Lists: Unordered (- or *) and ordered (1.)
ITEM: Horizontal Rules: ---
LIST-END
SUBHEADER: Image (.img) Files
TEXT: Store images as DataURLs directly in files. The studio includes a compression tool to resize and optimize images to stay under the 20KB limit.
LIST-START
ITEM: Upload & Convert: Use the "Convert Image" button in the create file modal
ITEM: Size Limit: Max 500x500 pixels and 5KB raw file size (compressed)
ITEM: Preview: View images directly in the file viewer or the preview modal
ITEM: Child-Safe: Images are blurred and click-blocked when the filter is enabled
LIST-END
SUBHEADER: AVIF (.avif) Files
TEXT: AVIF files are uncompressed, converted to DataURLs and saved directly. Thus some .avif files that look like they might fit into the 20kb limit may be larger than 20kb when attempting the upload. Reduce the file size further to mitigate this.

<span class="section-anchor" id="section-12"></span>
HEADER: 12. Offline Detection & Recovery
TEXT: If connection to your NOMAD device is lost, a modal appears with auto-retry functionality.
LIST-START
ITEM: Automatic Detection: The dashboard detects network failures during API calls
ITEM: Auto-Retry: Attempts to reconnect every 10 seconds, displaying a countdown
ITEM: Dismiss: The modal can be manually dismissed when the connection is restored
ITEM: Seamless Recovery: Once reconnected, the dashboard automatically refreshes all data
LIST-END

<span class="section-anchor" id="section-13"></span>
HEADER: 13. Configuration Mode
TEXT: When no WiFi configuration exists, the device enters Access Point mode with a unique SSID (NMD-CONFIG-XXXXXX) at IP 192.168.4.1. Connect to this network and navigate to /config to set up your WiFi credentials and LoRa settings.

<span class="section-anchor" id="section-14"></span>
HEADER: 14. Privacy & Security Settings
SUBHEADER: Child-Safe Filter
TEXT: When enabled, this filter automatically:
LIST-START
ITEM: Censors profanity in chat messages and file content
ITEM: Blurs images in the Markdown viewer (clicking shows an alert)
ITEM: Masks URLs in text (shows only the domain, e.g., ********.com)
ITEM: Affects all rendered content: .md, .txt, and chat messages
LIST-END
SUBHEADER: Public File Management
TEXT: Controls whether anyone on the network can create, modify, or delete files.
LIST-START
ITEM: Enabled (Default): All users can upload, create, and delete files
ITEM: Disabled: File operations require admin authentication
ITEM: Affects: Upload button, create button, and delete buttons in the file list
LIST-END

<span class="section-anchor" id="section-15"></span>
HEADER: 15. App Repository
TEXT: Download and install example .com files and applications directly from the official NOMAD repository on GitHub.
LIST-START
ITEM: Browse Apps: View a categorized list of available apps (Info, App, Game, Other)
ITEM: Search: Filter apps by name or description
ITEM: Install: Click the "Install" button to download and save an app (e.g., calculator.com, dice.com)
ITEM: Overwrite: If a file already exists, you'll be prompted to overwrite it
ITEM: Progress Tracking: Installation progress is shown with a status bar
ITEM: WiFi Required: Requires an internet connection via STA mode
LIST-END

<span class="section-anchor" id="section-16"></span>
HEADER: 16. Status Overlay
TEXT: The status overlay provides real-time feedback for long-running operations.
LIST-START
ITEM: Operations: File list requests, file downloads, app installations, etc.
ITEM: Progress Bar: Visual representation of the operation's progress
ITEM: Status Messages: Detailed text updates (e.g., "Requesting file list from NMD-1234567...")
ITEM: Dismiss: Can be minimized or closed once the operation completes
LIST-END

<span class="section-anchor" id="section-17"></span>
HEADER: 17. Advanced File Operations
SUBHEADER: File Preview & Editing
TEXT: The file creation modal includes advanced tools for building and editing files.
LIST-START
ITEM: Markdown Toolbar: Insert formatting elements (bold, italic, headings, lists, code, links, images)
ITEM: .com Component Dropdown: Insert pre-built structures (tables, grids, cards, CSS, JavaScript, HTML blocks)
ITEM: Image Converter: Upload and compress images to DataURL format
ITEM: Byte Counter: Real-time display of file size and packet count (ensures you stay under the 20KB limit)
LIST-END

<span class="section-anchor" id="section-18"></span>
HEADER: 18. File Beaconing
TEXT: NOMAD devices share file availability via LoRa beacons. Control which files are announced to other nodes.
LIST-START
ITEM: Beacon Management: Configured in the NOMAD Configuration page (/config)
ITEM: Visual Indicator: Files that are beaconed show a signal icon (📡) in the file list
ITEM: Dynamic Updates: Changes take effect without rebooting the device
ITEM: Byte Limit: The beacon payload is limited to 180 bytes; if too many files are shared, the oldest are dropped
LIST-END

<span class="section-anchor" id="section-19"></span>
HEADER: 19. LoRa Radio Settings
SUBHEADER: Frequency & Region
TEXT: Choose from a wide range of frequencies optimized for different regions and performance. The device's PCB is optimized for 860-915 MHz.
LIST-START
ITEM: Europe/UK: 868.1 MHz
ITEM: The Americas: 915 MHz
ITEM: Australia/New Zealand: 915 MHz
ITEM: Asia: 920 MHz (Japan), 923 MHz (Taiwan), 866 MHz (India)
ITEM: Expert Frequencies: 850-930 MHz with star ratings for optimal performance
LIST-END
SUBHEADER: Spreading Factor (SF)
TEXT: Higher values provide longer range but slower data rates.
LIST-START
ITEM: SF7: Fastest, Shortest Range
ITEM: SF8: Fast, Short Range
ITEM: SF9: Balanced (Default)
ITEM: SF10: Slow, Longer Range
ITEM: SF11: Slower, Long Range
ITEM: SF12: Slowest, Longest Range
LIST-END
SUBHEADER: Duty Cycle
TEXT: The percentage of each hour your device can transmit. Lower values conserve battery and comply with regulations.
LIST-START
ITEM: 1% - 100%: Configurable with a slider
ITEM: Region Recommendation: The config page automatically adjusts the duty cycle based on the selected region
LIST-END