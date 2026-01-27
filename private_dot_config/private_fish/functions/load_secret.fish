function load_secret --argument-names name path
    # Load secret from path into global variable if it exists, else warn.
    if test -f "$path"
        set -gx $name (cat "$path")
    else
        echo "⚠️  $name is missing at $path" 1>&2
    end
end
