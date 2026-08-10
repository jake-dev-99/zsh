#!/usr/bin/env bash

# -----------------------------------------------------------------------------
# setup.sh
# -----------------------------------------------------------------------------
# Bootstrap script for the shell configuration repository.
# Ensures ~/zsh exists and links shell startup files into the home directory.
# -----------------------------------------------------------------------------

set -euo pipefail

REPO_URL="git@github.com:jake-dev-99/zsh.git"
REPO_DIR="$HOME/zsh"
BACKUP_SUFFIX="$(date +%Y%m%d%H%M%S)"

LINK_FILES=(
    ".bash_profile"
    ".bashrc"
    ".zshenv"
    ".zprofile"
    ".zshrc"
    "platform.zsh"
)

# If not already present, clone the repository into the home directory.
if [[ ! -e "$REPO_DIR" ]]; then
    command -v git >/dev/null 2>&1 || {
        printf 'Error: git is required but was not found in PATH.\n' >&2
        exit 1
    }
    git clone "$REPO_URL" "$REPO_DIR"

# If $REPO_DIR exists but is missing the .git folder
elif [[ ! -d "$REPO_DIR/.git" ]]; then
    printf 'Error: %s already exists but is not a Git repository.\n' "$REPO_DIR" >&2
    exit 1
fi

# Make sure repo is up to date
git -C $REPO_DIR pull

# Create or refresh the shell configuration symlinks.
for file in "${LINK_FILES[@]}"; do
    source_file="$REPO_DIR/$file"
    target_file="$HOME/$file"

    # Validate the hardcoded lists is valid
    if [[ ! -e "$source_file" ]]; then
        printf 'Error: required repository file is missing: %s\n' "$source_file" >&2
        exit 1
    fi

    # Check if symlink exists
    if [[ -L "$target_file" ]]; then
        # Check if symlink points to the correct file
        if [[ "$(readlink "$target_file")" != "$source_file" ]]; then
            printf 'Existing link is incorrect: %s -> %s\n' "$target_file" "$(readlink "$target_file")"
        else
            printf 'Already linked: %s -> %s\n' "$target_file" "$source_file"
            continue
        fi

    # If the target file exists and is NOT a symlink, back it up
    elif [[ -e "$target_file" ]]; then
        backup_file="$target_file.backup.$BACKUP_SUFFIX"
        mv "$target_file" "$backup_file"
        printf 'Backed up: %s -> %s\n' "$target_file" "$backup_file"
    fi

    # If on windows, use strict native symlinking (MSYS2 defaults to deep cloning otherwise)
    [[ "$OSTYPE" == msys* || "$OSTYPE" == cygwin* ]] && export MSYS=winsymlinks:nativestrict

    # Create the symlink
    if MSYS=winsymlinks:nativestrict ln -s "$source_file" "$target_file"; then
        printf 'Linked: %s -> %s\n' "$target_file" "$source_file"
        echo ''
    else
        printf 'Error: failed to create symlink: %s -> %s\n' "$target_file" "$source_file" >&2
        exit 1
    fi
done

printf 'Shell configuration setup complete.\n'
