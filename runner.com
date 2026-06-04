PAGE: SHADOW_RUNNER
COLOR: #0f172a
AUTHOR: NOMAD
DATE: 2026-06-02
DESCRIPTION: A simple run n' jump game
CATEGORY: game

CUSTOMHTML-START
<div id="runStatus_1a2b3c" style="text-align:center;font-size:1rem;font-weight:bold;margin:4px 0;color:#facc15;">🔴 TAP TO START</div>
<canvas id="runCanvas_4d5e6f" width="500" height="350" style="width:100%;max-width:500px;height:auto;margin:0 auto;display:block;border-radius:20px;box-shadow:0 8px 24px rgba(0,0,0,0.4);background:#0f172a;cursor:pointer;"></canvas>
<div style="display:flex;justify-content:space-between;align-items:center;max-width:500px;margin:12px auto;padding:0 12px;">
<div style="background:#1e293b;padding:6px 16px;border-radius:40px;"><span style="color:#facc15;">⭐ SCORE</span> <span id="runScore_7g8h9i" style="color:white;font-weight:bold;font-size:1.3rem;">0</span></div>
<div style="background:#1e293b;padding:6px 16px;border-radius:40px;"><span style="color:#facc15;">🏆 BEST</span> <span id="runBest_0j1k2l" style="color:#ffd700;font-weight:bold;font-size:1.3rem;">0</span></div>
</div>
<div style="display:flex;gap:12px;justify-content:center;margin:8px 0;">
<button id="runResetBtn_3m4n5o" style="background:#3a3a5e;border:none;padding:10px 28px;border-radius:40px;color:white;font-weight:bold;font-size:1rem;touch-action:manipulation;transition:transform 0.05s;">🔄 New Run</button>
</div>
CUSTOMHTML-END

STYLE-START
#runCanvas_4d5e6f{background:#0f172a;touch-action:manipulation; width:100% !important; max-width:100% !important; height:auto; aspect-ratio:500/350;}
button:active{transform:scale(0.96);}
STYLE-END

