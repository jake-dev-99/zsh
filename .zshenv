# -----------------------------------------------------------------------------
# .zshenv
# -----------------------------------------------------------------------------
# Global Zsh environment configuration.
# Detects the current operating system for shared startup configuration.
# -----------------------------------------------------------------------------

function common_paths {
    # Common paths
    typeset -g ANDROID_AVD_HOME="$HOME/.android/avd"
    typeset -g ANDROID_CMDLINE_TOOLS_PATH="$ANDROID_HOME_PATH/cmdline-tools/latest/bin"
    typeset -g ANDROID_EMULATOR_PATH="$ANDROID_HOME_PATH/emulator"
    typeset -g ANDROID_HOME="$HOME/Library/Android/sdk"
    typeset -g ANDROID_PLATFORM_TOOLS_PATH="$ANDROID_HOME_PATH/platform-tools"
    typeset -g ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
    typeset -g AXBREW_PATH="/usr/local/homebrew/bin/brew"
    typeset -g FLUTTER_BIN_PATH="$HOME/Development/tools/flutter/bin"
    typeset -g GCLOUD_SDK_ROOT="$HOME/google-cloud-sdk"
    typeset -g JAVA_HOME_COMMAND_PATH="/usr/libexec/java_home"
    typeset -g LM_STUDIO_BIN_PATH="$HOME/.lmstudio/bin"
    typeset -g LM_STUDIO_HOME_PATH="$HOME/.lmstudio/bin"
    typeset -g LOCAL_BIN_PATH="$HOME/.local/bin"
    typeset -g PUB_CACHE_BIN_PATH="$HOME/.pub-cache/bin"
}

function mac_paths {
    # Mac paths
    typeset -g ARCHFLAGS="-arch arm64"
    typeset -g CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    typeset -g CPPFLAGS="-I$LLVM_INCLUDE_PATH${CPPFLAGS:+ $CPPFLAGS}"
    typeset -g HOMEBREW_PATH="/opt/homebrew/bin/brew"
    typeset -g JAVA_HOME="C:\Program Files\Zulu\zulu-8-jre\bin"
    typeset -g LDFLAGS="-L$LLVM_LIB_PATH${LDFLAGS:+ $LDFLAGS}"
    typeset -g LLVM_INCLUDE_PATH="/opt/homebrew/opt/llvm/include"
    typeset -g LLVM_LIB_PATH="/opt/homebrew/opt/llvm/lib"
    typeset -g NVM_HOMEBREW_COMPLETION_PATH="/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    typeset -g NVM_HOMEBREW_SCRIPT_PATH="/opt/homebrew/opt/nvm/nvm.sh"
    typeset -g PNPM_HOME="$HOME/Library/pnpm"
    typeset -g SF_AUTOCOMPLETE_PATH="$HOME/Library/Caches/sf/autocomplete/zsh_setup"
    typeset -g SQLCIPHER_INCLUDE_PATH="/opt/homebrew/opt/sqlcipher/include"
    typeset -g SQLCIPHER_LIB_PATH="/opt/homebrew/opt/sqlcipher/lib"
    typeset -g ZLIB_INCLUDE_PATH="/opt/homebrew/opt/zlib/include"
    typeset -g ZLIB_LIB_PATH="/opt/homebrew/opt/zlib/lib"
    typeset -g ZLIB_PKGCONFIG_PATH="/opt/homebrew/opt/zlib/lib/pkgconfig"
}

function linux_paths {
    # Linux paths
    typeset -g JAVA_HOME="C:\Program Files\Zulu\zulu-8-jre\bin"
    typeset -g SF_AUTOCOMPLETE_PATH="$HOME/.cache/sf/autocomplete/zsh_setup"
    typeset -g PNPM_HOME="$HOME/.local/share/pnpm"
}

function windows_paths {
    # Windows Paths
    typeset -g JAVA_HOME="C:\Program Files\Zulu\zulu-8-jre\bin"
    typeset -g SF_AUTOCOMPLETE_PATH="$HOME/AppData/Roaming/npm/sf"
}

# Assign shared paths common to all platforms
common_paths

# Assign platform-specific vars and paths
case "$OSTYPE" in
    darwin*)        OS_NAME="macos"; mac_paths ;;
    linux*)         OS_NAME="linux" && linux_paths ;;
    msys*|cygwin*)  OS_NAME="windows" && windows_paths ;;
esac