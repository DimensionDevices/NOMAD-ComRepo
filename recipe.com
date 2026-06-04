PAGE: Recipe Box
COLOR: #e67e22
AUTHOR: Cook
DATE: 2026-06-02
DESCRIPTION: A recipe book for all your favourite recipes
CATEGORY: info

CUSTOMHTML-START
<h1 style="padding:8px 0 0 0;margin-bottom:12px;font-size:1.8rem">NOMAD Recipe Box</h1>
CUSTOMHTML-END

DIVIDER

HEADER: Active Recipe

CUSTOMHTML-START
<style>
*{box-sizing:border-box}
body{margin:0;padding:20px;max-width:1600px;margin:0 auto}
.recipe-editor{background:#fff;border-radius:16px;padding:24px;margin:16px 0;box-shadow:0 2px 8px rgba(0,0,0,.1)}
.recipe-card{background:#fff;border-radius:12px;padding:20px;box-shadow:0 1px 3px rgba(0,0,0,0.1);margin-bottom:12px}
.recipe-header{display:flex;justify-content:space-between;align-items:start;flex-wrap:wrap;gap:8px}
.recipe-title{color:#2d1810;margin:0;font-size:1.3rem}
.btn-sm{padding:4px 12px;border:none;border-radius:20px;font-size:0.75rem;cursor:pointer}
.btn-edit{background:#3498db;color:white}
.btn-delete{background:#e74c3c;color:white}
.btn-add{background:#e67e22;color:#fff;border:none;border-radius:8px;padding:8px 16px;cursor:pointer}
.btn-save{background:#27ae60;color:#fff;border:none;border-radius:12px;padding:12px;font-weight:700;cursor:pointer;flex:1}
.btn-clear{background:#95a5a6;color:#fff;border:none;border-radius:12px;padding:12px 20px;cursor:pointer}
.ingredient-item,.instruction-item{display:flex;gap:8px;margin-bottom:6px;align-items:center}
.ingredient-text,.instruction-text{flex:1}
.remove-btn{background:#e74c3c;color:white;border:none;border-radius:20px;padding:2px 10px;font-size:0.7rem;cursor:pointer}
.empty-recipes{padding:40px;text-align:center;color:#999;background:#f8f9fa;border-radius:16px}
input,textarea{width:100%;padding:12px;border:2px solid #e2e8f0;border-radius:12px;font-size:1rem}
input:focus,textarea:focus{outline:none;border-color:#e67e22}
.grid-2col{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:24px;align-items:start}
@media(min-width:1000px){.grid-2col{grid-template-columns:1fr 1fr}}
</style>

<div class="grid-2col">
  <!-- Left column: Editor -->
  <div>
    <div class="recipe-editor">
      <input type="text" id="recipeName" placeholder="Recipe name">
      
      <div style="margin:16px 0">
        <label style="font-weight:700">Ingredients:</label>
        <div id="ingredientsList"></div>
        <div style="display:flex;gap:8px;margin-top:8px">
          <input type="text" id="newIngredient" placeholder="e.g., 2 cups flour">
          <button class="btn-add" onclick="addIngredient()">+</button>
        </div>
      </div>
      
      <div style="margin:16px 0">
        <label style="font-weight:700">Instructions:</label>
        <div id="instructionsList"></div>
        <div style="display:flex;gap:8px;margin-top:8px">
          <input type="text" id="newInstruction" placeholder="Step...">
          <button class="btn-add" onclick="addInstruction()">+</button>
        </div>
      </div>
      
      <div style="display:flex;gap:12px;margin-top:24px">
        <button class="btn-save" onclick="saveRecipe()">💾 Save Recipe</button>
        <button class="btn-clear" onclick="clearForm()">Clear</button>
      </div>
    </div>
  </div>
  
  <!-- Right column: Recipe list -->
  <div>
    <div id="recipeList"></div>
  </div>
</div>

<script>
let currentEditId = null;

function loadRecipes() {
  const recipes = JSON.parse(localStorage.getItem("recipes") || "[]");
  const container = document.getElementById("recipeList");
  if (!container) return;
  
  if (recipes.length === 0) {
    container.innerHTML = '<div class="empty-recipes">🍽️ No recipes yet — create one on the left!</div>';
    return;
  }
  
  container.innerHTML = recipes.map((recipe, idx) => `
    <div class="recipe-card">
      <div class="recipe-header">
        <h3 class="recipe-title">${escapeHtml(recipe.name)}</h3>
        <div style="display:flex;gap:6px">
          <button class="btn-sm btn-edit" onclick="editRecipe(${idx})">✏️ Edit</button>
          <button class="btn-sm btn-delete" onclick="deleteRecipe(${idx})">🗑️ Delete</button>
        </div>
      </div>
      <div style="margin-top:12px;font-size:0.85rem;color:#666">
        <strong>${recipe.ingredients.length} ingredients</strong> · 
        <strong>${recipe.instructions.length} steps</strong>
      </div>
      <details style="margin-top:10px">
        <summary style="cursor:pointer;color:#e67e22;font-size:0.8rem">View recipe →</summary>
        <div style="margin-top:12px;padding-top:12px;border-top:1px solid #eee">
          <strong>Ingredients:</strong>
          <ul style="margin:8px 0 8px 20px">${recipe.ingredients.map(i => `<li>${escapeHtml(i)}</li>`).join("")}</ul>
          <strong>Instructions:</strong>
          <ol style="margin:8px 0 8px 20px">${recipe.instructions.map(i => `<li>${escapeHtml(i)}</li>`).join("")}</ol>
        </div>
      </details>
    </div>
  `).join("");
}

function escapeHtml(str) {
  if (!str) return "";
  return str.replace(/[&<>]/g, function(m) {
    if (m === "&") return "&amp;";
    if (m === "<") return "&lt;";
    if (m === ">") return "&gt;";
    return m;
  });
}

function addIngredient() {
  const input = document.getElementById("newIngredient");
  const val = input.value.trim();
  if (!val) return;
  
  const container = document.getElementById("ingredientsList");
  const div = document.createElement("div");
  div.className = "ingredient-item";
  div.innerHTML = `
    <span class="ingredient-text">• ${escapeHtml(val)}</span>
    <button class="remove-btn" onclick="this.parentElement.remove()">✗</button>
  `;
  container.appendChild(div);
  input.value = "";
}

function addInstruction() {
  const input = document.getElementById("newInstruction");
  const val = input.value.trim();
  if (!val) return;
  
  const container = document.getElementById("instructionsList");
  const stepNum = container.children.length + 1;
  const div = document.createElement("div");
  div.className = "instruction-item";
  div.innerHTML = `
    <span class="instruction-text">${stepNum}. ${escapeHtml(val)}</span>
    <button class="remove-btn" onclick="this.parentElement.remove(); renumberInstructions()">✗</button>
  `;
  container.appendChild(div);
  input.value = "";
}

function renumberInstructions() {
  const items = document.querySelectorAll("#instructionsList .instruction-item");
  items.forEach((item, idx) => {
    const span = item.querySelector(".instruction-text");
    if (span) {
      const text = span.textContent.replace(/^\d+\.\s*/, "");
      span.textContent = `${idx + 1}. ${text}`;
    }
  });
}

function collectCurrentRecipe() {
  const ingredients = Array.from(document.querySelectorAll("#ingredientsList .ingredient-text"))
    .map(span => span.textContent.replace(/^•\s*/, "").trim())
    .filter(i => i);
  
  const instructions = Array.from(document.querySelectorAll("#instructionsList .instruction-text"))
    .map(span => span.textContent.replace(/^\d+\.\s*/, "").trim())
    .filter(i => i);
  
  return {
    name: document.getElementById("recipeName").value.trim(),
    ingredients: ingredients,
    instructions: instructions
  };
}

function loadRecipeIntoForm(recipe) {
  document.getElementById("recipeName").value = recipe.name || "";
  
  const ingredientsContainer = document.getElementById("ingredientsList");
  ingredientsContainer.innerHTML = "";
  (recipe.ingredients || []).forEach(ing => {
    const div = document.createElement("div");
    div.className = "ingredient-item";
    div.innerHTML = `
      <span class="ingredient-text">• ${escapeHtml(ing)}</span>
      <button class="remove-btn" onclick="this.parentElement.remove()">✗</button>
    `;
    ingredientsContainer.appendChild(div);
  });
  
  const instructionsContainer = document.getElementById("instructionsList");
  instructionsContainer.innerHTML = "";
  (recipe.instructions || []).forEach((inst, idx) => {
    const div = document.createElement("div");
    div.className = "instruction-item";
    div.innerHTML = `
      <span class="instruction-text">${idx + 1}. ${escapeHtml(inst)}</span>
      <button class="remove-btn" onclick="this.parentElement.remove(); renumberInstructions()">✗</button>
    `;
    instructionsContainer.appendChild(div);
  });
}

function saveRecipe() {
  const recipe = collectCurrentRecipe();
  
  if (!recipe.name) {
    alert("Please enter a recipe name");
    return;
  }
  if (recipe.ingredients.length === 0) {
    alert("Please add at least one ingredient");
    return;
  }
  if (recipe.instructions.length === 0) {
    alert("Please add at least one instruction step");
    return;
  }
  
  const recipes = JSON.parse(localStorage.getItem("recipes") || "[]");
  
  if (currentEditId !== null) {
    recipes[currentEditId] = recipe;
    currentEditId = null;
  } else {
    recipes.push(recipe);
  }
  
  localStorage.setItem("recipes", JSON.stringify(recipes));
  clearForm();
  loadRecipes();
  
  const btn = event.target;
  const originalText = btn.textContent;
  btn.textContent = "✓ Saved!";
  setTimeout(() => { if (btn) btn.textContent = originalText; }, 1500);
}

function editRecipe(idx) {
  const recipes = JSON.parse(localStorage.getItem("recipes") || "[]");
  const recipe = recipes[idx];
  if (recipe) {
    loadRecipeIntoForm(recipe);
    document.getElementById("recipeName").focus();
    currentEditId = idx;
    document.querySelector(".recipe-editor").scrollIntoView({ behavior: "smooth" });
  }
}

function deleteRecipe(idx) {
  if (confirm("Delete this recipe?")) {
    const recipes = JSON.parse(localStorage.getItem("recipes") || "[]");
    recipes.splice(idx, 1);
    localStorage.setItem("recipes", JSON.stringify(recipes));
    
    if (currentEditId === idx) {
      clearForm();
    } else if (currentEditId > idx) {
      currentEditId--;
    }
    
    loadRecipes();
  }
}

function clearForm() {
  document.getElementById("recipeName").value = "";
  document.getElementById("ingredientsList").innerHTML = "";
  document.getElementById("instructionsList").innerHTML = "";
  currentEditId = null;
}

loadRecipes();
</script>
CUSTOMHTML-END
