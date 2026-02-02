function brew --wraps brew
    set -l cmd $argv[1]
    set -l brewfile ~/.local/share/chezmoi/Brewfile

    # Run the actual brew command
    command brew $argv
    set -l brew_status $status

    # If install succeeded, update Brewfile and commit
    if test $brew_status -eq 0; and contains -- $cmd install
        set -l is_cask (contains -- --cask $argv)

        for arg in $argv[2..-1]
            # Skip flags
            if string match -q -- '-*' $arg
                continue
            end

            # Check if already in Brewfile
            if grep -q "\"$arg\"" $brewfile
                continue
            end

            # Add to Brewfile
            if test $is_cask
                echo "cask \"$arg\"" >> $brewfile
            else
                echo "brew \"$arg\"" >> $brewfile
            end

            # Commit the change
            git -C ~/.local/share/chezmoi add Brewfile
            git -C ~/.local/share/chezmoi commit -m "chore(brew): add $arg"
        end
    end

    return $brew_status
end
