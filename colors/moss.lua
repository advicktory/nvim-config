-- ~/.config/nvim/colors/moss.lua
-- Core palette: #6DA34D #56445D #548687 #8FBC94 #C5E99B
-- Extended with white + derivatives

vim.cmd("highlight clear")
vim.g.colors_name = "moss"

local hl = vim.api.nvim_set_hl

-- Palette
local moss   = "#6DA34D"  -- earthy green (primary accent)
local mauve  = "#56445D"  -- muted purple (keywords, structure)
local teal   = "#548687"  -- teal (types, directories)
local sage   = "#8FBC94"  -- soft sage (comments, secondary)
local pale   = "#C5E99B"  -- pale yellow-green (numbers, warnings)
local white  = "#e8ecd8"  -- soft white (strings, foreground)
local gold   = "#d4b850"  -- warm gold (function names, important)
local grey   = "#8a9680"  -- muted grey (punctuation, secondary)
local red    = "#ff7b7b"  -- errors

-- Derived
local bg_subtle = "#121510"
local fg        = white
local fg_dim    = "#8a9680"
local surface   = "#1a1e18"
local border    = "#2a3030"
local dark      = "#0a0d08"

-- ═══════════════════════════════════════════════════════
-- BASE
-- ═══════════════════════════════════════════════════════
hl(0, "Normal",        { fg = fg, bg = "NONE" })
hl(0, "NormalFloat",   { fg = fg, bg = bg_subtle })
hl(0, "NonText",       { fg = border })
hl(0, "Conceal",       { fg = teal, bg = "NONE" })
hl(0, "CursorLine",    { bg = surface })
hl(0, "CursorLineNr",  { fg = moss, bold = true })
hl(0, "LineNr",        { fg = "#3a4038" })
hl(0, "SignColumn",    { bg = "NONE" })
hl(0, "ColorColumn",   { bg = surface })
hl(0, "VertSplit",     { fg = border, bg = "NONE" })
hl(0, "StatusLine",    { fg = fg, bg = surface })
hl(0, "StatusLineNC",  { fg = fg_dim, bg = surface })

-- ═══════════════════════════════════════════════════════
-- STANDARD SYNTAX
-- ═══════════════════════════════════════════════════════
hl(0, "Comment",       { fg = mauve, italic = true })
hl(0, "String",        { fg = sage })
hl(0, "Character",     { fg = sage })
hl(0, "Number",        { fg = pale })
hl(0, "Boolean",       { fg = pale, bold = true })
hl(0, "Float",         { fg = pale })
hl(0, "Identifier",    { fg = fg })
hl(0, "Function",      { fg = gold, bold = true })
hl(0, "Statement",     { fg = teal })
hl(0, "Conditional",   { fg = teal })
hl(0, "Repeat",        { fg = teal })
hl(0, "Keyword",       { fg = teal })
hl(0, "Operator",      { fg = grey })
hl(0, "Type",          { fg = teal })
hl(0, "StorageClass",  { fg = teal })
hl(0, "Structure",     { fg = teal })
hl(0, "PreProc",       { fg = pale })
hl(0, "Include",       { fg = teal })
hl(0, "Define",        { fg = pale })
hl(0, "Macro",         { fg = pale })
hl(0, "Special",       { fg = moss })
hl(0, "SpecialChar",   { fg = moss })
hl(0, "Tag",           { fg = moss })
hl(0, "Delimiter",     { fg = fg_dim })
hl(0, "Constant",      { fg = pale })
hl(0, "Error",         { fg = red, bold = true })

-- ═══════════════════════════════════════════════════════
-- TREESITTER
-- ═══════════════════════════════════════════════════════
hl(0, "@variable",             { fg = fg })
hl(0, "@variable.builtin",     { fg = pale })
hl(0, "@variable.parameter",   { fg = sage })
hl(0, "@property",             { fg = teal })
hl(0, "@function",             { fg = gold, bold = true })
hl(0, "@function.builtin",     { fg = gold, bold = true })
hl(0, "@function.call",        { fg = gold })
hl(0, "@method",               { fg = gold })
hl(0, "@method.call",          { fg = gold })
hl(0, "@constructor",          { fg = teal })
hl(0, "@parameter",            { fg = sage })
hl(0, "@keyword",              { fg = teal, bold = true })
hl(0, "@keyword.function",     { fg = teal, bold = true })
hl(0, "@keyword.operator",     { fg = moss })
hl(0, "@keyword.return",       { fg = teal, bold = true })
hl(0, "@type",                 { fg = teal })
hl(0, "@type.builtin",         { fg = teal, bold = true })
hl(0, "@type.definition",      { fg = teal })
hl(0, "@attribute",            { fg = pale })
hl(0, "@namespace",            { fg = teal })
hl(0, "@string",               { fg = sage })
hl(0, "@string.escape",        { fg = pale })
hl(0, "@string.regexp",        { fg = pale })
hl(0, "@number",               { fg = pale })
hl(0, "@number.float",         { fg = pale })
hl(0, "@boolean",              { fg = pale, bold = true })
hl(0, "@constant",             { fg = pale })
hl(0, "@constant.builtin",     { fg = pale, bold = true })
hl(0, "@constant.macro",       { fg = pale })
hl(0, "@comment",              { fg = mauve, italic = true })
hl(0, "@comment.error",        { fg = red })
hl(0, "@comment.warning",      { fg = pale })
hl(0, "@comment.note",         { fg = teal })
hl(0, "@punctuation.delimiter",{ fg = fg_dim })
hl(0, "@punctuation.bracket",  { fg = fg_dim })
hl(0, "@punctuation.special",  { fg = teal })
hl(0, "@label",                { fg = sage })

