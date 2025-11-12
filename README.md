# My Neovim Configuration

_"A Neovim configuration of someone who's a huge fan of VS Code—now tuned for pure DX delight!"_

<img width="1916" height="1029" alt="image" src="https://github.com/user-attachments/assets/28358212-0820-43d8-9770-340d0f39a5bb" />
<img width="1918" height="1032" alt="image" src="https://github.com/user-attachments/assets/2ab2fb31-8521-4e7f-b3fd-972396c4c384" />



## Why This Setup Rocks
- Onedark Pro theme, transparent panes, and Nerd Font icons make every buffer look like a high-end editor without sacrificing startup speed.
- Mason auto-installs all the usual suspects (TypeScript, Deno, Astro, Lua, Tailwind, ESLint, etc.) and wires them into `nvim-lspconfig` automatically.
- Conform keeps files formatted on save (Prettier, Stylua, PHP-CS-Fixer); `<A-F>` gives you the classic VS Code “format document” shortcut whenever you need it.
- Dropbar winbar menus, Neo-tree, Telescope, Diffview, Markdown previews, and TODO highlights provide the creature comforts that usually send people back to VS Code.

> **Transparency note:** Transparent background is enabled by default when using the OneDarkPro theme. If your terminal emulator also uses transparency, keep its opacity low (around 5–10%) so foreground text maintains comfortable contrast.

## Daily Dev Workflows
- **File explorer** — `<C-b>` (from `lua/plugins/neo-tree.lua`) toggles Neo-tree, `<CR>` opens the focused file, `s` creates a split, `r` renames, and tapping `<C-b>` again closes the drawer. Use `<C-b>` inside any buffer to reveal the current file instantly.
- **Search the current project** — Telescope keymaps in `lua/plugins/telescope.lua` keep scope tight: `<leader>s.` opens “search old files” limited to the current working directory, `<leader>sf` finds files, `<leader>sg` live-greps from project root, and `<leader><leader>` lists active buffers.
- **Search globally / outside the repo** — `<leader>s,` pulls up the global “search old files” list, `<leader>ss` launches Telescope’s picker-of-pickers, and `<leader>sn` scopes searches to your Neovim config. `<leader>sw` greps the word under your cursor anywhere on disk.
- **Exact string / case / whole-word** — custom live-grep-args mappings (`lua/plugins/telescope.lua`) wire ripgrep flags to muscle memory: `<leader>fgg` prompts for extra args, `<leader>fgw` forces whole-word matches, `<leader>fgs` adds whole-word + case-sensitive, and current-file equivalents live on `<leader>fcc`, `<leader>fcw`, `<leader>fcs`.
- **Winbar dropdown** — `<leader>;`, `[;`, and `];` (set in `lua/plugins/dropbar.lua`) open the Dropbar picker, jump to the parent scope, or move to the next sibling symbol. Think of it as an always-on breadcrumb navigator.
- **Git diff + PR review** — Diffview mappings (`lua/plugins/diffview.lua`) keep everything on muscle memory: `<leader>dv` opens the view, `<leader>dc` closes it, `<leader>dh` shows repo history, `<leader>df` shows current-file history, and `<leader>do` opens the file under the cursor in the main tab while auto-closing the diff.
- **Markdown / MDX preview** — run `:MarkdownPreview` / `:MarkdownPreviewStop` (plugin commands) for a live browser preview while Treesitter + `mdx.nvim` keep the buffer pretty.
- **Format on demand** — `<A-F>` triggers Conform (see `lua/plugins/conform.lua`) in any buffer, matching the VS Code shortcut. Format-on-save stays enabled for everything else.

## Handy Commands
- `:Lazy` — manage, profile, or update plugins (press `q` to exit).
- `:Mason` — install or inspect language servers, linters, and formatters.
- `:checkhealth` — confirm your Neovim build plus required executables.
- `:TodoQuickFix` — jump through TODO/FIXME comments in the project.

## Dependencies
- Neovim **v0.11** or higher
- `git`, `make`, `unzip`, and a working C compiler (e.g., `gcc`)
- Modern Node.js (recommended) for Markdown preview + Prettier formatters
- `ripgrep` (`rg`) for Telescope live grep and grep_string pickers

## Installation

Neovim’s configuration lives in different paths depending on your OS:

| OS                   | PATH                                       |
|----------------------|--------------------------------------------|
| Linux, macOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim`  |
| Windows (cmd)        | `%localappdata%\nvim\`                     |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                  |

#### 1. Clone this repository

<details><summary> Linux / macOS </summary>

```sh
git clone https://github.com/butadpj/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

CMD:

```cmd
git clone https://github.com/butadpj/nvim-config.git "%localappdata%\nvim"
```

PowerShell:

```powershell
git clone https://github.com/butadpj/nvim-config.git "${env:LOCALAPPDATA}\nvim"
```

</details>

#### 2. Launch Neovim

```sh
nvim
```

Lazy’s UI appears on the first run and installs everything automatically.

## Troubleshooting
- **Lazy UI didn’t show up** — remove any old config: `rm -rf ~/.local/share/nvim/` and start `nvim` again.
- **Missing formatter/LSP** — open `:Mason`, install the tool, and rerun `:ConformInfo` or `:LspInfo` to confirm it’s wired up.
- **Colors look off** — ensure your terminal has true-color + Nerd Font support and that `termguicolors` is enabled (it is by default here).
