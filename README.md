# My Neovim Configuration

_"A modern Neovim configuration for web devs"_


## Features

*   LSP support for Web Dev (TypeScript, Deno, Astro, Tailwind, eslint, etc.).
*   Beautiful theme & colorscheme powered by Tokyo Night ☾
*   Fast startup time thanks to lazy loading ⚡️
*   Keymappings documentation 📖

## Dependencies

*   Neovim v0.10 or higher
*   Basic utils: **git**, **make**, **unzip**, C Compiler (gcc)


## Installation


Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                               |
|----------------------|------------------------------------|
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim, ~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`              |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`          |

#### 1. Clone this repository:


<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/butadpj/nvim-config.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/butadpj/nvim-config.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/butadpj/nvim-config.git "${env:LOCALAPPDATA}\nvim"
```

</details>

#### 2. Start Neovim

```sh
nvim
```

That's it! Lazy UI will show up and installs all the plugins you have. 

Use `:Lazy` to view the current plugin status. Hit `q` to close the window.

Use `:Mason` to view installed LSP's, Linters, and other tools. Hit `q` to close the window.

Use `:MarkdownPreview` to open a browser-based Markdown previewer.

## Troubleshooting

- #### Lazy UI not showing up when I Neovim
    - You probably have a pre-existing Neovim configuration. Delete it first, with: 
        ```bash
        rm -rf ~/.local/share/nvim/
        ```
    - Then re-open Neovim

