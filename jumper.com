PAGE: Stomper
COLOR: #f59e0b
AUTHOR: NOMAD
DATE: 2025-01-15
DESCRIPTION: Run, jump, collect, survive!
CATEGORY: game

BIGHEADER: Jumper Game

CUSTOMHTML-START
<style>*{user-select:none;touch-action:pan-y}canvas{display:block;width:100%;margin:0 auto;border-radius:16px;box-shadow:0 8px 20px rgba(0,0,0,0.3);cursor:pointer}.controls{display:flex;gap:8px;justify-content:center;margin-top:12px}.ctrl{background:#334155;border:none;color:white;font-size:18px;padding:10px 20px;border-radius:40px;font-weight:bold;cursor:pointer}.info{display:flex;justify-content:space-between;margin-top:10px;padding:0 10px;font-size:12px;color:#fbbf24;font-weight:bold}</style>
<canvas id="c" width="400" height="450"></canvas>
<div class="controls"><button class="ctrl" ontouchstart="L=1" ontouchend="L=0" onmousedown="L=1" onmouseup="L=0">◀</button><button class="ctrl" ontouchstart="J=1" ontouchend="J=0" onmousedown="J=1" onmouseup="J=0">▲</button><button class="ctrl" ontouchstart="R=1" ontouchend="R=0" onmousedown="R=1" onmouseup="R=0">▶</button></div>
<div class="info"><span id="sc">❤️ 3  🪙 0</span><span id="starCount">⭐ 0/0</span><span id="lvl">🌍 1/6</span><span id="pwr">⚡ None</span></div>
<script>
let cv=document.getElementById('c'),ctx=cv.getContext('2d'),W=400,H=450;
let L=0,R=0,J=0;
window.onkeydown=e=>{let k=e.key;if(k==='ArrowLeft'){L=1;e.preventDefault()}else if(k==='ArrowRight'){R=1;e.preventDefault()}else if(k==='ArrowUp'){J=1;e.preventDefault()}};
window.onkeyup=e=>{if(e.key==='ArrowLeft')L=0;if(e.key==='ArrowRight')R=0;if(e.key==='ArrowUp')J=0};
let player={x:80,y:300,w:14,h:14,vy:0,onGround:0,invincible:0,health:3,coins:0,starsCollected:0,powerup:0,powerupTimer:0,doubleJump:0};
let camX=0,worldW=3000,gameOver=0,level=1,levelComplete=0,particles=[],screenshake=0,levelEndX=0;
let platforms=[],movingPlatforms=[],fallingPlatforms=[],coins=[],stars=[],enemies=[],powerups=[],flagpole=null;
function buildLevel(lvl){
platforms=[{x:0,y:H-35,w:worldW,h:8}];movingPlatforms=[];fallingPlatforms=[];coins=[];stars=[];enemies=[];powerups=[];flagpole=null;
if(lvl===1){
platforms.push({x:120,y:370,w:70,h:10},{x:280,y:330,w:60,h:10},{x:440,y:360,w:50,h:10},{x:600,y:300,w:70,h:10},{x:760,y:340,w:55,h:10},{x:920,y:290,w:65,h:10},{x:1080,y:320,w:60,h:10},{x:1240,y:280,w:55,h:10},{x:1400,y:310,w:70,h:10},{x:1560,y:350,w:60,h:10},{x:1720,y:300,w:70,h:10});
movingPlatforms.push({x:500,y:310,w:50,h:10,left:450,right:650,dir:1});
for(let i=0;i<35;i++){let x=60+i*70;let y=H-48;if(i<5)y=H-48;else if(i<10)y=358;else if(i<15)y=318;else if(i<20)y=348;else if(i<25)y=288;else if(i<30)y=328;else y=278;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<6;i++){let x=200+i*400;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
enemies.push({x:300,y:H-50,w:14,h:10,dir:1,active:1},{x:600,y:H-55,w:14,h:10,dir:1.2,active:1},{x:1000,y:H-45,w:14,h:10,dir:1,active:1},{x:1400,y:H-50,w:14,h:10,dir:1.3,active:1},{x:1800,y:H-55,w:14,h:10,dir:1,active:1});
powerups.push({x:800,y:H-55,w:10,h:10,type:'jet',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
if(lvl===2){
platforms.push({x:100,y:380,w:65,h:10},{x:260,y:340,w:70,h:10},{x:420,y:300,w:55,h:10},{x:580,y:360,w:65,h:10},{x:740,y:280,w:70,h:10},{x:900,y:320,w:60,h:10},{x:1060,y:260,w:65,h:10},{x:1220,y:370,w:70,h:10},{x:1380,y:310,w:60,h:10},{x:1540,y:290,w:65,h:10},{x:1700,y:350,w:70,h:10});
movingPlatforms.push({x:600,y:320,w:55,h:10,left:550,right:750,dir:1});
fallingPlatforms.push({x:350,y:340,w:50,h:10,fall:0,timer:0},{x:1200,y:300,w:50,h:10,fall:0,timer:0});
for(let i=0;i<40;i++){let x=40+i*60;let y=H-48;if(i<8)y=H-48;else if(i<16)y=358;else if(i<24)y=308;else if(i<32)y=338;else y=278;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<8;i++){let x=150+i*300;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
enemies.push({x:200,y:H-50,w:14,h:10,dir:1,active:1},{x:500,y:H-55,w:14,h:10,dir:1.2,active:1},{x:800,y:H-48,w:14,h:10,dir:1,active:1},{x:1100,y:H-52,w:14,h:10,dir:1.3,active:1},{x:1400,y:H-45,w:14,h:10,dir:1,active:1},{x:1700,y:H-55,w:14,h:10,dir:1.2,active:1});
powerups.push({x:1000,y:H-55,w:10,h:10,type:'shield',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
if(lvl===3){
platforms.push({x:80,y:380,w:80,h:10},{x:240,y:350,w:65,h:10},{x:400,y:300,w:60,h:10},{x:560,y:360,w:70,h:10},{x:720,y:280,w:55,h:10},{x:880,y:320,w:65,h:10},{x:1040,y:260,w:70,h:10},{x:1200,y:370,w:60,h:10},{x:1360,y:310,w:65,h:10},{x:1520,y:290,w:70,h:10});
movingPlatforms.push({x:400,y:290,w:55,h:10,left:350,right:550,dir:1},{x:1100,y:270,w:55,h:10,left:1000,right:1300,dir:1});
fallingPlatforms.push({x:650,y:330,w:50,h:10,fall:0,timer:0},{x:950,y:290,w:50,h:10,fall:0,timer:0},{x:1450,y:320,w:50,h:10,fall:0,timer:0});
for(let i=0;i<45;i++){let x=30+i*55;let y=H-48;if(i%4===0)y-=15;if(i%4===2)y-=30;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<10;i++){let x=100+i*200;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
for(let i=0;i<20;i++){let x=60+i*100;let y=H-42;if(i%3===0)y-=15;enemies.push({x:x,y:y-5,w:14,h:10,dir:1+(i%3)*0.2,active:1});}
powerups.push({x:1300,y:H-55,w:10,h:10,type:'magnet',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
if(lvl===4){
platforms.push({x:150,y:370,w:70,h:10},{x:320,y:320,w:60,h:10},{x:490,y:360,w:65,h:10},{x:660,y:290,w:70,h:10},{x:830,y:340,w:55,h:10},{x:1000,y:280,w:65,h:10},{x:1170,y:350,w:60,h:10},{x:1340,y:300,w:70,h:10},{x:1510,y:330,w:65,h:10});
for(let i=0;i<50;i++){let x=20+i*45;let y=H-48;if(i%5===0)y-=15;if(i%5===2)y-=30;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<12;i++){let x=100+i*150;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
for(let i=0;i<25;i++){let x=40+i*80;let y=H-42;if(i%4===0)y-=20;enemies.push({x:x,y:y-5,w:14,h:10,dir:1.2+(i%4)*0.1,active:1});}
powerups.push({x:1200,y:H-55,w:10,h:10,type:'jet',active:1},{x:1800,y:H-55,w:10,h:10,type:'shield',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
if(lvl===5){
platforms.push({x:100,y:370,w:70,h:10},{x:300,y:330,w:60,h:10},{x:500,y:310,w:65,h:10},{x:700,y:350,w:70,h:10},{x:900,y:290,w:55,h:10},{x:1100,y:340,w:65,h:10},{x:1300,y:280,w:70,h:10},{x:1500,y:360,w:60,h:10},{x:1700,y:310,w:65,h:10});
movingPlatforms.push({x:450,y:300,w:55,h:10,left:400,right:600,dir:1},{x:1000,y:290,w:55,h:10,left:900,right:1200,dir:1},{x:1550,y:330,w:55,h:10,left:1450,right:1750,dir:1});
for(let i=0;i<55;i++){let x=30+i*45;let y=H-48;if(i%6===0)y-=20;if(i%6===3)y-=40;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<14;i++){let x=120+i*130;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
for(let i=0;i<28;i++){let x=50+i*70;let y=H-42;if(i%5===0)y-=25;enemies.push({x:x,y:y-5,w:14,h:10,dir:1.3+(i%5)*0.1,active:1});}
powerups.push({x:1400,y:H-55,w:10,h:10,type:'magnet',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
if(lvl===6){
platforms.push({x:200,y:370,w:80,h:10},{x:400,y:310,w:70,h:10},{x:600,y:350,w:65,h:10},{x:800,y:280,w:70,h:10},{x:1000,y:330,w:60,h:10},{x:1200,y:290,w:65,h:10},{x:1400,y:360,w:70,h:10},{x:1600,y:310,w:60,h:10},{x:1800,y:340,w:70,h:10},{x:2000,y:280,w:65,h:10},{x:2200,y:330,w:70,h:10});
movingPlatforms.push({x:600,y:320,w:55,h:10,left:550,right:750,dir:1},{x:1500,y:290,w:55,h:10,left:1400,right:1700,dir:1});
fallingPlatforms.push({x:900,y:300,w:50,h:10,fall:0,timer:0},{x:1900,y:320,w:50,h:10,fall:0,timer:0});
for(let i=0;i<65;i++){let x=20+i*40;let y=H-48;if(i%4===0)y-=15;if(i%4===2)y-=35;coins.push({x:x,y:y,w:8,h:8,active:1});}
for(let i=0;i<16;i++){let x=100+i*100;stars.push({x:x,y:H-55,w:10,h:10,active:1});}
for(let i=0;i<32;i++){let x=40+i*60;let y=H-42;if(i%3===0)y-=20;enemies.push({x:x,y:y-5,w:14,h:10,dir:1.4+(i%4)*0.1,active:1});}
enemies.push({x:2400,y:290,w:24,h:18,dir:1,active:1,type:'boss'});
powerups.push({x:800,y:H-55,w:10,h:10,type:'jet',active:1},{x:1800,y:H-55,w:10,h:10,type:'shield',active:1});
flagpole={x:2600,y:H-58,w:12,h:50,active:1};
}
}
function rectCollide(a,b){return!(b.x>a.x+a.w||b.x+b.w<a.x||b.y>a.y+a.h||b.y+b.h<a.y);}
function updateUI(){document.getElementById('sc').innerHTML='❤️ '+player.health+'  🪙 '+player.coins;document.getElementById('starCount').innerHTML='⭐ '+player.starsCollected;document.getElementById('lvl').innerHTML='🌍 '+level+'/6';let pwr='None';if(player.powerup===1)pwr='Jet';if(player.powerup===2)pwr='Shield';if(player.powerup===3)pwr='Magnet';document.getElementById('pwr').innerHTML='⚡ '+pwr;}
function addParticles(x,y,color){for(let i=0;i<5;i++){particles.push({x:x,y:y,vx:(Math.random()-0.5)*3,vy:(Math.random()-0.5)*3-2,life:20,color:color});}}
function damage(){if(player.powerup===2){player.powerup=0;player.powerupTimer=0;return;}player.health--;player.invincible=30;player.vy=-6;screenshake=8;updateUI();if(player.health<=0)gameOver=1;}
function nextLevel(){level++;if(level>6){level=1;resetGame();}else{buildLevel(level);player.x=80;player.y=300;camX=0;levelComplete=0;player.health=Math.min(5,player.health+1);player.starsCollected=0;updateUI();}}
function update(){
if(gameOver){if(J){resetGame();J=0;}return;}
if(levelComplete){return;}
let move=(R-L)*4.5;player.x+=move;player.x=Math.max(8,Math.min(worldW-player.w-8,player.x));
player.vy+=0.48;player.y+=player.vy;player.onGround=0;
for(let p of platforms){if(player.vy>=0&&player.y+player.h>p.y&&player.y+player.h-player.vy<=p.y+8&&player.x+player.w>p.x&&player.x<p.x+p.w){player.y=p.y-player.h;player.vy=0;player.onGround=1;player.doubleJump=1;}else if(player.vy<0&&player.y<p.y+p.h&&player.y-player.vy>=p.y+p.h&&player.x+player.w>p.x&&player.x<p.x+p.w){player.y=p.y+p.h;player.vy=0;}}
for(let m of movingPlatforms){m.x+=m.dir*2;if(m.x<=m.left||m.x+m.w>=m.right)m.dir*=-1;if(player.vy>=0&&player.y+player.h>m.y&&player.y+player.h-player.vy<=m.y+8&&player.x+player.w>m.x&&player.x<m.x+m.w){player.y=m.y-player.h;player.vy=0;player.onGround=1;player.doubleJump=1;player.x+=m.dir*2;}}
for(let f of fallingPlatforms){if(f.active!==0&&!f.fall&&rectCollide(player,f)&&player.vy>=0&&player.y+player.h-f.y<10){f.fall=1;f.timer=10;}if(f.fall){f.timer--;if(f.timer<=0)f.y+=6;if(f.y>H)f.active=0;}}
if(player.y+player.h>H-35){player.y=H-35-player.h;player.vy=0;player.onGround=1;player.doubleJump=1;}
if(player.y>H){damage();player.y=100;player.vy=-6;}
if(J&&(player.onGround||(player.powerup===1&&player.doubleJump>0))){player.vy=-7.5;J=0;if(!player.onGround&&player.powerup===1)player.doubleJump=0;}
if(player.invincible>0)player.invincible--;
if(player.powerupTimer>0){player.powerupTimer--;if(player.powerupTimer<=0)player.powerup=0;}
for(let c of coins){if(c.active&&rectCollide(player,c)){c.active=0;player.coins++;if(player.powerup===3){let nearby=coins.filter(n=>Math.hypot(n.x-player.x,n.y-player.y)<100);nearby.forEach(n=>{if(n.active){n.active=0;player.coins++;}});}updateUI();addParticles(c.x+4,c.y+4,'#fbbf24');}}
for(let s of stars){if(s.active&&rectCollide(player,s)){s.active=0;player.starsCollected++;player.health=Math.min(5,player.health+1);updateUI();addParticles(s.x+5,s.y+5,'#a855f7');}}
for(let p of powerups){if(p.active&&rectCollide(player,p)){p.active=0;if(p.type==='jet'){player.powerup=1;player.powerupTimer=600;}if(p.type==='shield'){player.powerup=2;player.powerupTimer=900;}if(p.type==='magnet'){player.powerup=3;player.powerupTimer=450;}updateUI();}}
if(flagpole&&flagpole.active&&rectCollide(player,flagpole)){levelComplete=1;addParticles(flagpole.x+6,flagpole.y+25,'#4ade80');setTimeout(nextLevel,500);}
for(let e of enemies){if(e.active&&rectCollide(player,e)){let isStomp=player.vy>0&&player.y+player.h-e.y<14;if(isStomp){e.active=0;player.vy=-8;addParticles(e.x+e.w/2,e.y+e.h/2,'#ef4444');}else if(player.invincible===0){damage();addParticles(player.x+7,player.y+7,'#ff0000');}}}
for(let i=0;i<enemies.length;i++){if(!enemies[i].active){enemies.splice(i,1);i--;}}
for(let e of enemies){e.x+=e.dir;if(e.x<e.w||e.x>worldW-e.w-30)e.dir*=-1;}
for(let i=0;i<particles.length;i++){particles[i].x+=particles[i].vx;particles[i].y+=particles[i].vy;particles[i].vy+=0.2;particles[i].life--;if(particles[i].life<=0)particles.splice(i,1);}
if(screenshake>0)screenshake--;
camX=player.x+player.w/2-W/2;camX=Math.max(0,Math.min(worldW-W,camX));
}
function resetGame(){level=1;player={x:80,y:300,w:14,h:14,vy:0,onGround:0,invincible:0,health:3,coins:0,starsCollected:0,powerup:0,powerupTimer:0,doubleJump:1};gameOver=0;levelComplete=0;particles=[];buildLevel(1);updateUI();}
function draw(){ctx.save();if(screenshake>0)ctx.translate((Math.random()-0.5)*4,(Math.random()-0.5)*4);ctx.clearRect(0,0,W,H);ctx.fillStyle='#0f172a';ctx.fillRect(0,0,W,H);for(let i=0;i<50;i++){ctx.fillStyle='#ffffff';ctx.fillRect((i*37+camX*0.3)%W,Math.sin(i)*5+H-100,2,2);}
ctx.fillStyle='#334155';for(let p of platforms){ctx.fillRect(p.x-camX,p.y,p.w,p.h);}
ctx.fillStyle='#4a5568';for(let m of movingPlatforms){ctx.fillRect(m.x-camX,m.y,m.w,m.h);}
ctx.fillStyle='#5a4a6e';for(let f of fallingPlatforms){if(f.active!==0)ctx.fillRect(f.x-camX,f.y,f.w,f.h);}
ctx.fillStyle='#fbbf24';for(let c of coins){if(c.active){ctx.beginPath();ctx.arc(c.x-camX+4,c.y+4,5,0,Math.PI*2);ctx.fill();ctx.fillStyle='#f59e0b';ctx.beginPath();ctx.arc(c.x-camX+4,c.y+4,2.5,0,Math.PI*2);ctx.fill();ctx.fillStyle='#fbbf24';}}
ctx.fillStyle='#ef4444';for(let e of enemies){if(e.active){ctx.fillRect(e.x-camX,e.y,e.w,e.h);ctx.fillStyle='#dc2626';ctx.fillRect(e.x-camX+2,e.y-3,10,4);if(e.type==='boss'){ctx.fillStyle='#991b1b';ctx.fillRect(e.x-camX-3,e.y-6,30,6);ctx.fillStyle='#ef4444';}}}
ctx.fillStyle='#a855f7';for(let s of stars){if(s.active){ctx.fillRect(s.x-camX,s.y,s.w,s.h);ctx.fillStyle='#c084fc';ctx.fillRect(s.x-camX+3,s.y+3,4,4);ctx.fillStyle='#a855f7';}}
ctx.fillStyle='#06b6d4';for(let p of powerups){if(p.active){if(p.type==='jet')ctx.fillStyle='#06b6d4';if(p.type==='shield')ctx.fillStyle='#10b981';if(p.type==='magnet')ctx.fillStyle='#ef4444';ctx.fillRect(p.x-camX,p.y,p.w,p.h);}}
if(flagpole&&flagpole.active){ctx.fillStyle='#ef4444';ctx.fillRect(flagpole.x-camX,flagpole.y,flagpole.w,flagpole.h);ctx.fillStyle='#f97316';ctx.fillRect(flagpole.x-camX+3,flagpole.y-8,6,12);ctx.fillStyle='#fcd34d';ctx.beginPath();ctx.moveTo(flagpole.x-camX+6,flagpole.y-12);ctx.lineTo(flagpole.x-camX+12,flagpole.y-5);ctx.lineTo(flagpole.x-camX+0,flagpole.y-5);ctx.fill();}
if(player.invincible%6<3){ctx.fillStyle='#60a5fa';}else{ctx.fillStyle='#3b82f6';}
if(player.powerup===1)ctx.fillStyle='#00ffff';if(player.powerup===2)ctx.fillStyle='#34d399';
ctx.fillRect(player.x-camX,player.y,player.w,player.h);ctx.fillStyle='#fcd34d';ctx.fillRect(player.x-camX+3,player.y+3,3,3);
for(let p of particles){ctx.fillStyle=p.color;ctx.fillRect(p.x-camX,p.y,2,2);}
ctx.fillStyle='white';ctx.font='bold 10px monospace';ctx.fillText('🪙 x'+player.coins,8,20);ctx.fillText('❤️ x'+player.health,8,35);
if(levelComplete){ctx.fillStyle='rgba(0,0,0,0.6)';ctx.fillRect(0,0,W,H);ctx.fillStyle='#4ade80';ctx.font='bold 20px monospace';ctx.fillText('LEVEL COMPLETE!',W/2-100,H/2);}
if(gameOver){ctx.fillStyle='rgba(0,0,0,0.85)';ctx.fillRect(0,0,W,H);ctx.fillStyle='#fbbf24';ctx.font='bold 24px monospace';ctx.fillText('GAME OVER',W/2-75,H/2-25);ctx.font='12px monospace';ctx.fillText('Tap JUMP to restart',W/2-75,H/2+10);}
ctx.restore();}
function gameLoop(){update();draw();requestAnimationFrame(gameLoop);}
buildLevel(1);updateUI();gameLoop();
</script>
CUSTOMHTML-END

TEXT: *Reach the FLAGPOLE at the end of each level! Jump on enemies to defeat them. Collect stars to heal. 6 levels!*
