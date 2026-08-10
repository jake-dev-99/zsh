# Shell Config

Portable Bash and Zsh configuration shared across my devices.

## Files

| File            | Purpose                                                                                                                             |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `.bash_profile` | Bash login-shell entry point. Sources `~/.bashrc`.                                                                                  |
| `.bashrc`       | Bash interactive-shell configuration. Adds the user bin path and hands supported interactive Git Bash sessions off to Zsh.          |
| `.zshenv`       | Global Zsh environment configuration. Detects the current OS and declares shared and OS-specific path variables.                    |
| `.zprofile`     | Zsh login-shell configuration. Runs login-specific platform setup before `.zshrc`.                                                  |
| `.zshrc`        | Primary interactive Zsh configuration. Loads common shell configuration, Oh My Zsh, and the platform hooks.                         |
| `platform.zsh`  | Shared platform implementation. Defines platform-specific profile, Oh My Zsh, aliases, autocomplete, PATH, and final tooling setup. |

## Startup Flow

### Git Bash

```text
.bash_profile
  └── .bashrc
        └── exec zsh -l
              ├── .zshenv
              ├── .zprofile
              └── .zshrc
                    └── platform.zsh
```

### Zsh Interactive Login Shell

```text
.zshenv
.zprofile
.zshrc
  └── platform.zsh
```

### Zsh Interactive Non-Login Shell

```text
.zshenv
.zshrc
  └── platform.zsh
```

### Zsh Non-Interactive Shell

```text
.zshenv
```

## Operating System Detection

`.zshenv` assigns `OS_NAME` from `$OSTYPE` and then loads the corresponding path declarations.

```text
darwin*       -> macos
linux*        -> linux
msys*|cygwin* -> windows
```

Path declarations are organized into four functions:

```text
common_paths
mac_paths
linux_paths
windows_paths
```

`common_paths` is always executed. The matching OS-specific function is executed afterward.

## Path Configuration

Filesystem locations and tool paths are declared in `.zshenv` rather than scattered throughout the interactive configuration.

```text
.zshenv
  ├── common_paths()
  ├── mac_paths()
  ├── linux_paths()
  └── windows_paths()
```

The remaining startup files consume those variables when configuring tools and extending the shell PATH.

Zsh's lowercase `path` array is used when modifying `PATH`. Zsh automatically synchronizes the `path` array with the exported `PATH` environment variable.

## Interactive Configuration

`.zshrc` owns the common interactive configuration and sources `platform.zsh` relative to its own location:

```zsh
source "${${(%):-%N}:A:h}/platform.zsh"
```

The platform hooks are executed at defined points during startup:

```text
.zshrc
  │
  ├── source platform.zsh
  │
  ├── platform_profile
  │
  ├── common Zsh configuration
  │
  ├── platform_oh_my_zsh
  │
  ├── load Oh My Zsh
  │
  ├── common user configuration
  │
  └── platform_final
```

## Platform Hooks

`platform.zsh` provides the platform-specific implementation used by `.zshrc`.

### `platform_profile`

Runs preliminary platform configuration before the main interactive Zsh configuration.

### `platform_oh_my_zsh`

Applies OS-specific Oh My Zsh configuration before Oh My Zsh is loaded, including platform-specific plugin additions.

### `platform_final`

Applies the remaining platform configuration after the common user configuration, including tool environment variables, PATH additions, aliases, and autocomplete setup.

## Oh My Zsh

The common Oh My Zsh configuration lives in `.zshrc`.

The base plugin list is shared across all operating systems. `platform_oh_my_zsh` appends any additional plugins required for the current `OS_NAME` before Oh My Zsh initializes.

Automatic Oh My Zsh updates are enabled with a seven-day update frequency.

## Configuration Boundaries

```text
.zshenv
  Environment detection and path declarations

.zprofile
  Login-shell initialization

.zshrc
  Common interactive Zsh configuration

platform.zsh
  OS-specific interactive implementations

.bash_profile / .bashrc
  Bash startup and Git Bash -> Zsh bootstrap
```