-- ═══════════════════════════════════════════════════════
-- LSP / DIAGNOSTICS
-- ═══════════════════════════════════════════════════════
hl(0, "@lsp.type.class",           { fg = teal })
hl(0, "@lsp.type.enum",            { fg = teal })
hl(0, "@lsp.type.enumMember",      { fg = pale })
hl(0, "@lsp.type.interface",       { fg = teal })
hl(0, "@lsp.type.struct",          { fg = teal })
hl(0, "@lsp.type.typeParameter",   { fg = sage })
hl(0, "DiagnosticError",           { fg = red })
hl(0, "DiagnosticWarn",            { fg = pale })
hl(0, "DiagnosticInfo",            { fg = teal })
hl(0, "DiagnosticHint",            { fg = sage })
hl(0, "DiagnosticUnderlineError",  { sp = red, underline = true })
hl(0, "DiagnosticUnderlineWarn",   { sp = pale, underline = true })

-- ═══════════════════════════════════════════════════════
-- RAINBOW BRACKETS — alternating ({[]}) colors
-- ═══════════════════════════════════════════════════════
hl(0, "RainbowDelimiterRed",    { fg = "#ab9df2" })  -- purple  (
hl(0, "RainbowDelimiterYellow", { fg = "#78c2e8" })  -- blue    [
hl(0, "RainbowDelimiterBlue",   { fg = teal })        -- teal    {
hl(0, "RainbowDelimiterOrange", { fg = "#ab9df2" })  -- purple  (nested)
hl(0, "RainbowDelimiterGreen",  { fg = "#78c2e8" })  -- blue
hl(0, "RainbowDelimiterViolet", { fg = teal })
hl(0, "RainbowDelimiterCyan",   { fg = "#ab9df2" })

-- ═══════════════════════════════════════════════════════
-- UI
-- ═══════════════════════════════════════════════════════
hl(0, "Pmenu",         { fg = fg, bg = bg_subtle })
hl(0, "PmenuSel",      { fg = dark, bg = moss, bold = true })
hl(0, "PmenuSbar",     { bg = border })
hl(0, "PmenuThumb",    { bg = sage })
hl(0, "Search",        { fg = dark, bg = pale })
hl(0, "IncSearch",     { fg = dark, bg = moss, bold = true })
hl(0, "CurSearch",     { fg = dark, bg = moss })
hl(0, "Visual",        { bg = "#2a3828" })
hl(0, "MatchParen",    { fg = moss, bold = true })
hl(0, "Folded",        { fg = sage, bg = surface })
hl(0, "FoldColumn",    { fg = "#3a4038" })
hl(0, "Directory",     { fg = teal, bold = true })
hl(0, "Title",         { fg = moss, bold = true })
hl(0, "Todo",          { fg = pale, bold = true })
hl(0, "WinSeparator",  { fg = border })
hl(0, "FloatBorder",   { fg = border })
hl(0, "MsgArea",       { fg = fg })
hl(0, "ModeMsg",       { fg = fg, bold = true })
hl(0, "MoreMsg",       { fg = teal })
hl(0, "WarningMsg",    { fg = pale })
hl(0, "ErrorMsg",      { fg = red, bold = true })
hl(0, "Question",      { fg = moss })
hl(0, "SpellBad",      { sp = red, undercurl = true })
hl(0, "SpellCap",      { sp = pale, undercurl = true })

-- ═══════════════════════════════════════════════════════
-- LINKS — make URLs and markdown links blue
-- ═══════════════════════════════════════════════════════
hl(0, "@text.uri",              { fg = "#78c2e8", underline = true })
hl(0, "@text.literal.markdown_inline", { link = "@text.uri" })
hl(0, "@text.reference.markdown_inline", { fg = "#78c2e8" })
hl(0, "@text.title.uri.markdown_inline", { fg = "#78c2e8" })
hl(0, "@markup.link.url",       { fg = "#78c2e8", underline = true })
hl(0, "@markup.link.label",     { fg = teal })
hl(0, "@string.special.url",    { fg = "#78c2e8", underline = true })
