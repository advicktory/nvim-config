-- ~/.config/nvim/lua/config/keymaps.lua
-- JSON was: physical_key → os_character
-- This remaps: os_character → physical_key (your fingers, vim commands)
-- Apply to normal, visual, operator-pending modes

vim.opt.clipboard = "unnamedplus" -- yank to system clipboard too

-- ═══════════════════════════════════════════════════════════════════════
-- NAVIGATION MENU: spc spc + jkl;  (j=← k=↓ l=↑ ;=→ in ALL panels)
-- phys jkl; → OS n i o l, so bindings use those OS chars
-- ═══════════════════════════════════════════════════════════════════════
vim.keymap.set("n", "<leader><leader>n", "<C-w>h", { desc = "Focus left" })
vim.keymap.set("n", "<leader><leader>i", "<C-w>k", { desc = "Focus up" })
vim.keymap.set("n", "<leader><leader>o", "<C-w>j", { desc = "Focus down" })
vim.keymap.set("n", "<leader><leader>l", "<C-w>l", { desc = "Focus right" })
vim.keymap.set("n", "<leader><leader>v", "<C-w>v", { desc = "Vertical split" })
vim.keymap.set("n", "<leader><leader>s", "<C-w>s", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader><leader>w", "<C-w>c", { desc = "Close window" })
vim.keymap.set("n", "<leader><leader>c", "<C-w>w", { desc = "Cycle windows" })

-- ═══════════════════════════════════════════════════════════════════════
-- PHYSICAL KEYBOARD REMAPS (os_char → vim_action)
-- ═══════════════════════════════════════════════════════════════════════
local remaps = {
  e = "d",       -- physical d → os e → vim d (delete)
  d = "d",       -- physical e → os d → vim d (delete)  ← ee = dd
  r = "f",       -- physical f → os r → vim f
  t = "g",       -- physical g → os t → vim g
  k = "i",       -- physical i → os k → vim i (insert)
  n = "h",       -- physical j → os n → left
  i = "j",       -- physical k → os i → down
  o = "k",       -- physical l → os o → up
  j = "m",       -- physical m → os j → vim m
  ["/"] = "n",   -- physical n → os / → vim n (next search)
  y = "y",       -- physical o → os y → vim y (yank)
  [","] = ".",   -- physical period → os , → vim . (repeat)
  [";"] = "'",   -- physical quote → os ; → vim ' (mark)
  f = "r",       -- physical r → os f → vim r (replace)
  z = "t",       -- physical t → os z → vim t (till)
  ["'"] = "o",   -- physical ' → os ' → vim o (new line below)
  ["\""] = "O",  -- physical Shift+' → os " → vim O (new line above)
  g = "g",       -- physical z (in g position) → os g → vim g (goto)
  l = "l",       -- physical semicolon → os l → vim l (right)
  ["."] = "/",   -- physical slash → os . → vim / (search)
  m = ",",       -- physical comma → os m → vim , (reverse search)
  ["T"] = "G",   -- physical Shift+g → os T → vim G (go to bottom)
}

for _, mode in ipairs({ "n", "v", "o" }) do
  for from, to in pairs(remaps) do
    vim.keymap.set(mode, from, to, { noremap = true, silent = true })
  end
end

-- :q = force quit (only when exactly :q, not :qa / :quit)
vim.cmd([[cnoreabbrev <expr> q (getcmdtype() == ':' && getcmdline() == 'q') ? 'q!' : 'q']])

-- Search navigation: Enter = next match, Shift+Enter = prev match
-- (phys n is remapped to left, so use Enter instead of n/N after / or ?)
vim.keymap.set("n", "<CR>", "nzz", { desc = "Next search match + center" })
vim.keymap.set("n", "<S-CR>", "Nzz", { desc = "Prev search match + center" })
