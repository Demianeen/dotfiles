# LaunchD Services Migration (Nix → Homebrew)

## Services to Migrate

1. **yabai** - Tiling window manager
2. **skhd** - Hotkey daemon
3. **sketchybar** - Menu bar customization
4. **borders** (jankyborders) - Window borders
5. **postgresql@16** - Database server

## Pre-Migration Steps

### 1. Stop Nix Services

```bash
# Stop all nix-darwin services
launchctl unload ~/Library/LaunchAgents/org.nixos.yabai.plist
launchctl unload ~/Library/LaunchAgents/org.nixos.skhd.plist
launchctl unload ~/Library/LaunchAgents/org.nixos.sketchybar.plist
launchctl unload ~/Library/LaunchAgents/org.nixos.jankyborders.plist
launchctl unload ~/Library/LaunchAgents/org.nixos.postgresql.plist
```

### 2. Verify They're Stopped

```bash
launchctl list | grep nixos
# Should show nothing
```

### 3. Start Homebrew Services

```bash
# Start yabai (requires sudo for scripting addition)
yabai --install-sa
brew services start yabai

# Start skhd
brew services start skhd

# Start sketchybar
brew services start sketchybar

# Start borders
brew services start borders

# Start postgresql (only if you need it)
brew services start postgresql@16
```

### 4. Verify Homebrew Services

```bash
brew services list
```

Should show all services as "started".

## Configuration Files Migration

Your configs are already in place (managed by chezmoi):
- ✅ Yabai: `~/.config/yabai/`
- ✅ SKHD: `~/.config/skhd/`
- ✅ Sketchybar: `~/.config/sketchybar/`

**Note:** Borders (jankyborders) and postgresql use the same configs regardless of install method.

## Post-Migration Verification

### Yabai
```bash
yabai --check-sa
# Should show scripting addition is loaded
```

### SKHD
```bash
# Test a hotkey to see if it works
```

### Sketchybar
```bash
# Check if the bar appears at the top of your screen
```

### PostgreSQL
```bash
psql --version
psql -l  # List databases
```

## Cleanup (AFTER verifying everything works)

```bash
# Remove nix-darwin plist files
rm ~/Library/LaunchAgents/org.nixos.*.plist

# Verify they're gone
ls ~/Library/LaunchAgents/ | grep nixos
```

## Troubleshooting

### Yabai not working
- Check System Settings → Privacy & Security → Accessibility
- Yabai should be listed and enabled
- May need to grant permission again after switching from Nix

### SKHD not responding
- Check Activity Monitor to ensure skhd is running
- Check logs: `brew services info skhd`

### Sketchybar not appearing
- Check logs: `brew services info sketchybar`
- Try: `brew services restart sketchybar`

### PostgreSQL connection errors
- Check if data directory exists: `ls -la /opt/homebrew/var/postgresql@16`
- If migrating from Nix postgres, you may need to dump/restore your databases

## Important Notes

⚠️ **PostgreSQL Data Migration**: If you have important databases in the Nix-managed PostgreSQL:

1. **Before stopping Nix postgresql**, dump your databases:
   ```bash
   pg_dumpall > ~/postgres_backup.sql
   ```

2. After starting Homebrew postgresql:
   ```bash
   psql -f ~/postgres_backup.sql postgres
   ```

⚠️ **Yabai Permissions**: You may need to re-grant Accessibility permissions to the Homebrew yabai.

⚠️ **Sketchybar configs**: Ensure your sketchybar config doesn't have hardcoded Nix paths.
