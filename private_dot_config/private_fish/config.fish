# Disable the startup message
set -U fish_greeting

# Vi key bindings
fish_vi_key_bindings

# Environment variables
set -gx EDITOR zed
set -gx VISUAL $EDITOR
set -gx ALTERNATE_EDITOR code
set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx BATDIFF_USE_DELTA true

# PATH - Prepend Homebrew paths to override Nix
fish_add_path --prepend /usr/local/bin
fish_add_path --prepend /opt/homebrew/bin
fish_add_path $HOME/.local/share/pnpm

# Load secrets from ~/.secrets/
load_secret AIKIDO_API_KEY "$HOME/.secrets/aikido-api-key"
load_secret GEMINI_API_KEY "$HOME/.secrets/gemini-api-key"

# Shell abbreviations
abbr -a q exit
abbr -a c claude
abbr -a cy 'claude --dangerously-skip-permissions'
abbr -a cs 'claude --model sonnet'
abbr -a psb 'pnpm run storybook'
abbr -a y pbcopy
abbr -a su softwareupdate
abbr -a opf op-fuzzy
abbr -a opfi op-fuzzy-pbcopy-id
abbr -a ls 'ls --color=auto'
abbr -a lsm 'l --sort=modified'
abbr -a lgi 'l --git-ignore'
abbr -a ccd 'chezmoi cd'
abbr -a bn 'bun nx'
abbr -a pn 'pnpm nx'
abbr -a yr 'yabai --restart-service'
abbr -a ys yabai_sudoers
abbr -a diff difft
abbr -a search "rg --glob '!node_modules/*'"

# npm abbreviations
abbr -a n 'pnpm nx'
abbr -a nst 'npm start'
abbr -a nr 'npm run'
abbr -a nsb 'npm run storybook'

# pnpm abbreviations
abbr -a p pnpm
abbr -a pex 'pnpm exec'
abbr -a pdx 'pnpm dlx'
abbr -a pa 'pnpm add'
abbr -a pad 'pnpm add --save-dev'
abbr -a prm 'pnpm remove'
abbr -a pls 'pnpm list'
abbr -a pap 'pnpm add --save-peer'
abbr -a pi 'pnpm init'
abbr -a pin 'pnpm install'
abbr -a prun 'pnpm run'
abbr -a pst 'pnpm start'
abbr -a pln 'pnpm run lint'
abbr -a pdocs 'pnpm run docs'
abbr -a pb 'pnpm run build'
abbr -a pd 'pnpm run dev'
abbr -a psv 'pnpm run serve'
abbr -a pgs 'pnpm run generate:slice'
abbr -a pt 'pnpm test'
abbr -a ptc 'pnpm test --coverage'
abbr -a pu 'pnpm update'
abbr -a puil 'pnpm update --interactive --latest'
abbr -a pc 'pnpm create'
abbr -a ppub 'pnpm publish'
abbr -a pf 'pnpm -r --filter'
abbr -a pre 'pnpm run preview'
abbr -a pr 'pnpm run release'
abbr -a psy 'pnpm run synth'
abbr -a pdep 'pnpm run deploy'
abbr -a pcdk 'pnpm cdk'

# Shell aliases
alias v='$EDITOR'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias l='eza -1 --long --icons --git'
alias cat='bat'
alias man='batman'

# bat help abbreviations (anywhere)
abbr -a --position anywhere -- -h '-h 2>&1 | bat --language=help --style=plain'
abbr -a --position anywhere -- --help '--help 2>&1 | bat --language=help --style=plain'

# Initialize zoxide
zoxide init fish | source

# Initialize direnv
direnv hook fish | source

# FZF configuration
set -gx FZF_DEFAULT_COMMAND 'rg --files'
set -gx FZF_CTRL_T_COMMAND 'rg --files'
set -gx FZF_CTRL_T_OPTS '--preview "bat --color=always {}" --layout default'
set -gx FZF_ALT_C_COMMAND 'fd --type d'
set -gx FZF_ALT_C_OPTS '--preview "eza --tree --level=1 --color=always {}"'

# FZF Catppuccin Latte theme
set -gx FZF_DEFAULT_OPTS "\
--bind='ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up' \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"

# Initialize fzf
command fzf --fish | source

# Initialize atuin
atuin init fish | source

# Initialize mise (version manager)
mise activate fish | source

# Initialize starship prompt
starship init fish | source
