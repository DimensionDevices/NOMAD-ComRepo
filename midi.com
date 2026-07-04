PAGE: MIDI Studio
COLOR: #547540
AUTHOR: NOMAD
DATE: 2025-07-04
CUSTOMHTML-START
<style>:root{--bg:#fdfaf1;--bg-gradient:linear-gradient(145deg,#fdfaf1 0%,#f5f0e1 100%);--surface:rgba(255,255,255,0.65);--border:rgba(84,117,64,0.15);--text:#2c3e2d;--text-dim:#5c6e5d;--accent:#547540;--accent-hover:#456334;--card-bg:rgba(84,117,64,0.05);--stat-val:#1b3012;--danger:#b0413e;--shadow:0 4px 20px rgba(0,0,0,0.08);--radius:10px;--font:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Helvetica,Arial,sans-serif}
*{box-sizing:border-box;margin:0;padding:0;-webkit-tap-highlight-color:transparent;-webkit-user-select:none;user-select:none}
body{font-family:var(--font);background:var(--bg);color:var(--text);line-height:1.5;padding:8px;touch-action:manipulation}
.container{max-width:640px;margin:0 auto;padding:4px}
.header{background:var(--card-bg);border:1px solid var(--border);padding:12px;border-radius:var(--radius);margin-bottom:6px}
.header h1{font-size:1.4rem;font-weight:800}
.subtitle{font-size:.65rem;opacity:.8;margin-top:2px}
.section{background:var(--card-bg);border:1px solid var(--border);border-radius:var(--radius);padding:10px 12px;margin-bottom:6px;overflow:hidden}
summary{font-weight:700;cursor:pointer;user-select:none;list-style:none;display:flex;align-items:center;justify-content:space-between;gap:8px}
summary::-webkit-details-marker{display:none}
summary h2{font-size:1rem;margin:0;flex:1}
.btn{background:var(--accent);color:#fff;border:none;padding:8px 14px;border-radius:8px;font-size:.8rem;font-weight:600;cursor:pointer;transition:.15s;touch-action:manipulation;min-height:44px;display:inline-flex;align-items:center;justify-content:center;gap:4px}
.btn:active{transform:scale(.94)}
.btn-danger{background:var(--danger)}
.btn-success{background:#2e7d32}
.btn-outline{background:var(--surface);color:var(--text);border:1px solid var(--border)}
.btn-sm{font-size:.68rem;padding:6px 10px;min-height:36px}
.btn.active{outline:2px solid var(--accent-hover);outline-offset:-2px}
.grid{display:grid;grid-template-columns:repeat(4,1fr);gap:4px;margin:4px 0}
.stat-card{background:var(--card-bg);padding:5px 4px;border-radius:6px;text-align:center}
.stat-label{font-size:.5rem;text-transform:uppercase;opacity:.7;font-weight:600}
.stat-value{font-size:.75rem;font-weight:700;color:var(--stat-val)}
.piano-roll{height:68vh;overflow-x:auto;margin:6px -4px;padding:4px 0 8px;-webkit-overflow-scrolling:touch;border-radius:8px}
.piano-roll table{font-size:10px;border-collapse:separate;border-spacing:0;width:100%;min-width:520px}
.piano-roll th{padding:3px 2px;border:1px solid #ddd;background:#fff;position:sticky;top:0;z-index:3;font-size:8px;min-width:24px}
.piano-roll th:first-child{left:0;z-index:5}
.piano-roll td{padding:0;border:1px solid #ddd;text-align:center;min-width:24px;height:26px;touch-action:none;cursor:pointer;background:#f9f9f9;font-size:12px;position:relative}
.piano-roll td:first-child,.piano-roll td.pitch-cell{position:sticky;left:0;z-index:2;background:#fff;font-weight:bold;font-size:8px;min-width:34px;cursor:default;touch-action:auto}
.piano-roll tr.black-row td:not(.pitch-cell){background:#f0efe9}
.piano-roll tr.black-row td.note-on{background:var(--accent)}
.piano-roll td.note-on{background:var(--accent);color:#fff}
.piano-roll td.step-col-hl{background:#dcedc8}
.piano-roll th.step-hl{background:#a5d6a7}
.controls{display:flex;flex-wrap:wrap;gap:4px;margin:4px 0}
.controls .btn{flex:1;min-width:60px;font-size:.72rem;padding:6px 8px;min-height:38px}
.slider-group{display:flex;align-items:center;gap:6px;font-size:.72rem;flex-wrap:wrap;margin-top:6px}
.slider-group span.lbl{min-width:44px;opacity:.8}
.slider-group input[type=range]{flex:1;min-width:70px;height:20px;-webkit-appearance:none;appearance:none;background:transparent}
.slider-group input[type=range]::-webkit-slider-runnable-track{height:6px;background:var(--border);border-radius:3px}
.slider-group input[type=range]::-webkit-slider-thumb{-webkit-appearance:none;appearance:none;width:20px;height:20px;border-radius:50%;background:var(--accent);cursor:pointer;margin-top:-7px}
.slider-group select{background:var(--surface);border:1px solid var(--border);border-radius:6px;padding:6px 4px;font-size:.72rem;color:var(--text);min-height:36px}
.slider-group label{display:flex;align-items:center;gap:4px}
.save-list{display:flex;flex-direction:column;gap:4px;margin-top:6px;max-height:150px;overflow-y:auto}
.save-item{display:flex;align-items:center;gap:6px;background:var(--surface);border:1px solid var(--border);border-radius:6px;padding:4px 6px;font-size:.72rem}
.save-item span{flex:1;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.status-overlay{position:fixed;bottom:14px;left:50%;transform:translateX(-50%);background:rgba(0,0,0,.85);color:#fff;padding:10px 20px;border-radius:8px;z-index:999;display:none;text-align:center;font-size:.8rem;max-width:90%;pointer-events:none}
.hidden{display:none!important}
@media(max-width:480px){.grid{grid-template-columns:repeat(4,1fr)}.header h1{font-size:1.1rem}.section{padding:6px 8px}.piano-roll table{font-size:8px;min-width:440px}.piano-roll td{min-width:22px;height:24px}.btn{font-size:.68rem;padding:6px 8px}.controls .btn{font-size:.62rem;min-height:34px}}
</style>
<div class="grid"><div class="stat-card"><div class="stat-label">Notes</div><div class="stat-value" id="noteCount">0</div></div><div class="stat-card"><div class="stat-label">Steps</div><div class="stat-value" id="stepCount">0/16</div></div><div class="stat-card"><div class="stat-label">Tempo</div><div class="stat-value" id="tempoDisplay">120</div></div><div class="stat-card"><div class="stat-label">Octave</div><div class="stat-value" id="octDisplay">4</div></div></div><div class="piano-roll" id="rollContainer"><div style="padding:20px;text-align:center;color:var(--text-dim)">Loading...</div></div><div class="controls" style="margin-top:4px"><button class="btn btn-sm btn-outline" id="backBtn" style="color:#000!important">⏮️ Start</button><button class="btn btn-sm btn-outline" id="undoBtn" style="color:#000!important">↩️ Undo</button><button class="btn btn-sm btn-outline" id="extendBtn" style="color:#000!important">➕ Add 16</button></div><div class="controls"><button class="btn" id="playBtn">▶️ Play</button><button class="btn" id="stopBtn">⏹️ Stop</button><button class="btn btn-danger" id="clearBtn">🗑️ Clear</button><button class="btn btn-success" id="exportBtn">💾 Export .mid</button></div><div class="controls"><button class="btn btn-outline" id="saveAsBtn" style="color:#000!important">💿 Save As...</button></div><div class="slider-group"><span class="lbl">Tempo</span><input type="range" id="tempoSlider" min="40" max="240" value="120"><span id="tempoVal">120</span></div><div class="slider-group"><span class="lbl">Volume</span><input type="range" id="volSlider" min="0" max="100" value="70"><span id="volVal">70</span></div><div class="slider-group"><span class="lbl">Swing</span><input type="range" id="swingSlider" min="0" max="60" value="0"><span id="swingVal">0%</span></div><div class="slider-group"><label><input type="checkbox" id="loopCheck" checked="checked"> Loop</label><select id="instrumentSelect"><option value="0">🎹 Piano</option><option value="1">🎸 Guitar</option><option value="2">🎻 Strings</option><option value="3">🎛️ Synth</option><option value="4">🎸 Bass</option></select></div><div class="save-list" id="saveList"><div style="opacity:.6;font-size:.7rem;padding:4px"></div></div>
<script>
const S={n:[],s:0,p:!1,a:!1,t:120,w:0,l:!0,len:16,c:null,g:null,sy:null,md:null,tmr:null,um:!1,ins:0,oct:4,v:.7,u:[],ht:null,dm:null,dg:!1};
const $=i=>document.getElementById(i);const P=m=>{const o=$('status')||document.querySelector('.status-overlay');if(o){o.textContent=m;o.style.display='block';clearTimeout(o._t);o._t=setTimeout(()=>{o.style.display='none'},2200)}};
const V=[50,90,127];class Synth{constructor(c,m){this.c=c;this.m=m}
play(p,v=90,d=.25){try{const o=this.c.createOscillator(),g=this.c.createGain();const T=['triangle','sawtooth','square','sine','sawtooth'];o.type=T[S.ins%T.length];o.frequency.value=440*Math.pow(2,(p-69)/12);g.gain.setValueAtTime((v/127)*S.v,this.c.currentTime);g.gain.exponentialRampToValueAtTime(.001,this.c.currentTime+d);o.connect(g);g.connect(this.m);o.start();o.stop(this.c.currentTime+d)}catch(e){}}
click(){try{const o=this.c.createOscillator(),g=this.c.createGain();o.type='square';o.frequency.value=1000;g.gain.setValueAtTime(.15*S.v,this.c.currentTime);g.gain.exponentialRampToValueAtTime(.001,this.c.currentTime+.05);o.connect(g);g.connect(this.m);o.start();o.stop(this.c.currentTime+.05)}catch(e){}}}
async function ia(){if(!S.c){S.c=new(window.AudioContext||window.webkitAudioContext)();S.g=S.c.createGain();S.g.gain.value=S.v;S.g.connect(S.c.destination);S.sy=new Synth(S.c,S.g)}if(S.c.state==='suspended')await S.c.resume();return S.c}
function pn(p,v=90,d=.25){if(S.um&&S.md){try{S.md.send([144,p,v]);setTimeout(()=>{S.md.send([128,p,0])},d*1e3)}catch(e){}}else if(S.sy)S.sy.play(p,v,d)}
function pu(){S.u.push(JSON.stringify(S.n));if(S.u.length>20)S.u.shift()}
function un(){if(!S.u.length){P('Nothing to undo');return}S.n=JSON.parse(S.u.pop());r();us();as();P('Undone')}
function an(s,p,v=90,d=.25){pu();S.n=S.n.filter(n=>!(n.s===s&&n.p===p));S.n.push({s,p,v,d});r();us();as()}
function rn(s,p){pu();S.n=S.n.filter(n=>!(n.s===s&&n.p===p));r();us();as()}
function cv(s,p){pu();const n=S.n.find(n=>n.s===s&&n.p===p);if(!n)return;let i=V.indexOf(n.v);i=(i+1)%V.length;n.v=V[i];r();as();P('Velocity: '+['soft','medium','loud'][i])}
function cs(){pu();S.n=[];S.s=0;r();us();P('Cleared');as()}
function es(){S.len=Math.min(S.len+16,64);r();us();P(`Extended to ${S.len} steps`);as()}
function gn(s){return S.n.filter(n=>n.s===s)}
const NN=['C','C#','D','D#','E','F','F#','G','G#','A','A#','B'];const BL=[1,3,6,8,10];
function r(){const c=$('rollContainer');if(!c)return;let t=c.querySelector('table');if(!t){t=document.createElement('table');c.innerHTML='';c.appendChild(t)}
t.innerHTML='';const h=t.createTHead(),rw=h.insertRow();const th=document.createElement('th');th.textContent='Pitch';rw.appendChild(th);
for(let s=0;s<S.len;s++){const th=document.createElement('th');th.textContent=s+1;th.dataset.step=s;rw.appendChild(th)}
const b=t.createTBody();
for(let p=83;p>=55;p--){const row=b.insertRow();if(BL.includes(p%12))row.className='black-row';const nn=NN[p%12]+Math.floor(p/12-1);const pc=document.createElement('td');pc.className='pitch-cell';pc.textContent=nn;row.appendChild(pc);
for(let s=0;s<S.len;s++){const td=document.createElement('td');td.dataset.step=s;td.dataset.pitch=p;const n=S.n.find(n=>n.s===s&&n.p===p);if(n){td.className='note-on';td.style.opacity=(.5+((n.v/127)*.5)).toFixed(2);td.textContent='●'}else td.textContent='';
td.addEventListener('pointerdown',e=>{e.preventDefault();S.dg=!0;const st=parseInt(td.dataset.step),pt=parseInt(td.dataset.pitch);const has=S.n.some(n=>n.s===st&&n.p===pt);S.dm=has?'remove':'add';S.ht=setTimeout(()=>{if(has){cv(st,pt);S.dm=null}},450);if(!has)an(st,pt,90,.25)});
td.addEventListener('pointerenter',()=>{if(!S.dg||!S.dm)return;const st=parseInt(td.dataset.step),pt=parseInt(td.dataset.pitch);const has=S.n.some(n=>n.s===st&&n.p===pt);if(S.dm==='add'&&!has)an(st,pt,90,.25);if(S.dm==='remove'&&has)rn(st,pt)});
td.addEventListener('pointerup',()=>{clearTimeout(S.ht)});row.appendChild(td)}}
document.addEventListener('pointerup',()=>{S.dg=!1;S.dm=null;clearTimeout(S.ht)},{once:!1});hs(-1)}
function hs(s){document.querySelectorAll('.step-hl').forEach(el=>el.classList.remove('step-hl'));document.querySelectorAll('.step-col-hl').forEach(el=>el.classList.remove('step-col-hl'));if(s>=0){document.querySelectorAll(`th[data-step="${s}"]`).forEach(el=>el.classList.add('step-hl'));document.querySelectorAll(`td[data-step="${s}"]`).forEach(el=>{if(!el.classList.contains('note-on'))el.classList.add('step-col-hl')})}}
function us(){const t=S.n.length,u=new Set(S.n.map(n=>n.s)).size;$('noteCount')&&($('noteCount').textContent=t);$('stepCount')&&($('stepCount').textContent=`${u}/${S.len}`);$('octDisplay')&&($('octDisplay').textContent=S.oct)}
function sp(){if(S.p&&!S.a)return pp();if(S.p&&S.a)return rp();if(!S.n.length){P('Add some notes first!');return}ia();S.p=!0;S.a=!1;S.s=0;S._start=performance.now();ps();ub()}
function ps(){if(!S.p||S.a)return;const n=gn(S.s),bd=(60/S.t)*.5;const so=(S.s%2===1)?(S.w/100)*bd:0;n.forEach(nt=>{pn(nt.p,nt.v,nt.d||bd)});hs(S.s);S.s++;if(S.s>=S.len){if(S.l){S.s=0;S._start=performance.now()}else{stp();return}}const now=performance.now(),el=(now-S._start)/1e3;const sd=bd+((S.s%2===0)?so:0);const ex=S.s*bd;const dl=Math.max(0,ex-el);S.tmr=setTimeout(ps,dl*1e3)}
function pp(){if(S.p&&!S.a){S.a=!0;clearTimeout(S.tmr);ub()}}
function rp(){if(S.p&&S.a){S.a=!1;S._start=performance.now();ps();ub()}}
function stp(){S.p=!1;S.a=!1;clearTimeout(S.tmr);S.s=0;if(S.um&&S.md){for(let p=55;p<=83;p++)S.md.send([128,p,0])}hs(-1);ub();us()}
function gt(){stp();S.s=0;hs(-1);P('Reset to start')}
function ub(){const b=$('playBtn');if(!b)return;if(S.p&&!S.a){b.textContent='⏸️ Pause';b.onclick=pp}else if(S.p&&S.a){b.textContent='▶️ Resume';b.onclick=rp}else{b.textContent='▶️ Play';b.onclick=sp}}
function em(){if(!S.n.length){P('No notes to export');return}const hdr=new Uint8Array([77,84,104,100,0,0,0,6,0,1,0,1,0,128]);const td=[];let last=0;S.n.slice().sort((a,b)=>a.s-b.s||a.p-b.p).forEach(n=>{const d=(n.s-last)*32;td.push(d,144,n.p,n.v||90);last=n.s});td.push(0,255,47,0);const tc=[77,84,114,107];const tb=[];td.forEach(v=>{if(v<128){tb.push(v)}else{let x=v;const bts=[];do{let y=x&127;x>>=7;if(x>0)y|=128;bts.push(y)}while(x>0);tb.push(...bts)}});const len=tb.length;tc.push(len>>24&255,len>>16&255,len>>8&255,len&255);tc.push(...tb);const data=new Uint8Array([...hdr,...tc]);const blob=new Blob([data],{type:'audio/midi'}),url=URL.createObjectURL(blob),a=document.createElement('a');a.href=url;a.download='composition.mid';document.body.appendChild(a);a.click();document.body.removeChild(a);URL.revokeObjectURL(url);P('Exported!')}
function as(){try{const data={notes:S.n,length:S.len,tempo:S.t,loop:S.l,instrument:S.ins,swing:S.w,volume:S.v};localStorage.setItem('midi_composer_data',JSON.stringify(data))}catch(e){}}
function las(){try{const raw=localStorage.getItem('midi_composer_data');if(raw){const data=JSON.parse(raw);if(data.notes){S.n=data.notes;S.len=data.length||16;S.t=data.tempo||120;S.l=data.loop!==undefined?data.loop:!0;S.ins=data.instrument||0;S.w=data.swing||0;S.v=data.volume!==undefined?data.volume:.7;$('tempoSlider').value=S.t;$('tempoVal').textContent=S.t;$('tempoDisplay').textContent=S.t;$('loopCheck').checked=S.l;$('instrumentSelect').value=S.ins;$('swingSlider').value=S.w;$('swingVal').textContent=S.w+'%';$('volSlider').value=Math.round(S.v*100);$('volVal').textContent=Math.round(S.v*100);if(S.g)S.g.gain.value=S.v}}}catch(e){}}
function sn(name){try{const key='midi_saves';const raw=localStorage.getItem(key);const all=raw?JSON.parse(raw):{};all[name]={notes:S.n,length:S.len,tempo:S.t,instrument:S.ins,swing:S.w};localStorage.setItem(key,JSON.stringify(all));rsl();P('Saved "'+name+'"')}catch(e){P('Save failed')}}
function ln(name){try{const raw=localStorage.getItem('midi_saves');const all=raw?JSON.parse(raw):{};if(all[name]){pu();const d=all[name];S.n=d.notes;S.len=d.length;S.t=d.tempo;S.ins=d.instrument;S.w=d.swing||0;$('tempoSlider').value=S.t;$('tempoVal').textContent=S.t;$('tempoDisplay').textContent=S.t;$('instrumentSelect').value=S.ins;$('swingSlider').value=S.w;$('swingVal').textContent=S.w+'%';r();us();as();P('Loaded "'+name+'"')}}catch(e){}}
function rsl(){const el=$('saveList');if(!el)return;try{const raw=localStorage.getItem('midi_saves');const all=raw?JSON.parse(raw):{};const names=Object.keys(all);if(!names.length){el.innerHTML='<div style="opacity:.6;font-size:.7rem;padding:4px">No saved compositions yet</div>';return}el.innerHTML='';names.forEach(name=>{const row=document.createElement('div');row.className='save-item';const span=document.createElement('span');span.textContent=name;const lb=document.createElement('button');lb.className='btn btn-sm btn-outline';lb.textContent='Load';lb.onclick=()=>ln(name);const db=document.createElement('button');db.className='btn btn-sm btn-danger';db.textContent='✕';db.onclick=()=>{try{const raw=localStorage.getItem('midi_saves');const all=raw?JSON.parse(raw):{};delete all[name];localStorage.setItem('midi_saves',JSON.stringify(all));rsl();P('Deleted "'+name+'"')}catch(e){}};row.appendChild(span);row.appendChild(lb);row.appendChild(db);el.appendChild(row)})}catch(e){}}
function ui(){if(!$('status')){const o=document.createElement('div');o.className='status-overlay';o.id='status';document.body.appendChild(o)}
$('tempoSlider')?.addEventListener('input',function(){S.t=parseInt(this.value);$('tempoVal').textContent=this.value;$('tempoDisplay').textContent=this.value;as()});
$('volSlider')?.addEventListener('input',function(){S.v=parseInt(this.value)/100;$('volVal').textContent=this.value;if(S.g)S.g.gain.value=S.v;as()});
$('swingSlider')?.addEventListener('input',function(){S.w=parseInt(this.value);$('swingVal').textContent=this.value+'%';as()});
$('loopCheck')?.addEventListener('change',function(){S.l=this.checked;as()});
$('instrumentSelect')?.addEventListener('change',function(){S.ins=parseInt(this.value);as()});
$('clearBtn')?.addEventListener('click',cs);$('exportBtn')?.addEventListener('click',em);
$('stopBtn')?.addEventListener('click',stp);$('backBtn')?.addEventListener('click',gt);
$('undoBtn')?.addEventListener('click',un);$('extendBtn')?.addEventListener('click',es);
$('saveAsBtn')?.addEventListener('click',()=>{const name=prompt('Name this composition:');if(name&&name.trim())sn(name.trim())});
$('playBtn')?.addEventListener('click',function(){if(S.p&&!S.a){pp()}else if(S.p&&S.a){rp()}else{sp()}});
document.addEventListener('keydown',e=>{if(e.target.tagName==='INPUT'||e.target.tagName==='TEXTAREA')return;if(e.key===' '){e.preventDefault();if(S.p&&!S.a)pp();else if(S.p&&S.a)rp();else sp();return}if(e.key==='z'){S.oct=Math.max(S.oct-1,1);us();return}if(e.key==='x'){S.oct=Math.min(S.oct+1,7);us();return}const map={a:0,w:1,s:2,e:3,d:4,f:5,t:6,g:7,y:8,h:9,u:10,j:11,k:12,l:13};if(e.key in map){e.preventDefault();ia();const pt=S.oct*12+map[e.key]+12;if(pt<55||pt>83)return;const st=S.s%S.len;an(st,pt,90,.25)}});
las();rsl();r();us();ub();P('Ready! Tap or drag cells to compose')}
document.addEventListener('DOMContentLoaded',()=>{ia();ui()});</script>
CUSTOMHTML-END