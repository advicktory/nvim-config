# nvim-moss

Neovim config with a custom **moss** theme, Colemak keymaps, LSP, treesitter, and rainbow brackets.

## Try it

```bash
nix run github:advicktory/nvim-config
```

Sandboxed — runs in a temp directory, leaves no trace.

## Install it

```bash
nix profile install github:advicktory/nvim-config
nvim
```

Bootstraps `~/.config/nvim` and launches Neovim. After that, plain `nvim` works.

## What's in it

- **Moss theme** — custom color scheme with transparent background (`colors/moss.lua`)
- **Colemak keymaps** — physical `z` = `gg` (top), Shift+`g` = `G` (bottom), `k` = insert, `'` = new line below
- **LSP** — Mason auto-installs `lua_ls`, `ts_ls`, `eslint`, `jsonls`, `bashls`, `marksman`, `nim_langserver`
- **Treesitter** — syntax highlighting for 14 languages, with Nim custom parser
- **Rainbow brackets** — alternating purple/blue/teal delimiters
- **Telescope** — `rr` find files, `rz` live grep, `fb` buffers
- **Neo-tree** — `p` toggles file explorer
- **Harpoon** — `ha` add, `h1`-`h4` jump to marked files
- **Markdown preview** — `mp` opens live-updating browser preview
- **No line wrap** — except markdown

## Prerequisites

- Neovim 0.12+ (bundled with the Nix package)
