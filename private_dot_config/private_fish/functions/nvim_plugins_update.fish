function nvim_plugins_update
    echo "[nvim] updating lazy plugins..."
    command nvim --headless "+Lazy! update" +qa
    echo "[nvim] lazy plugins updated..."

    set CURRENT_DIR (pwd)
    cd ~/.config/nvim
    git restore --staged .
    git add ./lazy-lock.json
    git add ./spell/en.utf-8.add
    git add ./spell/en.utf-8.add.spl
    # one‑off override of user.name & user.email
    git -c user.name="Feliche‑Demian Netliukh" \
        -c user.email="demyan310505@gmail.com" \
        -c user.signingKey="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZoqTjeGfPX1oif9+1UCmI+QGWVHq2kJBlEBWtlSGXn" \
        commit -S -m "chore(lazy): bump versions"
    cd $CURRENT_DIR
end
