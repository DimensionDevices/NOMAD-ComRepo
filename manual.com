PAGE: NOMAD Device Manual
COLOR: #547540
AUTHOR: NOMAD Project
DATE: 2026-06-03
DESCRIPTION: Guide to using your NOMAD LoRa mesh device.
CATEGORY: info
BIGHEADER: NOMAD User Manual
SUBTITLE: Network for Open Messaging & Data
HEADER: 1. System Dashboard
TEXT: The main dashboard displays your NOMAD's status in real-time. All stats auto-refresh every 10 seconds.
LIST-START
ITEM: Device ID: Your unique 10-character node identifier (format: NMD-XXXXXXX)
ITEM: Router IP: Your STA mode IP address when connected to WiFi
ITEM: Nearby Nodes: Count of discovered LoRa nodes within range
ITEM: Local Files: Number of files stored on your device
ITEM: Duty Cycle: LoRa transmission usage percentage (respects local regulations)
ITEM: Free Memory: Available heap memory in kB
ITEM: Storage Space: LittleFS used/total space on device
ITEM: LoRa Frequency: Current radio frequency (MHz)
ITEM: Spreading Factor: Current SF value (7-12, higher = longer range but slower)
ITEM: Child-Safe Filter: ENABLED/DISABLED status
LIST-END
HEADER: 2. Bookmarks
TEXT: Save frequently-accessed files as favorites. Bookmarks persist across browser sessions and are stored locally in your browser.
HEADER: 3. File Management
SUBHEADER: Supported File Types
TABLE-START
HEADER: Extension | Icon | Viewer Mode
ROW: .txt | 📝 | Plain text viewer
ROW: .md | 📋 | Markdown renderer
ROW: .com | 🌐 | Pseudo-website viewer (sandboxed iframe)
ROW: .img | 🖼️ | Image viewer (DataURL images)
TABLE-END
SUBHEADER: File Operations
LIST-START
ITEM: 📤 Upload: Add files up to 20KB
ITEM: ✏️ Create: Create new files (max 6-character filename)
ITEM: 🗑️ Delete: Remove files with confirmation
ITEM: ⬇️ Download: Save files to your local device
ITEM: 👁️ View: Display file contents
ITEM: 🔍 Search: Filter files by name
ITEM: ⬆️⬇️ Sort: Sort by name/size, ascending/descending
LIST-END
SUBHEADER: View Modes
LIST-START
ITEM: List view: Detailed list with descriptions
ITEM: Folder view: Grouped by file extension
ITEM: Grid view: Card-based visual layout
LIST-END
SUBHEADER: File Caching
TEXT: Files are cached locally in your browser for 24 hours. Manual cache clearing is available per-file or globally via the refresh button.
HEADER: 4. Messenger (LoRa Chat)
TEXT: Send and receive text messages over LoRa radio to other NOMAD devices.
LIST-START
ITEM: Node Selection: Choose a target node from the dropdown populated by discovered devices
ITEM: Message Limit: Maximum 150 characters per message
ITEM: Real-time Polling: New messages fetched automatically every 3 seconds
ITEM: Fullscreen Mode: Expand the chat interface (press Escape to exit)
ITEM: Broadcast: Messages sent to "All" reach every nearby node
LIST-END
TEXT: **Note:** When Child-Safe Filter is enabled, profanity is censored, URLs are masked and images are blurred.
HEADER: 5. Transfers (Active File Transfers)
TEXT: Shows real-time status of ongoing LoRa file transfers between nodes. Displays remote node ID, filename, current state (Requesting/Receiving/Complete/Error), and progress percentage.
HEADER: 6. Nodes: Discovered LoRa Nodes
SUBHEADER: Node Information Display
LIST-START
ITEM: Node ID: Remote device identifier
ITEM: Signal Strength: RSSI-based quality: Excellent/Good/Fair/Weak/Very Weak
ITEM: RSSI: Received signal strength in dBm
ITEM: SNR: Signal-to-noise ratio in dB
ITEM: Estimated Distance: Approximate range in meters
ITEM: Last Seen: Seconds since last beacon was received
ITEM: File Count: Number of files available on the remote node
ITEM: Uptime: Remote node uptime in minutes
LIST-END
SUBHEADER: Node Actions
LIST-START
ITEM: Discover/Refresh Files: Request the file list from a remote node
ITEM: Get File: Download a specific file from a remote node
ITEM: Refresh Nodes: Manually refresh the node list
ITEM: Auto-cleanup: Stale nodes are automatically removed after timeout
LIST-END
HEADER: 7. Action Buttons
TABLE-START
HEADER: Button | Function
ROW: Upload | Trigger file upload dialog
ROW: Create | Open file creation modal
ROW: Studio | Open .com website builder
ROW: Repo | Open NOMAD app repository (requires WiFi connection)
ROW: Help | Open help and about modal
TABLE-END
HEADER: 8. .com Studio: Website Builder
SUBHEADER: Available Components
TABLE-START
HEADER: Category | Components
ROW: Metadata | PAGE, COLOR, AUTHOR, DATE, DESCRIPTION
ROW: Headings | BIGHEADER, HEADER, SUBHEADER, SUBTITLE
ROW: Text Elements | TEXT, PARAGRAPH, QUOTE, CODE
ROW: Alerts & Progress | ALERT (info/warn/error), PROGRESS
ROW: Links & Media | LINK, BUTTON, IMAGE, VIDEO
ROW: Structures | LIST, TABLE, GRID, CARD, DIVIDER
ROW: Custom Code | STYLE, SCRIPT, CUSTOMHTML, SITELIST
TABLE-END
SUBHEADER: Text Formatting (Inline Markdown)
TEXT: Within any text content, you can use:
LIST-START
ITEM: **bold**: Surround text with **double asterisks**
ITEM: *italic*: Surround text with *single asterisks*
ITEM: `code`: Surround text with backticks `
ITEM: [link text](url): Create hyperlinks
LIST-END
HEADER: 9. Web Article Import
TEXT: Import content from web articles and convert to clean Markdown or .com format.
LIST-START
ITEM: Multiple CORS proxies available for fetching
ITEM: Automatic HTML to Markdown conversion
ITEM: Filtering options: Remove images, remove links, plain text only
ITEM: Content truncation with slider control (10-100%)
ITEM: Real-time preview before insertion
LIST-END
HEADER: 10. .com File Viewer
TEXT: The .com viewer renders your created websites in a secure sandboxed iframe with full support for all components listed above. The viewer includes:
LIST-START
ITEM: Automatic parsing of all .com directives
ITEM: Custom CSS and JavaScript execution
ITEM: Embedded data URL images
ITEM: Interactive elements (buttons, links)
ITEM: Full responsive layout
LIST-END
HEADER: 11. Markdown Renderer (.md files)
SUBHEADER: Supported Syntax
LIST-START
ITEM: # Heading 1, ## Heading 2, ### Heading 3
ITEM: **bold** and *italic* formatting
ITEM: `inline code` and ```code blocks```
ITEM: [links](url) and ![images](src)
ITEM: > blockquotes
ITEM: - bullet lists and 1. numbered lists
ITEM: --- horizontal dividers
LIST-END
HEADER: 12. Image Support (.img files)
TEXT: Store images as DataURLs directly in files. The studio includes a compression tool to resize and optimize images to stay under the 20KB limit.
HEADER: 13. Offline Detection
TEXT: If connection to your NOMAD device is lost, a modal appears with auto-retry functionality (every 10 seconds). Dismissible by user when connection is restored.
HEADER: 14. Configuration Mode
TEXT: When no WiFi configuration exists, the device enters Access Point mode with a unique SSID (NOMAD-CONFIG-XXXXXX) at IP 192.168.4.1. Connect to this network and navigate to /config to set up your WiFi credentials and LoRa settings.
HEADER: 15. Privacy & Security Settings
SUBHEADER: Child-Safe Filter
TEXT: When enabled, this filter automatically:
LIST-START
ITEM: Censors profanity in chat messages and file content
ITEM: Blurs images in the Markdown viewer (click-blocked)
ITEM: Masks URLs in text (shows only domain)
ITEM: Clicking images shows an alert instead of viewing
LIST-END
SUBHEADER: Public File Management
TEXT: Controls whether anyone on the network can create, modify, or delete files. When disabled, file operations require admin authentication.