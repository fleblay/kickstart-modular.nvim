# nvim config

Personal Neovim configuration, forked from
[dam9000/kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
and trimmed down to what I use for devops work (Kubernetes, Helm, Kustomize,
Terraform, Ansible), Go and shell scripting.

- **Nvim 0.12+** — plugins are managed by the built-in `vim.pack`, no plugin-manager plugin.
- LSP servers, formatters and linters are installed by **Mason**.
- System dependencies are installed by **Homebrew** via `setup.sh`.

## Install (macOS)

```sh
git clone git@github.com:fleblay/kickstart-modular.nvim.git ~/git/kickstart-modular.nvim
~/git/kickstart-modular.nvim/setup.sh
```

The script installs Homebrew (if needed) and all dependencies from the
`Brewfile`, symlinks this repo to `~/.config/nvim` (backing up anything
already there), then headlessly installs plugins, LSP servers and
treesitter parsers. Re-running it is safe.

Afterwards: set your terminal font to **JetBrainsMono Nerd Font** and run
`:checkhealth` once.

## Updating

| What | How |
| --- | --- |
| Plugins | `:lua vim.pack.update()` (`:lua vim.pack.update(nil, { offline = true })` to preview) |
| LSP servers & tools | `:Mason` |
| Brew packages | `brew bundle --file ~/git/kickstart-modular.nvim/Brewfile` |

## Languages

| Language | LSP | Formatting | Extras |
| --- | --- | --- | --- |
| Go | gopls (e2e/integration build tags), golangci-lint-ls | goimports + gofumpt on save | |
| YAML / K8s | yamlls | yamlfmt, manual only (`<leader>f`) | schemastore + kubernetes schemas |
| Helm | helm-ls | — | `templates/*` and `helmfile*.yaml` detected as helm |
| Terraform | terraformls | terraform fmt on save | |
| Ansible | ansiblels | — | ansible-lint diagnostics, nvim-ansible |
| Bash | bashls | shfmt on save | shellcheck diagnostics |
| Lua | lua_ls | stylua (as LSP) on save | |

## Personal keymaps

Leader is `<space>`. `<leader>sk` searches all keymaps; these are the
non-kickstart ones:

| Key | Action |
| --- | --- |
| `<leader>e` | Toggle neo-tree file explorer |
| `<leader>gs` / `<leader>gp` | Fugitive git status / push (in status window) |
| `<leader>f` | Format buffer |
| `<leader>si` / `<leader>su` | Grep / find files incl. hidden + gitignored |
| `sqn` `sqp` `sqg` `sqo` `sqc` | Quickfix: next / prev / current / open / close |
| `sw` | Write all files |
| `<c-d>` / `dd` (in buffers picker) | Delete buffer |
| `<C-q>` (in telescope) | Send selection (or all results) to loclist |

## Structure

```
init.lua                    entry point
lua/options.lua             editor options
lua/keymaps.lua             basic keymaps + diagnostics config
lua/custom/keymaps.lua      personal keymaps
lua/pack.lua                vim.pack build hooks
lua/plugins.lua             plugin roster (one require per module)
lua/kickstart/plugins/*.lua one file per plugin
lua/custom/plugins/*.lua    personal plugins (auto-loaded)
```

Upstream remains available as the `upstream` remote for reference and
cherry-picking.
