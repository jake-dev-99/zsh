# -----------------------------------------------------------------------------
# .zprofile
# -----------------------------------------------------------------------------
# Login shell entry point for Zsh.
# Loads OS-specific profile setup before interactive shell configuration.
# -----------------------------------------------------------------------------

# Import OS-Specific Configuration
# $OS_NAME is defined in .zshenv
if [[ "$OS_NAME" == "macos" || "$OS_NAME" == "linux" ]]; then
    [[ -r "$HOME/unix.zsh" ]] && source "$HOME/unix.zsh"
elif [[ "$OS_NAME" == "windows" ]]; then
    [[ -r "$HOME/windows.zsh" ]] && source "$HOME/windows.zsh"
fi

(( $+functions[profile_setup] )) && profile_setup