SCRIPT-START
(function(){
let cv=document.getElementById('runCanvas_4d5e6f'),ctx=cv.getContext('2d');
let statDiv=document.getElementById('runStatus_1a2b3c');
let scoreSpan=document.getElementById('runScore_7g8h9i');
let bestSpan=document.getElementById('runBest_0j1k2l');
let gameRunning=false,score=0,frame=0,landFrame=0;
let groundY=300,playerSize=20;
let player={x:70,y:groundY-18,velY:0,isJumping:false,width:18,height:18,rotation:0,legSwing:0};
let obstacles=[],particles=[],dustTrail=[];
let currentSpeed = 5;      
let bestScore=localStorage.getItem('runBest2')?parseInt(localStorage.getItem('runBest2')):0;
bestSpan.innerText=bestScore;

// Parallax background stars arrays
let bgStars = [];
let mgStars = [];
let fgStars = [];
for(let i=0;i<100;i++) {
  bgStars.push({x:Math.random()*500, y:Math.random()*280, size:1, alpha:0.3+Math.random()*0.4});
}
for(let i=0;i<60;i++) {
  mgStars.push({x:Math.random()*500, y:Math.random()*280, size:1.5, alpha:0.5+Math.random()*0.5});
}
for(let i=0;i<30;i++) {
  fgStars.push({x:Math.random()*500, y:Math.random()*280, size:2, alpha:0.7+Math.random()*0.3});
}
let bgClouds = [{x:0, width:80},{x:200, width:60},{x:400, width:100}];
let mountainOffset = 0;

function addDust(x,y){
 for(let i=0;i<3;i++){dustTrail.push({x:x+Math.random()*15,y:y+8,vx:(Math.random()-0.5)*2,vy:-Math.random()*3,life:20});}
}

function addParticle(x,y){
 particles.push({x:x+8,y:y+8,vx:(Math.random()-0.5)*5,vy:-Math.random()*8-2,life:15,color:'#facc15'});
}

function drawParallaxBackground() {
  let scrollSpeed = gameRunning ? currentSpeed * 0.3 : 0;
  mountainOffset = (mountainOffset + scrollSpeed * 0.5) % (cv.width * 2);
  let starSpeed = gameRunning ? currentSpeed * 0.15 : 0;
  
  // Draw far mountains (layer 4 - deepest)
  ctx.fillStyle = '#0f172a';
  ctx.fillRect(0, 0, cv.width, groundY - 40);
  
  // Layer 5: Back mountains
  for(let i = -2; i < 4; i++) {
    let x = i * 150 + (mountainOffset * 0.3);
    ctx.beginPath();
    ctx.moveTo(x, groundY - 30);
    ctx.lineTo(x + 50, groundY - 90);
    ctx.lineTo(x + 100, groundY - 50);
    ctx.lineTo(x + 150, groundY - 110);
    ctx.lineTo(x + 200, groundY - 40);
    ctx.lineTo(x + 250, groundY - 30);
    ctx.lineTo(x + 300, groundY);
    ctx.fillStyle = '#1e293b';
    ctx.fill();
  }
  
  // Layer 4: Mid mountains
  for(let i = -2; i < 4; i++) {
    let x = i * 180 + (mountainOffset * 0.6);
    ctx.beginPath();
    ctx.moveTo(x, groundY - 20);
    ctx.lineTo(x + 60, groundY - 70);
    ctx.lineTo(x + 120, groundY - 45);
    ctx.lineTo(x + 170, groundY - 85);
    ctx.lineTo(x + 220, groundY - 35);
    ctx.lineTo(x + 280, groundY - 20);
    ctx.fillStyle = '#334155';
    ctx.fill();
  }
  
  // Layer 3: Background stars (slowest parallax)
  for(let s of bgStars) {
    let newX = (s.x - starSpeed * 0.3) % cv.width;
    if(newX < 0) newX += cv.width;
    ctx.fillStyle = `rgba(255,255,200,${s.alpha})`;
    ctx.fillRect(newX, s.y, s.size, s.size);
  }
  
  // Layer 2: Midground stars (medium speed)
  for(let s of mgStars) {
    let newX = (s.x - starSpeed * 0.6) % cv.width;
    if(newX < 0) newX += cv.width;
    ctx.fillStyle = `rgba(255,240,180,${s.alpha})`;
    ctx.fillRect(newX, s.y, s.size, s.size);
  }
  
  // Layer 1: Foreground stars (fastest)
  for(let s of fgStars) {
    let newX = (s.x - starSpeed * 1.2) % cv.width;
    if(newX < 0) newX += cv.width;
    ctx.fillStyle = `rgba(255,220,100,${s.alpha})`;
    ctx.fillRect(newX, s.y, s.size, s.size);
  }
  
  // Shooting stars (rare)
  if(gameRunning && Math.random() < 0.002) {
    bgStars.push({x:cv.width, y:Math.random()*150, size:3, alpha:1, life:30, shooting:true});
  }
  for(let i=0; i<bgStars.length; i++) {
    if(bgStars[i].shooting) {
      bgStars[i].x -= 8;
      bgStars[i].life--;
      ctx.fillStyle = `rgba(255,255,200,${bgStars[i].alpha})`;
      ctx.fillRect(bgStars[i].x, bgStars[i].y, bgStars[i].size, bgStars[i].size);
      if(bgStars[i].life <= 0 || bgStars[i].x < 0) {
        bgStars.splice(i,1);
        i--;
      }
    }
  }
}

function draw(){
 ctx.clearRect(0,0,cv.width,cv.height);
 
 // Draw parallax background
 drawParallaxBackground();
 
 // Ground gradient overlay
 let grad=ctx.createLinearGradient(0,groundY-20,0,groundY+30);
 grad.addColorStop(0,'rgba(15,23,42,0)');
 grad.addColorStop(1,'#0f172a');
 ctx.fillStyle=grad;
 ctx.fillRect(0,groundY-20,cv.width,50);
 
 // Ground details
 for(let i=0;i<30;i++){let x=(i*25+frame*currentSpeed*1.5)%cv.width;ctx.fillStyle='#2a3a50';ctx.fillRect(x,groundY+4,3,8);}
 ctx.fillStyle='#334155';ctx.fillRect(0,groundY,cv.width,28);
 ctx.fillStyle='#475569';ctx.fillRect(0,groundY+4,cv.width,4);
 ctx.fillStyle='#22c55e';ctx.fillRect(0,groundY+6,cv.width,2);
 
 // Dust particles
 for(let i=0;i<dustTrail.length;i++){let d=dustTrail[i];d.life--;d.x+=d.vx;d.y+=d.vy;ctx.fillStyle=`rgba(200,180,100,${d.life/20})`;ctx.fillRect(d.x,d.y,3,3);}dustTrail=dustTrail.filter(d=>d.life>0);
 
 if(gameRunning&&!player.isJumping&&frame%6<3){addDust(player.x-5,player.y+player.height-4);}
 if(player.isJumping){player.rotation=Math.min(0.5,player.rotation+0.05);}else{player.rotation=Math.max(0,player.rotation-0.05);}
 let legPhase=gameRunning?(Math.sin(Date.now()*0.015)*4):(player.isJumping?2:0);
 
 ctx.save();ctx.translate(player.x+player.width/2,player.y+player.height/2);ctx.rotate(player.rotation);ctx.translate(-(player.x+player.width/2),-(player.y+player.height/2));
 ctx.fillStyle='#facc15';ctx.shadowBlur=12;ctx.shadowColor='#f59e0b';
 ctx.beginPath();ctx.roundRect(player.x,player.y,player.width,player.height,4);ctx.fill();
 ctx.fillStyle='#f59e0b';ctx.fillRect(player.x+3,player.y+player.height-5,4,5+legPhase);
 ctx.fillRect(player.x+11,player.y+player.height-5,4,5-legPhase);
 ctx.fillStyle='#fff';ctx.fillRect(player.x+4,player.y+4,4,4);ctx.fillRect(player.x+11,player.y+4,4,4);
 ctx.fillStyle='#000';ctx.fillRect(player.x+5,player.y+5,2,2);ctx.fillRect(player.x+12,player.y+5,2,2);
 ctx.restore();
 ctx.shadowBlur=0;
 
 // Draw obstacles
 for(let o of obstacles){
   if(o.type === 0) { 
     let gradient=ctx.createLinearGradient(o.x,groundY-20,o.x+18,groundY);gradient.addColorStop(0,'#dc2626');gradient.addColorStop(1,'#991b1b');
     ctx.fillStyle=gradient;ctx.fillRect(o.x,groundY-20,16,20);
     ctx.fillStyle='#7f1d1d';ctx.fillRect(o.x+4,groundY-26,8,8);
     ctx.fillStyle='#f87171';ctx.fillRect(o.x+6,groundY-28,4,4);
     ctx.fillStyle='#450a0a';ctx.fillRect(o.x+2,groundY-4,12,4);
   } else if(o.type === 1) {
     ctx.fillStyle='#3b82f6';
     ctx.shadowBlur=8; ctx.shadowColor='#1e3a8a';
     ctx.beginPath(); ctx.ellipse(o.x+8, o.y+6, 10, 8, 0, 0, Math.PI*2); ctx.fill();
     ctx.fillStyle='#facc15'; ctx.beginPath(); ctx.arc(o.x+5, o.y+5, 2, 0, Math.PI*2); ctx.fill();
     ctx.fillStyle='white'; ctx.beginPath(); ctx.arc(o.x+11, o.y+5, 2, 0, Math.PI*2); ctx.fill();
     ctx.fillStyle='#000'; ctx.fillRect(o.x+4, o.y+10, 9, 2);
     ctx.fillStyle='#1e293b'; ctx.fillRect(o.x+2, o.y+13, 13, 4);
     ctx.shadowBlur=0;
   } else if(o.type === 2) {
     ctx.fillStyle='#8b5cf6';
     ctx.shadowBlur=6; ctx.shadowColor='#4c1d95';
     ctx.beginPath(); ctx.ellipse(o.x+8, groundY-6, 8, 6, 0, 0, Math.PI*2); ctx.fill();
     ctx.fillStyle='#c084fc'; ctx.fillRect(o.x+3, groundY-10, 11, 4);
     ctx.fillStyle='#facc15'; ctx.fillRect(o.x+6, groundY-12, 4, 4);
     ctx.shadowBlur=0;
   } else if(o.type === 3) {
     let pulse = Math.sin(Date.now() * 0.01) * 2;
     ctx.fillStyle='#ef4444';
     ctx.shadowBlur=4; ctx.shadowColor='#b91c1c';
     ctx.fillRect(o.x, groundY-22 - pulse, 14, 22);
     ctx.fillStyle='#f97316'; ctx.fillRect(o.x+3, groundY-28 - pulse, 8, 8);
     ctx.shadowBlur=0;
   }
 }
 
 for(let p of particles){p.life--;p.x+=p.vx;p.y+=p.vy;ctx.fillStyle=`rgba(250,204,21,${p.life/15})`;ctx.fillRect(p.x,p.y,3,3);}particles=particles.filter(p=>p.life>0);
 
 if(!gameRunning&&statDiv.innerHTML.includes('GAME')){ctx.font='bold 24px monospace';ctx.fillStyle='#ef4444';ctx.shadowBlur=0;ctx.fillText('GAME OVER',cv.width/2-70,groundY-80);}
}

function update(){
 if(!gameRunning)return;
 frame++;
 
 currentSpeed = 5 + Math.floor(score / 35);
 if(currentSpeed > 13) currentSpeed = 13;
 
 if(frame%30===0){score++;scoreSpan.innerText=score;if(score>bestScore){bestScore=score;bestSpan.innerText=bestScore;localStorage.setItem('runBest2',bestScore);}}
 
 let spawnBase = Math.max(32, 50 - Math.floor(score/12));
 if(frame % spawnBase === 0) {
   let r = Math.random();
   let obsType = 0;
   if(r < 0.5) obsType = 0;        
   else if(r < 0.7) obsType = 1;   
   else if(r < 0.85) obsType = 2;  
   else obsType = 3;               
   
   obstacles.push({
     x: cv.width,
     y: (obsType === 1) ? groundY - 42 : groundY - 20,
     w: 16,
     h: (obsType === 1) ? 16 : 20,
     type: obsType,
     usedSafe: (obsType === 1) 
   });
 }
 
 for(let i=0;i<obstacles.length;i++){
   obstacles[i].x -= currentSpeed;
   if(obstacles[i].x + 20 < 0){
     obstacles.splice(i,1);
     i--;
   }
 }
 
 if(player.isJumping){
   player.velY += 0.45;
   player.y += player.velY;
   if(player.y >= groundY - player.height){
     player.y = groundY - player.height;
     player.isJumping = false;
     player.velY = 0;
     landFrame = 5;
     addParticle(player.x, player.y);
     for(let i=0;i<8;i++) addDust(player.x, player.y);
   }
 }
 if(landFrame>0){ landFrame--; }
 
 for(let o of obstacles){
   if(o.type === 1) continue;
   
   if (player.x + player.width > o.x && 
       player.x < o.x + o.w && 
       player.y + player.height > o.y && 
       player.y < o.y + o.h) {
     
     gameRunning = false;
     statDiv.innerHTML = '💀 GAME OVER 💀';
     statDiv.style.color = '#ef4444';
     addParticle(player.x, player.y);
     addParticle(player.x+10, player.y);
     return;
   }
 }
 draw();
}

function jump(){
 if(!gameRunning){
   gameRunning = true;
   score = 0;
   currentSpeed = 5;
   scoreSpan.innerText = 0;
   obstacles = [];
   particles = [];
   dustTrail = [];
   frame = 0;
   player.y = groundY - player.height;
   player.isJumping = false;
   player.velY = 0;
   statDiv.innerHTML = '🏃 RUNNING...';
   statDiv.style.color = '#a6e3a1';
   draw();
 } else if(gameRunning && !player.isJumping && player.y >= groundY - player.height){
   player.velY = -7.4;
   player.isJumping = true;
   player.rotation = 0;
   addParticle(player.x, player.y);
   for(let i=0;i<6;i++) addDust(player.x, player.y);
 }
}

function resetGame(){
 gameRunning = false;
 score = 0;
 currentSpeed = 5;
 scoreSpan.innerText = 0;
 obstacles = [];
 particles = [];
 dustTrail = [];
 frame = 0;
 player.y = groundY - player.height;
 player.isJumping = false;
 player.velY = 0;
 player.rotation = 0;
 statDiv.innerHTML = '🔴 TAP TO START';
 statDiv.style.color = '#facc15';
 draw();
}

cv.addEventListener('click',(e)=>{ e.preventDefault(); jump(); });
cv.addEventListener('touchstart',(e)=>{ e.preventDefault(); jump(); });
document.getElementById('runResetBtn_3m4n5o').onclick = () => resetGame();

window.roundRect = function(x,y,w,h,r){
 this.moveTo(x+r,y);
 this.lineTo(x+w-r,y);
 this.quadraticCurveTo(x+w,y,x+w,y+r);
 this.lineTo(x+w,y+h-r);
 this.quadraticCurveTo(x+w,y+h,x+w-r,y+h);
 this.lineTo(x+r,y+h);
 this.quadraticCurveTo(x,y+h,x,y+h-r);
 this.lineTo(x,y+r);
 this.quadraticCurveTo(x,y,x+r,y);
 return this;
};

player.y = groundY - player.height;
draw();
setInterval(()=>{ if(gameRunning) update(); else draw(); }, 1000/55);
})();
SCRIPT-END
