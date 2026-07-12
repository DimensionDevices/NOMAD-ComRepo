PAGE: TAP_FARMER
COLOR: #f59e0b
AUTHOR: DimensionDevices
DATE: 2026-06-02
CUSTOMHTML-START
<h1 style="text-align:center">Tap Farmer</h1> <style>body{color:white;padding:0 !important}.tapper-container{max-width:1200px;margin:0 auto;padding:16px}.tapper-grid{display:grid;grid-template-columns:1fr 1fr;gap:24px}@media(max-width:700px){.tapper-grid{grid-template-columns:1fr}}.tapper-stats-card{background:linear-gradient(135deg,#2d2d44,#1a1a2e);border-radius:24px;padding:20px;text-align:center;margin-bottom:16px}.tapper-stats{font-size:1.8rem;font-weight:bold;color:#facc15}.tapper-stats small{font-size:0.9rem;color:#a0a0c0}.tapper-button-wrap{text-align:center;margin:20px 0}.tapper-main-btn{background:linear-gradient(145deg,#f59e0b,#d97706);border:none;width:200px;height:200px;border-radius:999px;font-size:5rem;cursor:pointer;box-shadow:0 12px 30px rgba(0,0,0,0.3);transition:transform 0.05s linear;touch-action:manipulation}.tapper-main-btn:active{transform:scale(0.94)}.tapper-upgrades{background:#1e1e2e;border-radius:24px;padding:20px}.tapper-upgrades h3{margin:0 0 16px 0;color:#facc15;font-size:1.3rem}.upgrade-grid{display:flex;flex-direction:column;gap:10px;padding-right:8px}.upgrade-card{background:#2d2d44;border-radius:16px;padding:12px 16px;cursor:pointer;transition:all 0.08s linear;border:1px solid #3d3d5c}.upgrade-card:active{transform:scale(0.98);background:#3d3d5c}.upgrade-card.affordable{border-color:#facc15;box-shadow:0 0 8px rgba(250,204,21,0.3)}.upgrade-name{font-size:1rem;font-weight:bold;color:#fff;display:flex;justify-content:space-between;align-items:center}.upgrade-desc{font-size:0.7rem;color:#a0a0c0;margin-top:4px}.upgrade-cost{color:#facc15;font-weight:bold;font-size:0.85rem}.upgrade-owned{color:#4ade80;font-size:0.75rem}.tapper-reset-btn{background:#7f1d1d;color:#fecaca;text-align:center;padding:14px;border-radius:16px;margin-top:16px;cursor:pointer;font-weight:bold}.tapper-msg{text-align:center;font-size:0.9rem;min-height:40px;color:#facc15;margin:12px 0;padding:8px;background:#1e1e2e;border-radius:16px}.progress-container{background:#1e1e2e;border-radius:40px;height:20px;margin:12px 0;overflow:hidden}.progress-bar{background:linear-gradient(90deg,#facc15,#f59e0b);width:0%;height:100%;border-radius:40px;transition:width 0.1s ease;display:flex;align-items:center;justify-content:center;font-size:0.7rem;font-weight:bold;color:#1a1a2e}.perks-section{background:#1e1e2e;border-radius:24px;padding:20px;margin-top:20px}.perks-section h3{margin:0 0 12px 0;color:#facc15}.perk-badge{display:inline-block;background:#2d2d44;padding:6px 12px;border-radius:20px;font-size:0.75rem;margin:4px}</style> <div class="tapper-container"> <div class="tapper-grid"> <div> <div class="tapper-stats-card"> <div class="tapper-stats" id="tapStats_8x7k2m">🌽 0 crops</div> <div class="progress-container"> <div class="progress-bar" id="tapProgressBar">0%</div> </div> <div style="display:flex;justify-content:space-between;margin-top:12px;gap:12px"> <div><small>💪 per tap</small><br><strong id="tapPowerStat">1</strong></div> <div><small>🌿 per second</small><br><strong id="tapPassiveStat">0</strong></div> <div><small>⭐ critical chance</small><br><strong id="tapCritStat">0%</strong></div> </div> </div> <div class="tapper-button-wrap"> <button id="tapBtn_9w3r5t" class="tapper-main-btn">🌾</button> </div> <div class="tapper-msg" id="tapMsg_2p5r7s">Let's go...!</div> </div> <div class="tapper-upgrades"> <h3>📈 UPGRADES</h3> <div class="upgrade-grid" id="tapUpgrades_4h6j8k"></div> </div> </div> <div class="perks-section" id="perksSection" style="display:none"> <h3>🌟 PRESTIGE PERKS</h3> <div id="perksList"></div> </div> </div>
CUSTOMHTML-END
SCRIPT-START
(function(){
let crops = 0;
let clickPower = 1;
let passiveIncome = 0;
let criticalChance = 0;
let criticalMultiplier = 2;
let totalCropsEarned = 0;
let prestigeLevel = 0;
let prestigePoints = 0;
let lastTimestamp = Date.now();
let upgrades = {
strongerTap: { level: 0, owned: 0, baseCost: 10, multiplier: 1.5, effect: () => clickPower++, desc: "+1 per tap" },
megaTap: { level: 0, owned: 0, baseCost: 50, multiplier: 1.6, effect: () => clickPower += 2, desc: "+2 per tap" },
hyperTap: { level: 0, owned: 0, baseCost: 200, multiplier: 1.7, effect: () => clickPower += 3, desc: "+3 per tap" },
sprout: { level: 0, owned: 0, baseCost: 25, multiplier: 1.5, effect: () => passiveIncome++, desc: "+1/sec passive" },
farmer: { level: 0, owned: 0, baseCost: 120, multiplier: 1.6, effect: () => passiveIncome += 3, desc: "+3/sec passive" },
tractor: { level: 0, owned: 0, baseCost: 500, multiplier: 1.7, effect: () => passiveIncome += 8, desc: "+8/sec passive" },
luckyClover: { level: 0, owned: 0, baseCost: 80, multiplier: 1.5, effect: () => { criticalChance += 2; if(criticalChance>50)criticalChance=50; }, desc: "+2% crit chance (max 50%)" },
sharpSickle: { level: 0, owned: 0, baseCost: 300, multiplier: 1.6, effect: () => { criticalChance += 3; if(criticalChance>50)criticalChance=50; }, desc: "+3% crit chance" },
critDamage1: { level: 0, owned: 0, baseCost: 150, multiplier: 1.7, effect: () => criticalMultiplier += 0.5, desc: "+0.5x crit damage" },
critDamage2: { level: 0, owned: 0, baseCost: 600, multiplier: 1.8, effect: () => criticalMultiplier += 1, desc: "+1x crit damage" },
goldenSeed: { level: 0, owned: 0, baseCost: 1000, multiplier: 2, effect: () => { prestigePoints++; totalCropsEarned += 500; }, desc: "Gain 1 prestige point + 500 crops", unlocked: false },
};
let prestigeUpgrades = {
eternalGrowth: { owned: 0, cost: 1, effect: () => clickPower += prestigeLevel * 2, desc: "Perpetual Harvest (+2 tap per prestige lvl)" },
richSoil: { owned: 0, cost: 2, effect: () => passiveIncome += prestigeLevel * 3, desc: "Rich Soil (+3/sec per prestige lvl)" },
ancientScythe: { owned: 0, cost: 3, effect: () => criticalChance += prestigeLevel, desc: "Ancient Scythe (+1% crit per prestige lvl)" },
};
function getUpgradeCost(upgrade) {
return Math.floor(upgrade.baseCost * Math.pow(upgrade.multiplier, upgrade.owned));
}
function saveGame() {
let save = {
crops, clickPower, passiveIncome, criticalChance, criticalMultiplier,
totalCropsEarned, prestigeLevel, prestigePoints,
upgrades: {},
prestigeUpgrades: {}
};
for(let key in upgrades) {
save.upgrades[key] = upgrades[key].owned;
}
for(let key in prestigeUpgrades) {
save.prestigeUpgrades[key] = prestigeUpgrades[key].owned;
}
localStorage.setItem('tapFarmerSave_v2', JSON.stringify(save));
}
function loadGame() {
let saved = localStorage.getItem('tapFarmerSave_v2');
if(!saved) return;
try {
let data = JSON.parse(saved);
crops = data.crops || 0;
clickPower = data.clickPower || 1;
passiveIncome = data.passiveIncome || 0;
criticalChance = data.criticalChance || 0;
criticalMultiplier = data.criticalMultiplier || 2;
totalCropsEarned = data.totalCropsEarned || 0;
prestigeLevel = data.prestigeLevel || 0;
prestigePoints = data.prestigePoints || 0;
for(let key in upgrades) {
if(data.upgrades && data.upgrades[key]) {
upgrades[key].owned = data.upgrades[key];
for(let i=0; i<upgrades[key].owned; i++) upgrades[key].effect();
}
}
for(let key in prestigeUpgrades) {
if(data.prestigeUpgrades && data.prestigeUpgrades[key]) {
prestigeUpgrades[key].owned = data.prestigeUpgrades[key];
}
}
} catch(e) {}
}
function updateUI() {
let statsSpan = document.getElementById('tapStats_8x7k2m');
if(statsSpan) statsSpan.innerHTML = `🌽 ${Math.floor(crops).toLocaleString()} crops`;
document.getElementById('tapPowerStat').innerHTML = clickPower;
document.getElementById('tapPassiveStat').innerHTML = passiveIncome;
document.getElementById('tapCritStat').innerHTML = Math.floor(criticalChance) + '%';
let progressPercent = Math.min(100, Math.floor((crops % 100) / 1));
let progressBar = document.getElementById('tapProgressBar');
if(progressBar) {
progressBar.style.width = progressPercent + '%';
progressBar.textContent = progressPercent + '%';
}
let perksSection = document.getElementById('perksSection');
if(totalCropsEarned >= 1000 && perksSection) {
perksSection.style.display = 'block';
updatePerksUI();
}
}
function updatePerksUI() {
let perksDiv = document.getElementById('perksList');
if(!perksDiv) return;
let html = `<div style="margin-bottom:12px"><strong>✨ Prestige Level: ${prestigeLevel}</strong> | ⭐ Points: ${prestigePoints}</div>`;
html += `<div style="margin-bottom:12px"><button id="prestigeBtn" style="background:#8b5cf6;border:none;padding:10px 20px;border-radius:40px;color:white;font-weight:bold;cursor:pointer">🌟 PRESTIGE (Reset for ${Math.floor(Math.sqrt(totalCropsEarned/1000)) + 1} points)</button></div>`;
for(let [key, perk] of Object.entries(prestigeUpgrades)) {
let cost = perk.cost * (perk.owned + 1);
let name = key === 'eternalGrowth' ? '🌱 Eternal Growth' : (key === 'richSoil' ? '🌍 Rich Soil' : '⚔️ Ancient Scythe');
html += `<div class="upgrade-card" data-perk="${key}" style="margin-bottom:8px; ${prestigePoints >= cost ? 'border-color:#4ade80' : ''}">
<div class="upgrade-name">
<span>${name} ${perk.owned > 0 ? `x${perk.owned}` : ''}</span>
<span class="upgrade-cost">⭐${cost}</span>
</div>
<div class="upgrade-desc">${perk.desc} (permanent)</div>
</div>`;
}
perksDiv.innerHTML = html;
document.querySelectorAll('[data-perk]').forEach(el => {
el.onclick = () => {
let key = el.dataset.perk;
let perk = prestigeUpgrades[key];
let cost = perk.cost * (perk.owned + 1);
if(prestigePoints >= cost) {
prestigePoints -= cost;
perk.owned++;
perk.effect();
saveGame();
updateUI();
updatePerksUI();
showMessage(`✨ ${key === 'eternalGrowth' ? 'Eternal Growth' : (key === 'richSoil' ? 'Rich Soil' : 'Ancient Scythe')} purchased!`, '#4ade80');
} else {
showMessage(`❌ Need ${cost} prestige points!`, '#ef4444');
}
};
});
let prestigeBtn = document.getElementById('prestigeBtn');
if(prestigeBtn) {
prestigeBtn.onclick = () => {
let pointsGain = Math.floor(Math.sqrt(totalCropsEarned / 1000)) + 1;
if(totalCropsEarned < 1000) {
showMessage(`❌ Need 1000 total crops to prestige!`, '#ef4444');
return;
}
if(confirm(`Prestige will reset your crops but give you ${pointsGain} points.\nContinue?`)) {
prestigePoints += pointsGain;
prestigeLevel++;
crops = 0;
clickPower = 1;
passiveIncome = 0;
criticalChance = 0;
criticalMultiplier = 2;
for(let key in upgrades) {
let owned = upgrades[key].owned;
for(let i=0; i<owned; i++) {
}
upgrades[key].owned = 0;
}
for(let key in prestigeUpgrades) {
let owned = prestigeUpgrades[key].owned;
for(let i=0; i<owned; i++) {
prestigeUpgrades[key].effect();
}
}
saveGame();
updateUI();
renderUpgrades();
updatePerksUI();
showMessage(`🌟 Prestige! Level ${prestigeLevel} - Gained ${pointsGain} points`, '#facc15');
}
};
}
}
function renderUpgrades() {
let container = document.getElementById('tapUpgrades_4h6j8k');
if(!container) return;
let html = '';
let upgradeList = [
{ id: 'strongerTap', name: '✊ Stronger Tap', icon: '💪' },
{ id: 'megaTap', name: '💥 Mega Tap', icon: '⚡' },
{ id: 'hyperTap', name: '🚀 Hyper Tap', icon: '⭐' },
{ id: 'sprout', name: '🌱 Sprout Helper', icon: '🌿' },
{ id: 'farmer', name: '👨‍🌾 Skilled Farmer', icon: '🚜' },
{ id: 'tractor', name: '🚜 Auto Tractor', icon: '⚙️' },
{ id: 'luckyClover', name: '🍀 Lucky Clover', icon: '✨' },
{ id: 'sharpSickle', name: '🔪 Sharp Sickle', icon: '🎯' },
{ id: 'critDamage1', name: '💀 Brutal Strike', icon: '🗡️' },
{ id: 'critDamage2', name: '⚔️ Reaper\'s Touch', icon: '💀' },
];
if(totalCropsEarned >= 1000 || upgrades.goldenSeed.owned > 0) {
upgrades.goldenSeed.unlocked = true;
upgradeList.push({ id: 'goldenSeed', name: '🌟 Golden Seed', icon: '✨' });
}
for(let u of upgradeList) {
let up = upgrades[u.id];
if(!up) continue;
let cost = getUpgradeCost(up);
let affordable = crops >= cost;
let ownedCount = up.owned;
html += `<div class="upgrade-card ${affordable ? 'affordable' : ''}" data-upgrade="${u.id}">
<div class="upgrade-name">
<span>${u.icon} ${u.name} ${ownedCount > 0 ? `x${ownedCount}` : ''}</span>
<span class="upgrade-cost">🌾 ${Math.floor(cost).toLocaleString()}</span>
</div>
<div class="upgrade-desc">${up.desc}</div>
<div class="upgrade-owned">Owned: ${ownedCount}</div>
</div>`;
}
html += `<div id="tapResetBtn" class="tapper-reset-btn">🔄 RESET PROGRESS</div>`;
container.innerHTML = html;
document.querySelectorAll('[data-upgrade]').forEach(btn => {
btn.onclick = (e) => {
e.stopPropagation();
let id = btn.dataset.upgrade;
let up = upgrades[id];
if(!up) return;
let cost = getUpgradeCost(up);
if(crops >= cost) {
crops -= cost;
up.owned++;
up.effect();
saveGame();
updateUI();
renderUpgrades();
showMessage(`✓ ${up.name || id} upgraded!`, '#4ade80');
} else {
showMessage(`❌ Need ${Math.floor(cost).toLocaleString()} crops!`, '#ef4444');
}
};
});
let resetBtn = document.getElementById('tapResetBtn');
if(resetBtn) {
resetBtn.onclick = () => {
if(confirm('HARD RESET will delete ALL progress. Are you sure?')) {
localStorage.removeItem('tapFarmerSave_v2');
location.reload();
}
};
}
}
function showMessage(msg, color = '#facc15') {
let msgDiv = document.getElementById('tapMsg_2p5r7s');
if(msgDiv) {
msgDiv.textContent = msg;
msgDiv.style.color = color;
setTimeout(() => {
if(msgDiv) {
msgDiv.textContent = '';
msgDiv.style.color = '#facc15';
}
}, 1500);
}
}
function handleTap() {
let gain = clickPower;
let isCrit = Math.random() * 100 < criticalChance;
if(isCrit) {
gain = Math.floor(gain * criticalMultiplier);
}
crops += gain;
totalCropsEarned += gain;
let msgDiv = document.getElementById('tapMsg_2p5r7s');
if(msgDiv) {
msgDiv.textContent = isCrit ? `💥 CRIT! +${gain}` : `+${gain}`;
msgDiv.style.color = isCrit ? '#ff6b6b' : '#facc15';
setTimeout(() => {
if(msgDiv && !msgDiv.textContent.includes('Auto-saves')) {
msgDiv.textContent = '';
msgDiv.style.color = '#facc15';
}
}, 300);
}
let btn = document.getElementById('tapBtn_9w3r5t');
if(btn) {
btn.style.transform = 'scale(0.92)';
setTimeout(() => { if(btn) btn.style.transform = 'scale(1)'; }, 80);
}
updateUI();
saveGame();
if(totalCropsEarned >= 1000 && !upgrades.goldenSeed.unlocked) {
upgrades.goldenSeed.unlocked = true;
renderUpgrades();
showMessage('✨ Golden Seed upgrade unlocked!', '#facc15');
}
}
function passiveLoop() {
let now = Date.now();
let diff = Math.min(1, (now - lastTimestamp) / 1000);
if(diff > 0 && passiveIncome > 0) {
let gain = passiveIncome * diff;
crops += gain;
totalCropsEarned += gain;
updateUI();
saveGame();
}
lastTimestamp = now;
requestAnimationFrame(passiveLoop);
}
loadGame();
updateUI();
renderUpgrades();
lastTimestamp = Date.now();
passiveLoop();
let tapBtn = document.getElementById('tapBtn_9w3r5t');
if(tapBtn) {
tapBtn.onclick = (e) => {
e.preventDefault();
handleTap();
};
tapBtn.addEventListener('touchstart', (e) => {
e.preventDefault();
handleTap();
});
}
setInterval(() => {
updateUI();
if(totalCropsEarned >= 1000 && upgrades.goldenSeed.unlocked === undefined) {
upgrades.goldenSeed.unlocked = true;
renderUpgrades();
}
}, 500);
})();
SCRIPT-END