-- ~/.config/nvim/colors/lichen.lua
-- Warm green + terracotta palette
vim.cmd("highlight clear")
vim.g.colors_name = "lichen"
local hl = vim.api.nvim_set_hl

local green  = "#6DA34D"
local terra  = "#C47E5A"  -- warm terracotta
local teal   = "#548687"
local cream  = "#C5E99B"
local white  = "#e8ecd8"
local red    = "#ff7b7b"
local grey   = "#8a9680"
local fade   = "#3a4038"

local bg_none  = "NONE"
local surface  = "#1a1e18"
local border   = "#2a3030"
local dark     = "#0a0d08"

-- Base
hl(0, "Normal",       { fg = white, bg = bg_none })
hl(0, "NormalFloat",  { fg = white, bg = surface })
hl(0, "NonText",      { fg = border })
hl(0, "CursorLine",   { bg = surface })
hl(0, "CursorLineNr", { fg = green, bold = true })
hl(0, "LineNr",       { fg = fade })
hl(0, "SignColumn",   { bg = bg_none })
hl(0, "VertSplit",    { fg = border, bg = bg_none })
hl(0, "StatusLine",   { fg = white, bg = surface })
hl(0, "StatusLineNC", { fg = grey, bg = surface })

-- Syntax
hl(0, "Comment",    { fg = grey, italic = true })
hl(0, "String",     { fg = white })
hl(0, "Number",     { fg = cream })
hl(0, "Boolean",    { fg = cream, bold = true })
hl(0, "Function",   { fg = green })
hl(0, "Keyword",    { fg = terra, bold = true })
hl(0, "Conditional",{ fg = terra, bold = true })
hl(0, "Repeat",     { fg = terra, bold = true })
hl(0, "Operator",   { fg = green })
hl(0, "Type",       { fg = teal })
hl(0, "Include",    { fg = terra })
hl(0, "PreProc",    { fg = cream })
hl(0, "Special",    { fg = terra })
hl(0, "Constant",   { fg = cream })
hl(0, "Error",      { fg = red, bold = true })
hl(0, "Todo",       { fg = cream, bold = true })

-- Treesitter
hl(0, "@variable",          { fg = white })
hl(0, "@variable.builtin",  { fg = cream })
hl(0, "@variable.parameter",{ fg = grey })
hl(0, "@function",          { fg = green })
hl(0, "@function.builtin",  { fg = green, bold = true })
hl(0, "@function.call",     { fg = green })
hl(0, "@method",            { fg = green })
hl(0, "@keyword",           { fg = terra, bold = true })
hl(0, "@keyword.function",  { fg = terra, bold = true })
hl(0, "@keyword.return",    { fg = terra, bold = true })
hl(0, "@type",              { fg = teal })
hl(0, "@type.builtin",      { fg = teal, bold = true })
hl(0, "@string",            { fg = white })
hl(0, "@number",            { fg = cream })
hl(0, "@boolean",           { fg = cream, bold = true })
hl(0, "@constant",          { fg = cream })
hl(0, "@constant.builtin",  { fg = cream, bold = true })
hl(0, "@comment",           { fg = grey, italic = true })
hl(0, "@property",          { fg = teal })
hl(0, "@namespace",         { fg = teal })
hl(0, "@parameter",         { fg = grey })
hl(0, "@punctuation.delimiter", { fg = grey })
hl(0, "@punctuation.bracket",   { fg = grey })
hl(0, "@label",             { fg = grey })

-- UI
hl(0, "Pmenu",      { fg = white, bg = surface })
hl(0, "PmenuSel",   { fg = dark, bg = green, bold = true })
hl(0, "Search",     { fg = dark, bg = cream })
hl(0, "IncSearch",  { fg = dark, bg = green, bold = true })
hl(0, "CurSearch",  { fg = dark, bg = green })
hl(0, "Visual",     { bg = "#2a3828" })
hl(0, "MatchParen", { fg = green, bold = true })
hl(0, "Directory",  { fg = teal, bold = true })
hl(0, "Title",      { fg = green, bold = true })
hl(0, "WinSeparator", { fg = border })
hl(0, "FloatBorder",  { fg = border })
hl(0, "DiagnosticError",  { fg = red })
hl(0, "DiagnosticWarn",   { fg = cream })
hl(0, "DiagnosticInfo",   { fg = teal })
hl(0, "DiagnosticHint",   { fg = grey })
