# Shell Config

Portable shell configuration shared across all of my devices.


## Files

| File             | Purpose                                                                                                                                    |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| `.bash_profile`  | Bash login-shell configuration. Used for login initialization and bootstrapping Bash environments.                                         |
| `.bashrc`        | Bash interactive-shell configuration. Contains Bash aliases, functions, PATH changes, and shell behavior.                                  |
| `.zprofile`      | Zsh login-shell configuration. Used for login/session initialization and environment setup.                                                |
| `.zsh_history`   | Zsh command history file. Stores previously executed interactive commands.                                                                 |
| `.zshenv`        | Zsh environment configuration. Loaded by every Zsh process, including scripts and non-interactive shells.                                  |
| `.zshrc`         | Primary Zsh interactive-shell configuration. Loads aliases, functions, plugins, completions, prompts, and platform-specific configuration. |
| `.linux.zshrc`   | Linux-specific Zsh configuration. Sourced conditionally from `.zshrc`.                                                                     |
| `.macos.zshrc`   | macOS-specific Zsh configuration. Sourced conditionally from `.zshrc`.                                                                     |
| `.windows.zshrc` | Windows-specific Zsh configuration, primarily for environments such as Git Bash or MinGW. Sourced conditionally from `.zshrc`.             |


## Bash Startup

Login shell:

```text
.bash_profile
```

Interactive non-login shell:

```text
.bashrc
```

`.bash_profile` should source `.bashrc` when interactive Bash configuration is also required.


## Zsh Startup

Interactive login shell:

```text
.zshenv
.zprofile
.zshrc
  └── .linux.zshrc
  └── .macos.zshrc
  └── .windows.zshrc
```

Interactive non-login shell:

```text
.zshenv
.zshrc
  └── .linux.zshrc
  └── .macos.zshrc
  └── .windows.zshrc
```

Non-interactive Zsh:

```text
.zshenv
```


## Platform Configuration

`.zshrc` is the common entry point and loads the appropriate platform configuration.

```zsh
case "$OSTYPE" in
  darwin*)
    source ~/.macos.zshrc
    ;;
  linux*)
    source ~/.linux.zshrc
    ;;
  msys*|cygwin*)
    source ~/.windows.zshrc
    ;;
esac
```


## Guidelines

* Keep shared Zsh configuration in `.zshrc`.
* Keep OS-specific configuration in the corresponding platform file.
* Keep `.zshenv` minimal because it runs for every Zsh process.
* Use `.zprofile` for login-session initialization.
* Use `.bashrc` and `.bash_profile` only where Bash support or Zsh bootstrapping is required.
* Do not commit secrets, credentials, or private keys.
