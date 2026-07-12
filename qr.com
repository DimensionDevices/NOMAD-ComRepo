PAGE: 100-Char QR Code Generator
COLOR: #547540
AUTHOR: DimensionDevices
DATE: 2026-06-25

CUSTOMHTML-START
<div class="qrapp">
  <h1>QR Code Generator</h1>
  <div class="row"><input id=t placeholder="Enter up to 100 characters..."><button id=g>Go</button></div>
  <div id=e class="err"></div>
  <div class="box"><canvas id=c width="290" height="290"></canvas></div>
  <div class="row"><button id=d disabled>Download</button><button id=x>Clear</button></div>
</div>

<style>
.qrapp{font:14px system-ui;max-width:420px;margin:0 auto;background:#fff;border:1px solid #ddd;border-radius:16px;padding:16px}
.sub{margin:4px 0 12px;color:#666}
.row{display:flex;gap:8px;margin:8px 0}
.row>*{flex:1;padding:10px 12px;border:1px solid #ccc;border-radius:10px}
.row button{background:#547540;color:#fff;border:0;cursor:pointer}
.row button:disabled{opacity:.5;cursor:not-allowed}
.box{background:#fafafa;border:1px dashed #ddd;border-radius:14px;padding:10px;display:flex;justify-content:center}
.err{color:#c33;min-height:1.2em;font-size:13px}
canvas{image-rendering:pixelated;max-width:100%;height:auto}
</style>

<script>
(()=>{const t=document.getElementById("t"),e=document.getElementById("g"),l=document.getElementById("x"),r=document.getElementById("d"),n=document.getElementById("e"),o=document.getElementById("c"),f=o.getContext("2d"),c=21,h=(()=>{let t=new Uint8Array(512),e=new Uint8Array(256),l=1;for(let r=0;r<255;r++)t[r]=l,e[l]=r,l<<=1,256&l&&(l^=285);for(let e=255;e<512;e++)t[e]=t[e-255];return{e:t,l:e,m:(l,r)=>l&&r?t[e[l]+e[r]]:0}})();function i(t,e){let l=[];for(let r=e-1;r>=0;r--)l.push(t>>r&1);return l}function a(t,e){let l=function(t){let e=[1];for(let l=0;l<t;l++){let t=[1,h.e[l]],r=Array(e.length+t.length-1).fill(0);for(let l=0;l<e.length;l++)for(let n=0;n<t.length;n++)r[l+n]^=h.m(e[l],t[n]);e=r}return e}(e),r=t.slice().concat(Array(e).fill(0));for(let e=0;e<t.length;e++){let t=r[e];if(t)for(let n=0;n<l.length;n++)r[e+n]^=h.m(l[n],t)}return t.concat(r.slice(t.length))}function u(t){if(!(t=t.toUpperCase().trim()))throw Error("Enter text");let e=function(t){let e=[];for(let l of t){let t="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ $%*+-./:".indexOf(l);if(t<0)throw Error("Use only alphanumeric characters");e.push(t)}return e}(t);if(e.length>20)throw Error("Version 1-M supports max 20 alphanumeric chars");let l=[];l.push(...i(2,4)),l.push(...i(e.length,9));for(let t=0;t<e.length;t+=2)t+1<e.length?l.push(...i(45*e[t]+e[t+1],11)):l.push(...i(e[t],6));let r=128-l.length;for(l.push(...Array(Math.min(4,r)).fill(0));l.length%8;)l.push(0);let n=0;for(;l.length<128;)l.push(...i(n?17:236,8)),n^=1;let o=[];for(let t=0;t<l.length;t+=8)o.push(parseInt(l.slice(t,t+8).join(""),2));let f=a(o,10),h=[];for(let t of f)h.push(...i(t,8));let u=Array.from({length:c},()=>Array(c).fill(0)),g=Array.from({length:c},()=>Array(c).fill(0));const s=(t,e,l)=>{u[t][e]=l,g[t][e]=1};function d(t,e){for(let l=-1;l<=7;l++)for(let r=-1;r<=7;r++){let n=t+l,o=e+r;n<0||o<0||n>=c||o>=c||(-1!==l&&7!==l&&-1!==r&&7!==r||s(n,o,0))}for(let l=0;l<7;l++)for(let r=0;r<7;r++){s(t+l,e+r,0===l||6===l||0===r||6===r||l>=2&&l<=4&&r>=2&&r<=4?1:0)}}d(0,0),d(0,14),d(14,0);for(let t=8;t<=12;t++)s(6,t,t%2==0?1:0),s(t,6,t%2==0?1:0);s(13,8,1);const m=function(t){let e=t<<10;for(let t=14;t>=10;t--)e>>t&1&&(e^=1335<<t-10);return e|=t<<10,e^=21522,i(e,15)}(0),y=[[8,0],[8,1],[8,2],[8,3],[8,4],[8,5],[8,7],[8,8],[7,8],[5,8],[4,8],[3,8],[2,8],[1,8],[0,8]],p=[[20,8],[19,8],[18,8],[17,8],[16,8],[15,8],[14,8],[8,13],[8,14],[8,15],[8,16],[8,17],[8,18],[8,19],[8,20]];for(let t=0;t<15;t++)s(y[t][0],y[t][1],m[t]),s(p[t][0],p[t][1],m[t]);let A=0,E=!0;for(let t=20;t>0;t-=2){6===t&&t--;for(let e=0;e<c;e++){let l=E?20-e:e;for(let e=0;e<2;e++){let r=t-e;g[l][r]||(u[l][r]=A<h.length?h[A++]:0)}}E=!E}for(let t=0;t<c;t++)for(let e=0;e<c;e++)g[t][e]||e+t&1||(u[t][e]^=1);return u}function g(t){o.width=o.height=290,f.fillStyle="#fff",f.fillRect(0,0,290,290),f.fillStyle="#000";for(let e=0;e<c;e++)for(let l=0;l<c;l++)t[e][l]&&f.fillRect(10*(l+4),10*(e+4),10,10)}e.onclick=()=>{if(t.value.length<1||t.value.length>100){n.textContent="Error: Enter 1-100 alphanumeric characters!";r.disabled=!0;return}try{g(u(t.value)),r.disabled=!1,n.textContent=""}catch(t){n.textContent=t.message,r.disabled=!0}},l.onclick=()=>{t.value="",f.clearRect(0,0,o.width,o.height),r.disabled=!0,n.textContent=""},r.onclick=()=>{let t=document.createElement("a");t.download="qrcode.png",t.href=o.toDataURL("image/png"),t.click()},g(Array.from({length:c},()=>Array(c).fill(0)))})();
</script>
CUSTOMHTML-END
