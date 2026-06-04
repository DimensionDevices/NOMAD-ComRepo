PAGE: D&D Character Generator
COLOR: #e67e22
AUTHOR: NOMAD User
DATE: 2026-06-03
DESCRIPTION: Roll a random D&D 5e character with stats.
CATEGORY: app

BIGHEADER: D&D Character Generator

TEXT: Click the button below to generate a unique Level 1 character with ability scores, race, class, personality traits, and a quick backstory. Perfect for one-shots or inspiration.

BUTTON: Generate New Character | javascript:generateChar()

DIVIDER

# Character Generator Widget
CUSTOMHTML-START
<div id="dnd-card" class="char-card">
  <div class="char-name">⚔️ GENERATE YOUR HERO ⚔️</div>
  <div class="char-stats" id="stats-area">—</div>
  <div class="char-details" id="details-area">Click the orange button to roll a character</div>
</div>
<style>
/* minified CSS inside CUSTOMHTML block - stays compact */
*,h1,h2,h3{color:white;}.char-card{background:#2c282b;border-radius:1.2rem;padding:1.2rem;margin:1rem 0;border-left:5px solid #e67e22;box-shadow:0 6px 14px rgba(0,0,0,0.3);}
.char-name{font-size:1.6rem;font-weight:bold;margin-bottom:0.8rem;color:#f39c12;text-align:center;border-bottom:1px solid #4a4549;padding-bottom:0.5rem;}
.char-stats{display:grid;grid-template-columns:repeat(6,1fr);gap:0.6rem;margin:1rem 0;text-align:center;}
.stat-item{background:#3a3539;padding:0.5rem;border-radius:0.8rem;}
.stat-label{font-size:0.7rem;text-transform:uppercase;color:#bbb;}
.stat-value{font-size:1.6rem;font-weight:800;color:#e67e22;line-height:1.2;}
.char-details{background:#201d1f;padding:1rem;border-radius:1rem;margin-top:0.8rem;font-size:0.9rem;}
.roll-mod{font-size:0.7rem;color:#aaa;}
hr{margin:0.8rem 0;border-color:#4a4549;}
@media (max-width:550px){.char-stats{grid-template-columns:repeat(3,1fr);gap:0.5rem;}}
</style>

<script>
// Minified JS — full random 5e character generator (races, classes, abilities, traits)
(function(){
    // ---------- ABILITY SCORES (standard array shuffled + possible +2 racial) but we do 4d6 drop lowest style for fun
    function rollAbility() {
        let rolls = Array.from({length:4}, ()=>Math.floor(Math.random()*6)+1);
        rolls.sort((a,b)=>b-a);
        return rolls[0]+rolls[1]+rolls[2];
    }
    function generateAbilities() {
        return {
            str: rollAbility(), dex: rollAbility(), con: rollAbility(),
            int: rollAbility(), wis: rollAbility(), cha: rollAbility()
        };
    }

    // Races (with ASI and traits flavor)
    const races = [
        { name: "Dwarf", asi: "con", mod: 2, traits: "Darkvision, Dwarven Resilience, Tool Proficiency" },
        { name: "Elf", asi: "dex", mod: 2, traits: "Darkvision, Fey Ancestry, Trance" },
        { name: "Halfling", asi: "dex", mod: 2, traits: "Lucky, Brave, Nimble" },
        { name: "Human", asi: "all", mod: 1, traits: "Versatile, +1 to all ability scores" },
        { name: "Dragonborn", asi: "str", mod: 2, traits: "Draconic Ancestry, Breath Weapon" },
        { name: "Gnome", asi: "int", mod: 2, traits: "Gnome Cunning, Artificer's Lore" },
        { name: "Half-Elf", asi: "cha", mod: 2, traits: "Fey Ancestry, Skill Versatility, +1 to two other stats" },
        { name: "Half-Orc", asi: "str", mod: 2, traits: "Relentless Endurance, Savage Attacks" },
        { name: "Tiefling", asi: "cha", mod: 2, traits: "Hellish Resistance, Infernal Legacy" }
    ];
    // Classes
    const classes = [
        { name: "Fighter", hitDie: 10, primary: "str", flavor: "Combat expert, Action Surge" },
        { name: "Wizard", hitDie: 6, primary: "int", flavor: "Arcane spellbook, ritual casting" },
        { name: "Rogue", hitDie: 8, primary: "dex", flavor: "Sneak Attack, thieves' cant" },
        { name: "Cleric", hitDie: 8, primary: "wis", flavor: "Divine magic, Channel Divinity" },
        { name: "Barbarian", hitDie: 12, primary: "str", flavor: "Rage, Unarmored Defense" },
        { name: "Bard", hitDie: 8, primary: "cha", flavor: "Spellcasting, Bardic Inspiration" },
        { name: "Ranger", hitDie: 10, primary: "dex", flavor: "Favored Foe, Natural Explorer" },
        { name: "Paladin", hitDie: 10, primary: "str", flavor: "Divine Smite, Lay on Hands" },
        { name: "Druid", hitDie: 8, primary: "wis", flavor: "Wild Shape, Druidic" },
        { name: "Sorcerer", hitDie: 6, primary: "cha", flavor: "Metamagic, Wild Magic" }
    ];
    // random background & personality
    const backgrounds = [
        "Acolyte", "Criminal", "Folk Hero", "Noble", "Sage", "Sailor", "Soldier", "Urchin", "Outlander", "Entertainer"
    ];
    const traitsPool = [
        "I'm always polite and respectful.", "I hide scraps of food in my pockets.", "I quote sacred texts constantly.",
        "I have a dark sense of humor.", "I'm convinced of my own destiny.", "I'm a hopeless romantic.",
        "I'm stubborn and never back down.", "I trust my gut over logic.", "I collect unusual trinkets."
    ];
    const ideals = ["Fairness.","Greater Good.","Freedom.","Power.","Tradition.","Change.","Creativity.","Honor."];
    const bonds = ["I would die for my companions.","Lost family heirloom.","Protect a sacred grove.","Revenge against a rival.","I owe a debt."];
    const flaws = ["I'm too greedy.","I trust easily.","I have a temper.","I'm secretly insecure.","Addicted to gambling."];

    function applyRacialBonus(abilities, race) {
        let newAb = {...abilities};
        if(race.asi === "all") {
            newAb.str += race.mod; newAb.dex += race.mod; newAb.con += race.mod;
            newAb.int += race.mod; newAb.wis += race.mod; newAb.cha += race.mod;
        } else {
            newAb[race.asi] += race.mod;
            // half-elf specific: +1 to two other stats
            if(race.name === "Half-Elf") {
                let candidates = ["str","dex","con","int","wis","cha"].filter(s => s !== "cha");
                let first = candidates[Math.floor(Math.random()*candidates.length)];
                let second;
                do { second = candidates[Math.floor(Math.random()*candidates.length)]; } while(second === first);
                newAb[first] += 1;
                newAb[second] += 1;
            }
        }
        // ensure scores not above 20 (just cap)
        for(let k in newAb) if(newAb[k] > 20) newAb[k] = 20;
        return newAb;
    }

    function getModifier(score) {
        return Math.floor((score-10)/2);
    }

    function generateCharacter() {
        let rawAbilities = generateAbilities();
        let randomRace = races[Math.floor(Math.random()*races.length)];
        let finalAbilities = applyRacialBonus(rawAbilities, randomRace);
        let characterClass = classes[Math.floor(Math.random()*classes.length)];
        let background = backgrounds[Math.floor(Math.random()*backgrounds.length)];
        let personality = traitsPool[Math.floor(Math.random()*traitsPool.length)];
        let ideal = ideals[Math.floor(Math.random()*ideals.length)];
        let bond = bonds[Math.floor(Math.random()*bonds.length)];
        let flaw = flaws[Math.floor(Math.random()*flaws.length)];
        
        // random name list (quick)
        let firstNames = ["Aric","Brenna","Corvin","Dagny","Eldrin","Fenris","Greta","Harlan","Iris","Jasper","Kaelen","Lyra","Marius","Nyx","Orin","Pippin","Quinn","Runa","Soren","Tamsin"];
        let lastNames = ["Ironfoot","Stormwind","Moonshadow","Ashford","Blackthorn","Embervale","Greycastle","Swiftarrow","Wintermoon","Hollowleaf"];
        let fullName = firstNames[Math.floor(Math.random()*firstNames.length)] + " " + lastNames[Math.floor(Math.random()*lastNames.length)];
        
        // compute HP (max at lvl 1: hit die + con mod)
        let conMod = getModifier(finalAbilities.con);
        let hp = characterClass.hitDie + (conMod > 0 ? conMod : 0);
        if(hp < 1) hp = 1;
        
        // proficiency bonus +2 at lvl1, build attack mod example
        let primaryMod = getModifier(finalAbilities[characterClass.primary]);
        let attackBonus = 2 + primaryMod;
        let savingThrow = characterClass.primary.toUpperCase();
        
        // race traits string
        let raceTraits = randomRace.traits;
        
        // build detail text
        let details = `🎭 ${fullName}  |  ${randomRace.name} ${characterClass.name}  |  Level 1\n`;
        details += `❤️ HP: ${hp}  |  AC: ${10 + getModifier(finalAbilities.dex)}  |  Initiative: ${getModifier(finalAbilities.dex)}\n`;
        details += `⚔️ Attack: +${attackBonus} (${characterClass.primary.toUpperCase()})  |  🛡️ Saving Throw: ${savingThrow}\n`;
        details += `📖 Background: ${background}  |  ✨ Racial: ${raceTraits}\n`;
        details += `💬 Trait: "${personality}"  |  Ideal: ${ideal}  |  Bond: ${bond}  |  Flaw: ${flaw}\n`;
        details += `🔮 Class feature: ${characterClass.flavor}`;
        
        return { name: fullName, race: randomRace.name, className: characterClass.name, abilities: finalAbilities, details, hp, attackBonus, raceObj: randomRace };
    }
    
    function renderCharacter() {
        let char = generateCharacter();
        let ab = char.abilities;
        // ability scores display
        let statsHtml = `
            <div class="stat-item"><div class="stat-label">STR</div><div class="stat-value">${ab.str}</div><div class="roll-mod">(${getModifier(ab.str)})</div></div>
            <div class="stat-item"><div class="stat-label">DEX</div><div class="stat-value">${ab.dex}</div><div class="roll-mod">(${getModifier(ab.dex)})</div></div>
            <div class="stat-item"><div class="stat-label">CON</div><div class="stat-value">${ab.con}</div><div class="roll-mod">(${getModifier(ab.con)})</div></div>
            <div class="stat-item"><div class="stat-label">INT</div><div class="stat-value">${ab.int}</div><div class="roll-mod">(${getModifier(ab.int)})</div></div>
            <div class="stat-item"><div class="stat-label">WIS</div><div class="stat-value">${ab.wis}</div><div class="roll-mod">(${getModifier(ab.wis)})</div></div>
            <div class="stat-item"><div class="stat-label">CHA</div><div class="stat-value">${ab.cha}</div><div class="roll-mod">(${getModifier(ab.cha)})</div></div>
        `;
        let headerName = `${char.name} • ${char.race} ${char.className}`;
        document.getElementById("dnd-card").querySelector(".char-name").innerHTML = `${headerName}`;
        document.getElementById("stats-area").innerHTML = statsHtml;
        document.getElementById("details-area").innerHTML = `<div style="white-space: pre-line;">${char.details}</div>`;
    }
    
    window.generateChar = function() {
        renderCharacter();
    };
    // initial load: generate first character automatically
    window.addEventListener("DOMContentLoaded", () => {
        renderCharacter();
    });
})();
</script>
CUSTOMHTML-END

DIVIDER

HEADER: 📜 How to Use

TEXT: This generator uses **official-style 4d6 drop lowest** for ability scores with racial adjustments. It creates a unique Level 1 D&D character each time you press **Generate New Character**. All data is randomly selected from races (9 options), classes (10 options), backgrounds, personality traits, ideals, bonds, and flaws — every click brings a fresh hero.

CARD-START
**⚡ Pro Tip:** If you want to re-roll but keep certain traits, click the generator multiple times until you find the perfect match. The file stays under 20KB, minified CSS/JS, fully functional on NOMAD devices.
CARD-END

STYLE-START
/* additional global styling for consistency - minified */
body { background: #1a1618; }
.char-card .stat-item { transition: 0.1s ease; }
.btn-orange { background: #e67e22 !important; }
button { background: #e67e22; font-weight: bold; cursor: pointer; border: none; padding: 0.6rem 1.2rem; border-radius: 2rem; color: #fff; }
button:active { transform: scale(0.97); }
STYLE-END

