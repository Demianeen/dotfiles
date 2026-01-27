# Development Rules

- When editing code changes, always try applying them (e.g., run type checks, lints, or relevant tests) and commit the changes afterwards if everything seems to work fine
- Use Angular commit convention with single-line messages only (no multi-line descriptions)
  - Format: `type(scope): short description`
  - Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `test`, `style`
  - Scopes: Component/area being modified (e.g., `nvim`, `zsh`, `brew`, `yabai`, `chezmoi`, `install`)
  - Examples from this repo:
    - `fix(nvim): chezmoi remove`
    - `feat(nvim): add tabpage navigations keys`
    - `chore(brew): add vscode packages to brewfile`
    - `refactor(nvim): split toggleterm keymaps into separate files`
    - `fix(chezmoi): add .oh-my-zsh cache to chezmoi ignore`
    - `feat(zsh): add n lint alias (nl)`
    - `feat(install): add nix install step`
