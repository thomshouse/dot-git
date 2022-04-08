#!/usr/bin/env bash

pkg.install() {
    # Setup git user & email if it's not already set
    GIT_FULLNAME="$(git config --global user.name 2>/dev/null)"
    GIT_EMAIL="$(git config --global user.email 2>/dev/null)"
    if [ -z "$GIT_FULLNAME" ]; then
        echo ""
        while [ -z "$GIT_FULLNAME" ]; do
            read -e -p "Enter your full name to use for Git commits: " GIT_FULLNAME
        done
        git config --global user.name "$GIT_FULLNAME"
    fi
    if [ -z "$GIT_EMAIL" ]; then
        echo ""
        while [ -z "$GIT_EMAIL" ]; do
            read -e -p "Enter your email address to use for Git commits: " GIT_EMAIL
        done
        git config --global user.email "$GIT_EMAIL"
    fi

    # Check to see if .gitconfig.dotfiles is included in the main .gitconfig
    if [[ -f "$HOME/.gitconfig" && ! -L "$HOME/.gitconfig" && -z "$(grep -F ".gitconfig.dotfiles" "$HOME/.gitconfig")" ]]; then
        # Ask to add the include automatically
        echo ""
        read -e -p "Do you want to automatically include .gitconfig.dotfiles in your main .gitconfig file? [Y/n] " ADD_TO_GITCONFIG
        if [[ ! $ADD_TO_GITCONFIG =~ ^[Nn][Oo]?$ ]]; then
            # Add to the file if selected
            echo -e "\n# Include dotfiles config\n[include]" >> "$HOME/.gitconfig"
            echo -e "\tpath = ~/.gitconfig.dotfiles\n" >> "$HOME/.gitconfig"
        else
            # Provide manual instructions
            echo -e "\nYou will need to manually include the .gitconfig.dotfiles file in your .gitconfig. Example:\n"
            echo -e "# Include dotfiles config\n[include]"
            echo -e "\tpath = ~/.gitconfig.dotfiles\n"
        fi
    fi

    # Initialize the package
    pkg.init
}

pkg.init() {
    # Add package bin to $PATH
    if [ -d "$PKG_PATH/bin" ]; then
        export PATH=$PKG_PATH/bin:$PATH
    fi

    # Run init scripts
    for file in $(find "$PKG_PATH/init" -maxdepth 1 -type f -name "*.zsh" 2>/dev/null); do
        [ -e "$file" ] || continue
        . "$file"
    done
}

pkg.link() {
    fs.link_files links;
}

pkg.unlink() {
    : # Package does not contain linkable files
}
