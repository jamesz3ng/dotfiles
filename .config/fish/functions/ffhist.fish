function ffhist
    # --- CONFIGURATION ---
    # Change to 'mac' if you are on macOS
    set os "linux"
    # ---------------------
    
    # 1. Set Paths based on OS
    if test "$os" = "mac"
        set base_dir "$HOME/Library/Application Support/Firefox/Profiles"
        set open_cmd "open" 
    else
        set base_dir "$HOME/.mozilla/firefox"
        set open_cmd "xdg-open"
    end
    
    # 2. Find the Developer Edition profile (looks for 'dev-edition-default')
    set db_path (find "$base_dir" -maxdepth 2 -name "places.sqlite" | grep "dev-edition-default" | head -n 1)
    
    # Fallback: If dev edition profile isn't found, try standard default
        if test -z "$db_path"
                echo "Dev Edition profile not found, checking standard..."
                set db_path (find "$base_dir" -maxdepth 2 -name "places.sqlite" | grep "default" | head -n 1)
        end
    
        if test -z "$db_path"
                echo "Error: Could not find any Firefox profile in $base_dir"
                return 1
        end
    
        # 3. Copy DB to /tmp to avoid lock errors
        cp "$db_path" /tmp/ff_places.sqlite
    
        # 4. Query SQLite -> FZF -> Open URL
        sqlite3 -separator " :: " /tmp/ff_places.sqlite \
                "SELECT substr(title, 1, 100), url FROM moz_places WHERE title != '' ORDER BY last_visit_date DESC LIMIT 5000;" | \
            fzf --delimiter " :: " --with-nth 1 \
                --header "Firefox Dev History (Enter to Open)" \
                --bind "enter:execute($open_cmd {2})+abort"
end
