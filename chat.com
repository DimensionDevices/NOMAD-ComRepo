CUSTOMHTML-START
<style type="text/css">
:root{--bg:#fdfaf1;--bg-gradient:linear-gradient(145deg, #fdfaf1 0%, #f5f0e1 100%);--surface:rgba(255, 255, 255, 0.85);--border:rgba(84, 117, 64, 0.12);--text:#2c3e2d;--text-dim:#5c6e5d;--accent:#547540;--accent-hover:#456334;--card-bg:rgba(84, 117, 64, 0.06);--stat-val:#1b3012;--danger:#b0413e;--shadow:0 2px 20px rgba(0,0,0,0.06);--radius:16px;--safe-bottom:env(safe-area-inset-bottom, 0px)}*{margin:0;padding:0;box-sizing:border-box;-webkit-tap-highlight-color:#fff0}body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Oxygen,Ubuntu,sans-serif;background:var(--bg-gradient);color:var(--text);height:100vh;height:100dvh;overflow:hidden;display:flex;flex-direction:column;user-select:none;padding:0!important}.app{display:flex;flex-direction:column;height:100vh;height:100dvh;max-width:100%;position:relative;background:var(--surface);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px)}.header{display:flex;align-items:center;justify-content:space-between;padding:12px 16px;padding-top:max(12px, env(safe-area-inset-top));background:var(--surface);border-bottom:1px solid var(--border);flex-shrink:0;z-index:10;min-height:56px}.header-title{font-size:18px;font-weight:700;letter-spacing:-.3px;background:linear-gradient(135deg,var(--accent),var(--stat-val));-webkit-background-clip:text;-webkit-text-fill-color:#fff0;background-clip:text}.header-actions{margin-right:15%;display:flex;align-items:center;gap:12px}.header-btn{background:var(--card-bg);border:1px solid var(--border);border-radius:10px;padding:6px 12px;font-size:13px;color:var(--text);cursor:pointer;display:flex;align-items:center;gap:4px;transition:all 0.2s ease;font-weight:500}.header-btn:active{transform:scale(.95)}.header-btn .badge{background:var(--accent);color:#fff;border-radius:50%;padding:0 6px;font-size:10px;font-weight:700;min-width:18px;text-align:center;line-height:18px}.status-dot-header{width:8px;height:8px;border-radius:50%;display:inline-block;margin-right:2px}.status-dot-header.online{background:#4CAF50}.status-dot-header.connecting{background:#FFA726;animation:pulse 1s infinite}.status-dot-header.offline{background:var(--danger)}@keyframes pulse{0%,100%{opacity:1}50%{opacity:.3}}.chat-area{flex:1;display:flex;flex-direction:column;overflow:hidden;position:relative}#chat{flex:1;overflow-y:auto;padding:12px 16px;padding-bottom:4px;-webkit-overflow-scrolling:touch}#chat::-webkit-scrollbar{width:4px}#chat::-webkit-scrollbar-track{background:#fff0}#chat::-webkit-scrollbar-thumb{background:var(--border);border-radius:10px}.msg{margin:2px 0;padding:6px 12px;border-radius:12px;background:rgb(255 255 255 / .5);border:1px solid var(--border);animation:fadeIn 0.25s ease;max-width:100%}.msg.own{background:var(--card-bg);border-color:var(--accent)}@keyframes fadeIn{from{opacity:0;transform:translateY(-6px)}to{opacity:1;transform:translateY(0)}}.msg-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:2px;gap:8px}.nick{font-weight:600;color:var(--accent);font-size:13px;flex-shrink:0}.time{color:var(--text-dim);font-size:10px;opacity:.6;flex-shrink:0}.msg-text{color:var(--text);font-size:14px;line-height:1.4;word-wrap:break-word;overflow-wrap:break-word}.msg-text a{color:var(--accent);text-decoration:underline;cursor:pointer;word-break:break-all;transition:all 0.15s ease;position:relative}.msg-text a:hover{color:var(--accent-hover);opacity:0.8}.msg-text a:active{transform:scale(0.98)}.msg-text a::after{content:" 📋";font-size:11px;opacity:0.6;display:inline-block;transition:opacity 0.2s}.msg-text a:hover::after{opacity:1}.toast{position:fixed;bottom:80px;left:50%;transform:translateX(-50%) translateY(20px);background:var(--accent);color:#fff;padding:8px 20px;border-radius:12px;font-size:13px;font-weight:500;box-shadow:0 4px 20px rgba(0,0,0,0.15);opacity:0;transition:all 0.3s ease;z-index:100;pointer-events:none;white-space:nowrap}.toast.show{opacity:1;transform:translateX(-50%) translateY(0)}.input-area{display:flex;gap:8px;align-items:center;padding:8px 12px;padding-bottom:calc(8px + var(--safe-bottom));background:var(--surface);border-top:1px solid var(--border);flex-shrink:0}.input-wrapper{flex:1;display:flex;gap:8px;background:var(--card-bg);border:1px solid var(--border);border-radius:12px;padding:4px;transition:all 0.2s ease}.input-wrapper:focus-within{border-color:var(--accent);box-shadow:0 0 0 3px rgb(84 117 64 / .1)}#nick-input{padding:8px 10px;border:none;border-radius:10px;background:#fff0;color:var(--text);font-size:13px;width:80px;outline:none;min-width:60px}#nick-input::placeholder{color:var(--text-dim);opacity:.5}#message-input{flex:1;padding:8px 4px;border:none;background:#fff0;color:var(--text);font-size:14px;outline:none;min-width:0}#message-input::placeholder{color:var(--text-dim);opacity:.5}.send-btn{padding:8px 16px;background:var(--accent);color:#fff;border:none;border-radius:10px;font-size:14px;font-weight:600;cursor:pointer;transition:all 0.15s ease;white-space:nowrap;min-height:38px}.send-btn:active{transform:scale(.94);background:var(--accent-hover)}.panel-overlay{position:fixed;top:0;left:0;width:100%;height:100%;background:rgb(0 0 0 / .3);z-index:50;opacity:0;pointer-events:none;transition:opacity 0.3s ease}.panel-overlay.active{opacity:1;pointer-events:all}.users-panel{position:fixed;top:0;right:-320px;width:300px;max-width:85vw;height:100%;background:var(--surface);backdrop-filter:blur(30px);-webkit-backdrop-filter:blur(30px);z-index:51;transition:right 0.35s cubic-bezier(.22,1,.36,1);padding:20px 16px;padding-top:max(20px, env(safe-area-inset-top));display:flex;flex-direction:column;box-shadow:-4px 0 30px rgb(0 0 0 / .1)}.users-panel.open{right:0}.panel-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;padding-bottom:12px;border-bottom:2px solid var(--border)}.panel-header h2{font-size:18px;font-weight:600}#panel-user-list{flex:1;overflow-y:auto;-webkit-overflow-scrolling:touch}#panel-user-list::-webkit-scrollbar{width:4px}#panel-user-list::-webkit-scrollbar-thumb{background:var(--border);border-radius:10px}.panel-user-item{display:flex;align-items:center;gap:10px;padding:10px 12px;border-radius:10px;margin:2px 0;transition:all 0.15s ease}.panel-user-item:active{background:var(--card-bg)}.panel-user-dot{width:8px;height:8px;border-radius:50%;background:#4CAF50;flex-shrink:0}.panel-user-name{font-size:14px;color:var(--text)}.panel-empty{color:var(--text-dim);text-align:center;padding:30px 0;font-size:14px}.status-bar{display:flex;justify-content:space-between;align-items:center;padding:4px 16px;padding-bottom:calc(4px + var(--safe-bottom));background:var(--surface);border-top:1px solid var(--border);flex-shrink:0;min-height:28px}.status-text{font-size:11px;color:var(--text-dim);display:flex;align-items:center;gap:6px}.status-text .dot{width:6px;height:6px;border-radius:50%;display:inline-block}.status-text .dot.green{background:#4CAF50}.status-text .dot.orange{background:#FFA726}.status-text .dot.red{background:var(--danger)}.typing-indicator{font-size:11px;color:var(--text-dim);font-style:italic}@supports (padding:max(0px)){.header{padding-top:max(12px, env(safe-area-inset-top))}.users-panel{padding-top:max(20px, env(safe-area-inset-top))}.input-area{padding-bottom:calc(8px + env(safe-area-inset-bottom))}.status-bar{padding-bottom:calc(4px + env(safe-area-inset-bottom))}}@media (max-width:480px){.header-title{font-size:16px}.header-btn{font-size:12px;padding:4px 10px}.header-btn .badge{font-size:9px;min-width:16px;line-height:16px}#nick-input{width:60px;font-size:12px}#message-input{font-size:13px}.send-btn{font-size:13px;padding:6px 14px;min-height:34px}.msg{padding:5px 10px}.nick{font-size:12px}.msg-text{font-size:13px}.users-panel{width:280px}.toast{font-size:12px;padding:6px 16px;bottom:70px}}@media (max-width:380px){.header-title{font-size:14px}#nick-input{width:50px;font-size:11px}.send-btn{font-size:12px;padding:6px 10px}}
</style>

<div class="app"><div class="header"><div class="header-title">NOMAD Internet WebChat</div><div class="header-actions"><button class="header-btn" onclick="togglePanel()">👥<span class="badge" id="header-badge">0</span></button></button></div></div><div class="chat-area"><div id="chat"></div><div class="input-area"><div class="input-wrapper"><input type="text" id="nick-input" placeholder="Nick" maxlength="20"> <input type="text" id="message-input" autocomplete="off" placeholder="Message..." autofocus></div><button class="send-btn" onclick="sendMessage()">➤</button></div></div><div class="status-bar"><div class="status-text"><span class="dot green" id="status-dot"></span><span id="status-message">Connected</span></div><div class="typing-indicator" id="typing-indicator"></div></div></div><div class="panel-overlay" id="panel-overlay" onclick="togglePanel()"></div><div class="users-panel" id="users-panel"><div class="panel-header"><h2>👥 Online</h2></div><div id="panel-user-list"><div class="panel-empty">Loading...</div></div></div>

<!-- Toast Notification -->
<div class="toast" id="toast"></div>

<script>
// Global variables
let heartbeatInterval;
let nodeName = "n/a";
let nodeIP = "n/a";
let nick = "Guest";
let lastTimestamp = 0;
let polling = true;
let reconnectAttempts = 0;
let panelOpen = false;
const MAX_RECONNECT = 10;
const API_URL = "https://dimensiondevices.co.uk/nomadcomms/index.php";
const API_KEY = "Dimension350d9f1fe3a835Devices"; // CHANGE THIS - Must match index.php

// DOM elements
const chatDiv = document.getElementById("chat");
const msgInput = document.getElementById("message-input");
const nickInput = document.getElementById("nick-input");
const userListDiv = document.getElementById("panel-user-list");
const headerBadge = document.getElementById("header-badge");
const statusDot = document.getElementById("status-dot");
const statusMessage = document.getElementById("status-message");
const typingIndicator = document.getElementById("typing-indicator");
const panelOverlay = document.getElementById("panel-overlay");
const usersPanel = document.getElementById("users-panel");
const toast = document.getElementById("toast");

// Helper functions
function escapeHtml(e) {
    const t = document.createElement("div");
    t.textContent = e;
    return t.innerHTML;
}

function formatTime(e) {
    return e ? new Date(1e3 * e).toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" }) : "";
}

function setStatus(e, t) {
    const n = { online: "green", connecting: "orange", offline: "red" }[e] || "red";
    statusDot.className = `dot ${n}`;
    statusMessage.innerHTML = t || e;
}

function togglePanel() {
    panelOpen = !panelOpen;
    usersPanel.classList.toggle("open", panelOpen);
    panelOverlay.classList.toggle("active", panelOpen);
    document.body.style.overflow = panelOpen ? "hidden" : "";
}

function showToast(e) {
    toast.textContent = e;
    toast.classList.add("show");
    clearTimeout(toast._timeout);
    toast._timeout = setTimeout(() => {
        toast.classList.remove("show");
    }, 2500);
}

function copyToClipboard(e) {
    if (navigator.clipboard && navigator.clipboard.writeText) {
        return navigator.clipboard.writeText(e).then(() => {
            showToast("✅ Link copied!");
            return true;
        }).catch(() => false);
    }
    const t = document.createElement("textarea");
    t.value = e;
    t.style.position = "fixed";
    t.style.opacity = "0";
    document.body.appendChild(t);
    t.select();
    try {
        const n = document.execCommand("copy");
        document.body.removeChild(t);
        if (n) {
            showToast("✅ Link copied!");
            return true;
        } else {
            showToast("❌ Failed to copy");
            return false;
        }
    } catch (n) {
        document.body.removeChild(t);
        showToast("❌ Failed to copy");
        return false;
    }
}

function handleLinkClick(e) {
    const t = e.target.closest("a");
    if (t) {
        e.preventDefault();
        const n = t.getAttribute("href");
        if (n) copyToClipboard(n);
    }
}

function addMessageToChat(e, t, n, s, node) {
    const a = document.createElement("div");
    a.className = "msg" + (s ? " own" : "");
    
    // Format the nickname with node tag
    let nickDisplay = escapeHtml(e);
    if (node && node !== "n/a" && node !== "") {
        nickDisplay += `<span style="color: var(--text-dim); font-weight: 400; font-size: 11px; margin-left: 6px; background: var(--card-bg); padding: 1px 8px; border-radius: 10px; border: 1px solid var(--border);">@${escapeHtml(node)}</span>`;
    }
    
    a.innerHTML = `
        <div class="msg-header">
            <span class="nick">${nickDisplay}</span>
            <span class="time">${formatTime(n)}</span>
        </div>
        <div class="msg-text">${t}</div>
    `;
    const o = a.querySelector(".msg-text");
    if (o) o.addEventListener("click", handleLinkClick);
    chatDiv.appendChild(a);
    chatDiv.scrollTop = chatDiv.scrollHeight;
}

async function sendMessage() {
    const e = msgInput.value.trim();
    if (e) {
        nick = nickInput.value.trim() || "Guest";
        try {
            const t = new FormData();
            t.append("nick", nick);
            t.append("text", e);
            t.append("api_key", API_KEY);
            if (nodeName && nodeName !== "n/a") {
                t.append("node", nodeName);
            }
            const n = await fetch(`${API_URL}?action=send&api_key=${API_KEY}`, {
                method: "POST",
                body: t
            });
            const response = await n.json();
            if (response.success) {
                msgInput.value = "";
                msgInput.focus();
                if (response.warning) {
                    showToast(response.warning);
                }
            } else {
                setStatus("offline", "Error");
                showToast(response.error || "Failed to send message");
                setTimeout(() => setStatus("online", "Connected to DimensionDevices WebChat server"), 2000);
            }
        } catch (e) {
            console.error('Send error:', e);
            setStatus("offline", "Error");
            setTimeout(() => setStatus("online", "Connected to DimensionDevices WebChat server"), 2000);
        }
    }
}

async function poll() {
    if (polling) {
        try {
            const t = `${API_URL}?action=poll&last=${lastTimestamp}&nick=${encodeURIComponent(nick)}&api_key=${API_KEY}`;
            const e = await fetch(t);
            const n = await e.json();
            if (n.messages && n.messages.length > 0) {
                n.messages.forEach(t => {
                    const e = t.nick === nick;
                    addMessageToChat(t.nick, t.text, t.time, e, t.node || '');
                    if (t.time > lastTimestamp) {
                        lastTimestamp = t.time;
                    }
                });
            }
            setStatus("online", "Connected to DimensionDevices WebChat server");
            reconnectAttempts = 0;
        } catch (t) {
            if (reconnectAttempts++, reconnectAttempts >= MAX_RECONNECT) {
                return void setStatus("offline", "Disconnected");
            }
            setStatus("connecting", "Reconnecting...");
            await new Promise(t => setTimeout(t, Math.min(2000 * reconnectAttempts, 10000)));
        }
        setTimeout(poll, 100);
    }
}

async function updateUsers() {
    try {
        const e = await fetch(`${API_URL}?action=users&api_key=${API_KEY}`);
        const t = await e.json();
        if (t.users) {
            const e = t.users.length;
            headerBadge.textContent = e;
            userListDiv.innerHTML = 0 === e ? '<div class="panel-empty">No one online</div>' : t.users.map(e => 
                `<div class="panel-user-item">
                    <span class="panel-user-dot"></span>
                    <span class="panel-user-name">${escapeHtml(e)}</span>
                </div>`
            ).join("");
        }
    } catch (e) {}
    setTimeout(updateUsers, 5000);
}

async function loadHistory() {
    try {
        const e = await fetch(`${API_URL}?action=history&api_key=${API_KEY}`);
        const t = await e.json();
        if (t.messages) {
            chatDiv.innerHTML = "";
            t.messages.forEach(e => {
                const t = e.nick === nick;
                addMessageToChat(e.nick, e.text, e.time, t, e.node || '');
                if (e.time > lastTimestamp) {
                    lastTimestamp = e.time;
                }
            });
            chatDiv.scrollTop = chatDiv.scrollHeight;
        }
    } catch (e) {
        console.error('History error:', e);
        setStatus("offline", "History error");
    }
}

function toggleStatus() {
    const e = ["online", "connecting", "offline"];
    const n = e[(e.indexOf(t) + 1) % e.length];
    setStatus(n, n.charAt(0).toUpperCase() + n.slice(1));
}

function startHeartbeat() {
    sendHeartbeat();
    heartbeatInterval = setInterval(sendHeartbeat, 10000);
}

async function sendHeartbeat() {
    try {
        let url = `${API_URL}?action=poll&last=${lastTimestamp}&nick=${encodeURIComponent(nick)}&api_key=${API_KEY}`;
        if (nodeName && nodeName !== "n/a") {
            url += `&node=${encodeURIComponent(nodeName)}`;
        }
        await fetch(url);
    } catch (t) {
        // Silent fail for heartbeat
    }
}

async function init() {
    setStatus("connecting", "Loading node info...");
    
    // Wait for node info to be fetched
    try {
        const response = await fetch('/api/status');
        const data = await response.json();
        nodeName = data.nodeId || "n/a";
        nodeIP = data.staIP || "n/a";
    } catch (error) {
        console.error('Error fetching node info:', error);
        nodeName = "n/a";
        nodeIP = "n/a";
    }
    
    setStatus("connecting", "Connecting...");
    
    await loadHistory();
    nick = nickInput.value.trim() || "Guest";
    poll();
    updateUsers();
    startHeartbeat();
    setStatus("online", "Connected to DimensionDevices WebChat server");
    msgInput.focus();
}

// Event listeners
msgInput.addEventListener("input", function() {
    if (this.value.length > 0) {
        typingIndicator.textContent = "✏️ Typing...";
        //clearTimeout(typingTimeout);
        //typingTimeout = setTimeout(() => {
        //    typingIndicator.textContent = "";
        //}, 1500);
    } else {
        typingIndicator.textContent = "";
    }
});

msgInput.addEventListener("keypress", function(e) {
    if ("Enter" === e.key) {
        e.preventDefault();
        sendMessage();
    }
});

nickInput.addEventListener("change", function() {
    nick = this.value.trim() || "Guest";
    setStatus("online", `Nick: ${nick}`);
    setTimeout(() => setStatus("online", "Connected to DimensionDevices WebChat server"), 1500);
});

document.addEventListener("click", function(e) {
    if (!e.target.closest(".input-area") && !e.target.closest(".header-btn")) {
        msgInput.focus();
    }
});

document.addEventListener("visibilitychange", () => {
    if (!document.hidden) {
        setStatus("online", "Connected to DimensionDevices WebChat server");
    }
});

// Start the app
init();
</script>
CUSTOMHTML-END