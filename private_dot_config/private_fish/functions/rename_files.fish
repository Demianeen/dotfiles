function rename_files --argument-names old_name new_name path
    # Recursively rename files, replacing old_name with new_name in filenames.
    if test -z "$old_name" -o -z "$new_name"
        echo "Usage: rename_files <old_name> <new_name>"
        return 1
    end

    # default path value
    if test -z "$path"
        set path .
    end

    if not test -d "$path"
        echo "❌ Error: Target directory '$path' does not exist."
        return 1
    end

    echo "🔍 Searching for '$old_name' in '$path'..."

    for file in (find "$path" -type f -name "*$old_name*")
        echo "🔍 Found '$file'..."
        set -l dir (dirname "$file")
        set -l base_name (basename "$file")
        set -l new_name (string replace "$old_name" "$new_name" -- "$base_name")
        echo "🔍 Moving '$file' to '$dir/$new_name'..."
        mv "$file" "$dir/$new_name"
        echo "🔍 Done.\n"
    end
end
