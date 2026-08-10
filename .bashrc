# -----------------------------------------------------------------------------
# .bashrc
# -----------------------------------------------------------------------------
# Interactive shell configuration for Bash.
# Configures the Bash environment and hands interactive sessions off to Zsh.
# -----------------------------------------------------------------------------

# Add user binaries to PATH.
export PATH="$HOME/bin:$PATH"

# Replace interactive Bash sessions with Zsh when available.
if
    [[ $- == *i* ]] &&
    [[ -x "/usr/bin/zsh.exe" ]] &&
    [[ -z "${ZSH_VERSION:-}" ]]; then
    exec "/usr/bin/zsh.exe" -l
fi
