# Nix to Chezmoi Migration Checklist

## Pre-Migration Steps

- [ ] Backup important data (optional - source of truth is ~/nixos-config)
- [ ] Ensure chezmoi is installed and initialized

## Apply Configurations

```bash
# Apply all chezmoi configurations
chezmoi apply

# Install/update packages via Homebrew
brew bundle install --file=~/.local/share/chezmoi/Brewfile
```

## Install Yazi Plugins

Yazi plugins need to be installed manually (they were auto-fetched in Nix):

```bash
# Create plugins directory if not exists
mkdir -p ~/.config/yazi/plugins

# Install system-clipboard plugin
git clone https://github.com/orhnk/system-clipboard.yazi.git \
  ~/.config/yazi/plugins/system-clipboard.yazi

# Install chmod plugin (from official yazi plugins)
git clone https://github.com/yazi-rs/plugins.git /tmp/yazi-plugins
cp -r /tmp/yazi-plugins/chmod.yazi ~/.config/yazi/plugins/
cp -r /tmp/yazi-plugins/smart-filter.yazi ~/.config/yazi/plugins/
rm -rf /tmp/yazi-plugins

# Install glow plugin
git clone https://github.com/Reledia/glow.yazi.git \
  ~/.config/yazi/plugins/glow.yazi
```

## Install Bat Catppuccin Theme

```bash
# Create bat themes directory
mkdir -p "$(bat --config-dir)/themes"

# Download Catppuccin Latte theme
curl -o "$(bat --config-dir)/themes/Catppuccin Latte.tmTheme" \
  https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Latte.tmTheme

# Rebuild bat cache
bat cache --build
```

## Set Fish as Default Shell

```bash
# Add fish to /etc/shells if not already there
echo $(which fish) | sudo tee -a /etc/shells

# Change default shell to fish
chsh -s $(which fish)
```

## Install Fish Plugin Manager (optional)

If you want to use fisher for fish plugin management:

```bash
# Fisher should already be installed via Homebrew
# Install the z plugin that was used in Nix config
fisher install jethrokuan/z
```

## Verification Steps

### 1. Fish Configuration
```bash
# Start a new fish shell
fish

# Verify environment variables
echo $EDITOR  # Should be: nvim
echo $VISUAL  # Should be: nvim
echo $SSH_AUTH_SOCK  # Should point to 1Password
echo $PNPM_HOME  # Should be: $HOME/.local/share/pnpm

# Verify abbreviations work
abbr | grep -E "(q|p|n|diff)"

# Verify aliases work
alias | grep -E "(v|l|cat|man)"
```

### 2. Starship Prompt
```bash
# Check starship is working
starship --version

# Navigate to a git repo and verify custom icons appear
cd ~/some-git-repo
```

### 3. Git Configuration
```bash
# Verify git config
git config --get user.name  # Should be: Feliche-Demian Netliukh
git config --get user.email  # Should be: 51330172+Demianeen@users.noreply.github.com
git config --get commit.gpgsign  # Should be: true
git config --get gpg.format  # Should be: ssh

# Test difftastic
git difftool
```

### 4. GitHub CLI
```bash
# Verify gh is configured
gh auth status
gh alias list  # Should show: co, pv
```

### 5. Atuin
```bash
# Verify atuin is working
atuin status

# Try searching history (Ctrl+R or up arrow)
```

### 6. Bat
```bash
# Verify bat theme
bat --config-file
cat ~/.config/bat/config  # Should show: --theme="Catppuccin Latte"

# Test bat
echo "test" | bat --color=always

# Test bat-extras
echo "test" | batman
```

### 7. FZF
```bash
# Verify FZF theme (should show Catppuccin Latte colors)
echo $FZF_DEFAULT_OPTS

# Test FZF (Ctrl+T for files, Alt+C for directories)
# Colors should be Catppuccin Latte
```

### 8. Zoxide
```bash
# Verify zoxide is initialized
type -q z  # Should work in fish

# Test zoxide
z --version
```

### 9. Direnv
```bash
# Verify direnv hook is loaded
type -q direnv

# Test in a directory with .envrc
```

### 10. Lazygit
```bash
# Start lazygit in a git repo
lazygit

# Verify:
# - Theme/colors look correct
# - Difftastic works for diffs
# - Press 'C' for commitizen (if npm project)
# - Vim keybindings work (j/k navigation)
```

### 11. SSH
```bash
# Verify SSH config
cat ~/.ssh/config

# Test SSH agent (1Password)
ssh-add -l  # Should list keys from 1Password
```

### 12. Yazi
```bash
# Start yazi
yazi

# Verify:
# - Navigate with vim keys (hjkl)
# - Press 'cF' to copy file (system-clipboard plugin)
# - Press 'Cm' to chmod (chmod plugin)
# - Press 'F' for smart filter
# - View markdown files (should use glow preview)
```

### 13. Ghostty
```bash
# Open Ghostty terminal
ghostty

# Verify:
# - Theme is Catppuccin Latte
# - Font is FiraCode Nerd Font, size 13
# - Padding is correct
# - Titlebar is hidden
```

## Post-Migration Cleanup

### Remove Nix Symlinks (CAREFULLY)

**WARNING**: Only do this after verifying everything works!

```bash
# Check current symlinks
ls -la ~ | grep "nix/store"
ls -la ~/.config | grep "nix/store"

# Remove Nix symlinks one by one
# DO NOT use 'rm -rf'!
# Example:
# unlink ~/.config/fish
# unlink ~/.config/starship.toml
# etc.
```

### Keep Nix Installed (Safety Net)

Do NOT uninstall Nix immediately. Keep it as a safety net for at least 1-2 weeks to ensure everything works smoothly.

## Troubleshooting

### Fish not starting
- Check if fish is in /etc/shells: `cat /etc/shells | grep fish`
- Check fish config for errors: `fish -c "fish --version"`

### Themes not working
- Bat: Run `bat cache --build`
- FZF: Check `$FZF_DEFAULT_OPTS` is set
- Ghostty: Check `~/.config/ghostty/config` exists

### Commands not found
- Run `brew bundle install` again
- Check PATH: `echo $PATH`
- Reload fish: `exec fish`

### Plugins not working
- Yazi: Check plugins exist in `~/.config/yazi/plugins/`
- Fish: Reinstall with `fisher install jethrokuan/z`

## Migration Complete!

Once all verification steps pass:
- [ ] Mark migration as complete
- [ ] Keep Nix installed for 1-2 weeks as safety net
- [ ] After validation period, optionally uninstall Nix
- [ ] Update documentation in ~/dotfiles.git repo
