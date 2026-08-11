

# -----------------------------------------------------------------------------
# unix.zsh
# -----------------------------------------------------------------------------
# Shared Unix configuration for macOS and Linux.
# Provides profile and interactive shell startup hooks.
# -----------------------------------------------------------------------------

function platform_profile {
    
    # Homebrew
    [[ -x "$HOMEBREW_PATH" ]] && eval "$("$HOMEBREW_PATH" shellenv)"
    
    # Android/Flutter toolchain uses Gradle 8.11 + AGP 8.7 which doesn't
    # understand JDK 26. Pin to 21 (Temurin) so `gradle`, `flutter run`,
    # and the Kotlin test suites resolve a JVM they actually recognize.
    # Update when Gradle + AGP ship a release that supports JDK 25+.
    if [[ -x "$JAVA_HOME_COMMAND_PATH" ]]; then
        _java_home_21="$($JAVA_HOME_COMMAND_PATH -v 21 2>/dev/null)"
        [[ -n "$_java_home_21" ]] && JAVA_HOME="$_java_home_21"
        unset _java_home_21
    fi
}

function platform_oh_my_zsh {

    # Add wisely, as too many plugins slow down shell startup.
    [[ "$OS_NAME" == "macos" ]] && plugins+=(sudo brew copyfile copypath iterm2 macos)
    [[ "$OS_NAME" == "linux" ]] && plugins+=(sudo terraform)
    [[ "$OS_NAME" == "windows" ]] && plugins+=(sudo)
}

function platform_final {
    
    # zlib vars
    [[ -d "$ZLIB_INCLUDE_PATH" ]] && export CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I$ZLIB_INCLUDE_PATH"
    [[ -d "$ZLIB_LIB_PATH" ]] && export LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$ZLIB_LIB_PATH"
    [[ -d "$ZLIB_PKGCONFIG_PATH" ]] && export PKG_CONFIG_PATH="$ZLIB_PKGCONFIG_PATH${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
    
    # SQLCipher vars
    [[ -d "$SQLCIPHER_INCLUDE_PATH" ]] && export CFLAGS="-I$SQLCIPHER_INCLUDE_PATH${CFLAGS:+ $CFLAGS}"
    [[ -d "$SQLCIPHER_LIB_PATH" ]] && export LDFLAGS="${LDFLAGS:+$LDFLAGS }-L$SQLCIPHER_LIB_PATH -lsqlcipher"
    
    # Set PATH
    [[ -d "$ANDROID_CMDLINE_TOOLS_PATH" ]]  && path_temp+=("$ANDROID_CMDLINE_TOOLS_PATH" $path)
    [[ -d "$ANDROID_EMULATOR_PATH" ]]  && path_temp+=("$ANDROID_CMDLINE_TOOLS_PATH" $path)
    [[ -d "$ANDROID_PLATFORM_TOOLS_PATH" ]]  &&path_temp+=("$ANDROID_CMDLINE_TOOLS_PATH" $path)
    [[ -d "$FLUTTER_BIN_PATH" ]] && path_temp+=("$FLUTTER_BIN_PATH" $path)
    [[ -d "$LM_STUDIO_BIN_PATH" ]] && path_temp+=("$LM_STUDIO_BIN_PATH" $path)
    [[ -d "$LOCAL_BIN_PATH" ]] && path_temp+=("$LOCAL_BIN_PATH" $path)
    [[ -d "$PNPM_HOME" ]]  && path_temp+=("$PNPM_HOME" $path)
    [[ -d "$PUB_CACHE_BIN_PATH" ]] && path_temp+=("$PUB_CACHE_BIN_PATH" $path)

    # Wrapup
    aliases
    autocomplete
}

function aliases {

    # Platform Aliases
    case "$OS_NAME" in 
        windows)
            alias test=test
            ;;
        linux)
            alias test=test
            ;;
        macos)
            alias axbrew="arch -x86_64 $AXBREW_PATH"
            ;;
    esac

}

function autocomplete {
    # Add custom completion definitions before Oh My Zsh initializes compinit.
    # The system-installed Zsh package already supplies its standard completion
    # directories through the normal compiled/default fpath.
    [[ -d "$ZSH_COMPLETION_PATH" ]] && fpath=("$ZSH_COMPLETION_PATH" $fpath)
    [[ -d "$ZSH_COMPLETION_PATH" ]] && fpath=("$SF_AUTOCOMPLETE_PATH" $fpath)

}
