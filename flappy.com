PAGE: FLAPPY_NOMAD
COLOR: #0f172a
AUTHOR: DimensionDevices
DATE: 2026-06-05
CUSTOMHTML-START
<div id="flappyStatus" style="text-align:center;font-size:1rem;font-weight:bold;margin:4px 0 6px 0;color:#facc15;">🐦 TAP / SPACE TO START</div> <div style="display:flex;justify-content:center;margin:0 auto;"> <canvas id="flappyCanvas" width="400" height="520" style="width:100%;max-width:400px;height:auto;background:#0f172a;border-radius:20px;box-shadow:0 8px 20px rgba(0,0,0,0.4);cursor:pointer;display:block;touch-action:manipulation;"></canvas> </div> <div style="display:flex;justify-content:space-between;align-items:center;max-width:400px;margin:10px auto 6px;padding:0 12px;"> <div style="background:#1e293b;padding:4px 16px;border-radius:40px;"><span style="color:#facc15;">🏆 SCORE</span> <span id="flappyScore" style="color:white;font-weight:bold;font-size:1.3rem;margin-left:6px;">0</span></div> <div style="background:#1e293b;padding:4px 16px;border-radius:40px;"><span style="color:#facc15;">⭐ BEST</span> <span id="flappyBest" style="color:#ffd700;font-weight:bold;font-size:1.3rem;margin-left:6px;">0</span></div> </div> <div style="display:flex;gap:12px;justify-content:center;margin:4px 0 8px;"> <button id="flappyResetBtn" style="background:#3b3b6e;border:none;padding:6px 28px;border-radius:60px;color:white;font-weight:bold;font-size:0.9rem;touch-action:manipulation;transition:transform 0.05s;">🔄 RESTART</button> </div>
CUSTOMHTML-END
STYLE-START
#flappyCanvas:active { transform: scale(0.99); }
button:active { transform: scale(0.96); }
body { margin: 0; padding: 4px; }
STYLE-END
SCRIPT-START
(function(){
const canvas = document.getElementById('flappyCanvas');
const ctx = canvas.getContext('2d');
const statusDiv = document.getElementById('flappyStatus');
const scoreSpan = document.getElementById('flappyScore');
const bestSpan = document.getElementById('flappyBest');
const W = 400, H = 520;
canvas.width = W;
canvas.height = H;
const BIRD_SIZE = 22;
let bird = {
x: 65,
y: H/2,
velY: 0,
rotation: 0,
radius: 11
};
let baseSpeed = 2.0;
let gameActive = false;
let score = 0;
let bestScore = localStorage.getItem('flappyBestNomad') ? parseInt(localStorage.getItem('flappyBestNomad')) : 0;
bestSpan.innerText = bestScore;
let pipes = [];
const PIPE_W = 48;
const PIPE_GAP = 128;
let frameCounter = 0;
let scrollSpeed = baseSpeed;
let particles = [];
function addParticle(x, y, color = '#facc15') {
for(let i = 0; i < 3; i++) {
particles.push({
x: x + (Math.random() - 0.5) * 10,
y: y + (Math.random() - 0.5) * 10,
vx: (Math.random() - 0.5) * 2.5,
vy: (Math.random() - 0.5) * 2.5 - 2,
life: 16,
color: color
});
}
}
let stars = [];
for(let i = 0; i < 140; i++) {
stars.push({
x: Math.random() * W,
y: Math.random() * H,
size: Math.random() * 1.8 + 0.8,
alpha: Math.random() * 0.5 + 0.3,
speed: Math.random() * 0.6 + 0.2
});
}
let groundOffset = 0;
function drawBackground() {
let grad = ctx.createLinearGradient(0, 0, 0, H);
grad.addColorStop(0, '#0a0f2a');
grad.addColorStop(0.6, '#1a1f3e');
grad.addColorStop(1, '#0f172a');
ctx.fillStyle = grad;
ctx.fillRect(0, 0, W, H);
let drift = gameActive ? scrollSpeed * 0.12 : 0;
for(let s of stars) {
let newX = s.x - drift * s.speed;
if(newX < 0) newX += W;
if(newX > W) newX -= W;
s.x = newX;
ctx.fillStyle = `rgba(255, 240, 200, ${s.alpha})`;
ctx.fillRect(s.x, s.y, s.size, s.size);
}
ctx.fillStyle = '#2d3a5e80';
ctx.fillRect(0, H-70, W, 70);
ctx.fillStyle = '#1e2a4a';
for(let i = 0; i < 4; i++) {
let cloudX = (i * 130 + (gameActive ? frameCounter * 0.4 : 0)) % (W + 100) - 50;
ctx.beginPath();
ctx.ellipse(cloudX, H-58, 30, 18, 0, 0, Math.PI*2);
ctx.ellipse(cloudX+28, H-66, 35, 20, 0, 0, Math.PI*2);
ctx.ellipse(cloudX+55, H-60, 28, 16, 0, 0, Math.PI*2);
ctx.fill();
}
groundOffset = (groundOffset + (gameActive ? scrollSpeed : 0)) % 55;
ctx.fillStyle = '#3b2a1f';
ctx.fillRect(0, H-42, W, 42);
ctx.fillStyle = '#5c3e1f';
for(let i = 0; i < 15; i++) {
let x = (i * 28 + groundOffset) % (W+30) - 15;
ctx.fillRect(x, H-45, 10, 5);
}
ctx.fillStyle = '#8b5a2b';
ctx.fillRect(0, H-45, W, 3);
ctx.fillStyle = '#c97e3a';
ctx.fillRect(0, H-43, W, 2);
}
function drawBird() {
ctx.save();
ctx.translate(bird.x + BIRD_SIZE/2, bird.y + BIRD_SIZE/2);
let rot = bird.rotation;
if(!gameActive && bird.y > H-100) rot = 0.8;
ctx.rotate(rot);
ctx.translate(-(bird.x + BIRD_SIZE/2), -(bird.y + BIRD_SIZE/2));
ctx.shadowBlur = 6;
ctx.shadowColor = '#f59e0b';
ctx.fillStyle = '#facc15';
ctx.beginPath();
ctx.ellipse(bird.x + BIRD_SIZE/2, bird.y + BIRD_SIZE/2, 11, 9, 0, 0, Math.PI*2);
ctx.fill();
ctx.fillStyle = '#eab308';
ctx.beginPath();
ctx.ellipse(bird.x + BIRD_SIZE/2 + 2, bird.y + BIRD_SIZE/2 - 2, 3.5, 2.5, 0, 0, Math.PI*2);
ctx.fill();
ctx.fillStyle = 'white';
ctx.beginPath();
ctx.arc(bird.x + BIRD_SIZE - 6, bird.y + 7, 3.5, 0, Math.PI*2);
ctx.fill();
ctx.fillStyle = '#0a0a0a';
ctx.beginPath();
ctx.arc(bird.x + BIRD_SIZE - 5, bird.y + 6, 1.8, 0, Math.PI*2);
ctx.fill();
ctx.fillStyle = 'white';
ctx.beginPath();
ctx.arc(bird.x + BIRD_SIZE - 7, bird.y + 5, 0.8, 0, Math.PI*2);
ctx.fill();
ctx.fillStyle = '#f97316';
ctx.beginPath();
ctx.moveTo(bird.x + BIRD_SIZE - 2, bird.y + 8);
ctx.lineTo(bird.x + BIRD_SIZE + 4, bird.y + 10);
ctx.lineTo(bird.x + BIRD_SIZE - 1, bird.y + 12);
ctx.fill();
let wingAngle = gameActive ? Math.sin(Date.now() * 0.014) * 0.7 : 0.3;
ctx.fillStyle = '#eab308';
ctx.beginPath();
ctx.ellipse(bird.x + 7, bird.y + 13, 7, 4.5, wingAngle, 0, Math.PI*2);
ctx.fill();
ctx.shadowBlur = 0;
ctx.restore();
}
function drawPipes() {
for(let p of pipes) {
let gradTop = ctx.createLinearGradient(p.x, 0, p.x+10, 0);
gradTop.addColorStop(0, '#2e7d32');
gradTop.addColorStop(1, '#1b5e20');
ctx.fillStyle = gradTop;
ctx.fillRect(p.x, 0, PIPE_W, p.topHeight);
ctx.fillStyle = '#2e7d32';
ctx.fillRect(p.x - 5, p.topHeight - 28, PIPE_W + 10, 28);
ctx.fillStyle = '#4caf50';
ctx.fillRect(p.x - 3, p.topHeight - 24, PIPE_W + 6, 18);
let bottomY = p.topHeight + PIPE_GAP;
ctx.fillStyle = gradTop;
ctx.fillRect(p.x, bottomY, PIPE_W, H - bottomY);
ctx.fillStyle = '#2e7d32';
ctx.fillRect(p.x - 5, bottomY, PIPE_W + 10, 28);
ctx.fillStyle = '#4caf50';
ctx.fillRect(p.x - 3, bottomY + 6, PIPE_W + 6, 18);
ctx.fillStyle = '#1b5e2080';
ctx.fillRect(p.x+4, 0, 5, p.topHeight);
ctx.fillRect(p.x+4, bottomY, 5, H-bottomY);
}
}
function drawParticles() {
for(let i=0; i<particles.length; i++) {
let p = particles[i];
p.life--;
p.x += p.vx;
p.y += p.vy;
p.vy += 0.12;
ctx.fillStyle = `rgba(250, 204, 21, ${p.life/16})`;
ctx.fillRect(p.x, p.y, 2.5, 2.5);
}
particles = particles.filter(p => p.life > 0);
}
function drawScoreboard() {
if(!gameActive && !statusDiv.innerHTML.includes('START')) {
ctx.font = 'bold 24px "Courier New", monospace';
ctx.fillStyle = '#ef4444';
ctx.shadowBlur = 0;
ctx.fillText('GAME OVER', W/2-80, H/2-60);
ctx.font = '14px monospace';
ctx.fillStyle = '#94a3b8';
ctx.fillText('tap / space to fly again', W/2-105, H/2-15);
}
}
function spawnPipe() {
let minTop = 50;
let maxTop = H - PIPE_GAP - 70;
let topHeight = Math.floor(Math.random() * (maxTop - minTop + 1) + minTop);
pipes.push({
x: W,
topHeight: topHeight,
scored: false
});
}
function resetGame() {
gameActive = false;
score = 0;
scoreSpan.innerText = "0";
bird.y = H/2;
bird.velY = 0;
bird.rotation = 0;
pipes = [];
particles = [];
frameCounter = 0;
scrollSpeed = baseSpeed;
statusDiv.innerHTML = '🐦 TAP / SPACE TO START';
statusDiv.style.color = '#facc15';
drawAll();
}
function startGame() {
gameActive = true;
score = 0;
scoreSpan.innerText = "0";
bird.y = H/2 - 20;
bird.velY = -2;
bird.rotation = 0.2;
pipes = [];
frameCounter = 0;
scrollSpeed = baseSpeed;
statusDiv.innerHTML = '🏆 FLYING!';
statusDiv.style.color = '#a6e3a1';
addParticle(bird.x + 10, bird.y + 12, '#facc15');
}
function updateGame() {
if(!gameActive) return;
bird.velY += 0.28;
bird.y += bird.velY;
bird.rotation = Math.min(1.2, Math.max(-0.8, bird.velY * 0.12));
if(bird.y + BIRD_SIZE >= H - 38 || bird.y <= 0) {
gameActive = false;
statusDiv.innerHTML = '💀 CRASHED 💀';
statusDiv.style.color = '#ef4444';
addParticle(bird.x+8, bird.y+12, '#ff4444');
if(score > bestScore) {
bestScore = score;
bestSpan.innerText = bestScore;
localStorage.setItem('flappyBestNomad', bestScore);
}
return;
}
frameCounter++;
if(frameCounter % 82 === 0 || (pipes.length === 0 && frameCounter > 20)) {
spawnPipe();
}
for(let i=0; i<pipes.length; i++) {
let p = pipes[i];
p.x -= scrollSpeed;
if(!p.scored && p.x + PIPE_W < bird.x) {
p.scored = true;
score++;
scoreSpan.innerText = score;
addParticle(bird.x+12, bird.y+8, '#22c55e');
if(score > bestScore) {
bestScore = score;
bestSpan.innerText = bestScore;
localStorage.setItem('flappyBestNomad', bestScore);
}
}
let birdLeft = bird.x;
let birdRight = bird.x + BIRD_SIZE;
let birdTop = bird.y;
let birdBottom = bird.y + BIRD_SIZE;
let pipeRight = p.x + PIPE_W;
let pipeLeft = p.x;
if(birdRight > pipeLeft && birdLeft < pipeRight) {
let topPipeBottom = p.topHeight;
let bottomPipeTop = p.topHeight + PIPE_GAP;
if(birdTop < topPipeBottom || birdBottom > bottomPipeTop) {
gameActive = false;
statusDiv.innerHTML = '💀 GAME OVER 💀';
statusDiv.style.color = '#ef4444';
for(let j=0;j<10;j++) addParticle(bird.x+6, bird.y+10, '#ff6666');
if(score > bestScore) {
bestScore = score;
bestSpan.innerText = bestScore;
localStorage.setItem('flappyBestNomad', bestScore);
}
return;
}
}
if(p.x + PIPE_W < 0) {
pipes.splice(i,1);
i--;
}
}
scrollSpeed = baseSpeed + Math.floor(score / 20);
}
function drawAll() {
drawBackground();
drawPipes();
drawBird();
drawParticles();
drawScoreboard();
}
function gameLoop() {
updateGame();
drawAll();
requestAnimationFrame(gameLoop);
}
function flap() {
if(!gameActive) {
resetGame();
startGame();
} else {
bird.velY = -5.0;
bird.rotation = -0.45;
addParticle(bird.x + 4, bird.y + BIRD_SIZE-4, '#facc15');
}
}
canvas.addEventListener('click', (e) => { e.preventDefault(); flap(); });
canvas.addEventListener('touchstart', (e) => { e.preventDefault(); flap(); });
document.addEventListener('keydown', (e) => { if(e.code === 'Space' || e.code === 'ArrowUp') { e.preventDefault(); flap(); } });
document.getElementById('flappyResetBtn').onclick = () => { resetGame(); };
resetGame();
gameLoop();
})();
SCRIPT-END