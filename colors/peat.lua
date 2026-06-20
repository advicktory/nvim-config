-- ~/.config/nvim/colors/peat.lua
-- Muted, warm, low-contrast — like reading by candlelight
vim.cmd("highlight clear")
vim.g.colors_name = "peat"
local hl = vim.api.nvim_set_hl

local gold   = "#C5E99B"  -- pale gold (primary)
local moss   = "#6DA34D"
local teal   = "#548687"
local rust   = "#8a5a44"  -- warm brownish rust
local white  = "#e8dcc8"  -- warm paper white
local red    = "#ff7b7b"
local grey   = "#9a9280"
local fade   = "#4a4038"

local bg_none  = "NONE"
local surface  = "#1a1814"
local border   = "#3a3830"
local dark     = "#0a0804"

-- Base
hl(0, "Normal",       { fg = white, bg = bg_none })
hl(0, "NormalFloat",  { fg = white, bg = surface })
hl(0, "NonText",      { fg = border })
hl(0, "CursorLine",   { bg = surface })
hl(0, "CursorLineNr", { fg = gold, bold = true })
hl(0, "LineNr",       { fg = fade })
hl(0, "SignColumn",   { bg = bg_none })
hl(0, "VertSplit",    { fg = border, bg = bg_none })
hl(0, "StatusLine",   { fg = white, bg = surface })

-- Syntax
hl(0, "Comment",    { fg = grey, italic = true })
hl(0, "String",     { fg = white })
hl(0, "Number",     { fg = gold })
hl(0, "Boolean",    { fg = gold, bold = true })
hl(0, "Function",   { fg = gold })
hl(0, "Keyword",    { fg = rust, bold = true })
hl(0, "Conditional",{ fg = rust, bold = true })
hl(0, "Repeat",     { fg = rust, bold = true })
hl(0, "Operator",   { fg = moss })
hl(0, "Type",       { fg = teal })
hl(0, "Include",    { fg = rust })
hl(0, "PreProc",    { fg = gold })
hl(0, "Special",    { fg = moss })
hl(0, "Constant",   { fg = gold })
hl(0, "Todo",       { fg = gold, bold = true })

-- Treesitter
hl(0, "@variable",          { fg = white })
hl(0, "@variable.builtin",  { fg = gold })
hl(0, "@variable.parameter",{ fg = grey })
hl(0, "@function",          { fg = gold })
hl(0, "@function.builtin",  { fg = gold, bold = true })
hl(0, "@function.call",     { fg = gold })
hl(0, "@method",            { fg = gold })
hl(0, "@keyword",           { fg = rust, bold = true })
hl(0, "@keyword.function",  { fg = rust, bold = true })
hl(0, "@keyword.return",    { fg = rust, bold = true })
hl(0, "@type",              { fg = teal })
hl(0, "@type.builtin",      { fg = teal, bold = true })
hl(0, "@string",            { fg = white })
hl(0, "@number",            { fg = gold })
hl(0, "@boolean",           { fg = gold, bold = true })
hl(0, "@constant",          { fg = gold })
hl(0, "@constant.builtin",  { fg = gold, bold = true })
hl(0, "@comment",           { fg = grey, italic = true })
hl(0, "@property",          { fg = teal })
hl(0, "@namespace",         { fg = teal })
hl(0, "@parameter",         { fg = grey })
hl(0, "@punctuation.delimiter", { fg = grey })
hl(0, "@punctuation.bracket",   { fg = grey })
hl(0, "@label",             { fg = grey })

-- UI
hl(0, "Pmenu",      { fg = white, bg = surface })
hl(0, "PmenuSel",   { fg = dark, bg = gold, bold = true })
hl(0, "Search",     { fg = dark, bg = white })
hl(0, "IncSearch",  { fg = dark, bg = gold, bold = true })
hl(0, "CurSearch",  { fg = dark, bg = gold })
hl(0, "Visual",     { bg = "#2a2818" })
hl(0, "MatchParen", { fg = gold, bold = true })
hl(0, "Directory",  { fg = teal, bold = true })
hl(0, "Title",      { fg = gold, bold = true })
hl(0, "WinSeparator", { fg = border })
hl(0, "FloatBorder",  { fg = border })
hl(0, "DiagnosticError",  { fg = red })
hl(0, "DiagnosticWarn",   { fg = gold })
hl(0, "DiagnosticInfo",   { fg = teal })
hl(0, "DiagnosticHint",   { fg = grey })
