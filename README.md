# skillpull

Sync AI agent skills from Git repositories. One command, all tools.

```bash
npx skillpull tianhaocui/ai-skills
```

## Install

```bash
npm i -g skillpull
```

Or clone and install manually:

```bash
git clone https://github.com/tianhaocui/skillpull.git
cd skillpull
bash install.sh
```

## Quick Start

```bash
# Interactive setup: configure default repo and project scope
skillpull init

# Pull skills (uses registry if configured)
skillpull

# Pull from a specific repo
skillpull user/repo

# Pull a specific skill
skillpull user/repo my-skill
```

## Commands

| Command | Description |
|---|---|
| `skillpull init` | Interactive setup: default repo + project scope |
| `skillpull <source> [skill]` | Pull skills from a Git repo |
| `skillpull list [source]` | List available skills in a repo |
| `skillpull search <keyword>` | Search GitHub for skill repos |
| `skillpull update` | Update all installed skills to latest |
| `skillpull push [target-repo]` | Push local skills back to a remote repo |
| `skillpull installed` | Show locally installed skills |
| `skillpull remove <skill>` | Remove an installed skill |
| `skillpull registry <repo>` | Set or view default skill repo |
| `skillpull alias add <name> <url>` | Save a repo shortcut |
| `skillpull alias list` | List saved aliases |
| `skillpull alias rm <name>` | Remove an alias |
| `skillpull uninstall` | Remove skillpull from system |

## Source Formats

| Format | Example |
|---|---|
| GitHub shortname | `user/repo` |
| Full URL | `https://github.com/user/repo` |
| SSH | `git@github.com:user/repo.git` |
| Alias | `@myalias` |
| Bare name | `my-skill` (requires registry) |

## Targets

First run will show an interactive menu to select target tools. Use flags to skip the prompt:

```bash
skillpull user/repo --claude    # .claude/skills/ (default)
skillpull user/repo --codex     # .codex/skills/
skillpull user/repo --kiro      # .kiro/skills/
skillpull user/repo --cursor    # .cursor/rules/ (auto-converts to .mdc)
skillpull user/repo --all       # All of the above
```

Global (user-level) install:

```bash
skillpull user/repo --global    # ~/.claude/skills/, ~/.codex/skills/, etc.
```

## Project Scope

Skill repos can organize skills into common and project-specific folders:

```
skill-repo/
  skills/                          # common, pulled for all projects
    common-skill-a/SKILL.md
    common-skill-b/SKILL.md
  my-app/                          # project-specific
    app-skill/SKILL.md
  backend/                         # project-specific
    api-skill/SKILL.md
```

The `skills/` folder at the repo root holds shared skills. Other folders are project-specific — only pulled when matching the configured project name.

Configure a default project during `skillpull init`, or pass it per-command:

```bash
# Uses default project from config
skillpull

# Override for a specific pull
skillpull user/repo --project my-app
```

Both `skills/` (common) and the project subfolder's skills are pulled together.

## Registry & Aliases

```bash
# Set a default repo so you can pull by skill name alone
skillpull registry tianhaocui/ai-skills
skillpull my-skill              # pulls from registry

# Save frequently used repos as aliases
skillpull alias add work git@github.com:myorg/skills.git
skillpull @work my-skill
```

## Push

Push local skills back to a remote Git repo:

```bash
skillpull push user/repo
skillpull push                  # uses registry if set
```

## Options

| Flag | Description |
|---|---|
| `--global, -g` | Install to user-level directory |
| `--path <dir>` | Install to a custom directory |
| `--branch <ref>` | Use a specific branch/tag/commit |
| `--project <name>` | Include project-specific skills (defaults to `init` config) |
| `--force, -f` | Overwrite existing skills |
| `--dry-run` | Preview without making changes |
| `--quiet, -q` | Suppress non-error output |

## Skill Format

Each skill is a folder with a `SKILL.md` file:

```
my-skill/
  SKILL.md
  scripts/    # optional
```

`SKILL.md` uses YAML frontmatter:

```markdown
---
name: my-skill
version: 1.0.0
description: What this skill does
---

Skill content here...
```

## Config

Config is stored at `~/.config/skillpull/config.json`:

```json
{
  "aliases": {},
  "registry": "https://github.com/user/repo",
  "project": "my-app"
}
```

Installed skills are tracked per-directory in `.skillpull.json` manifests.

## Requirements

- macOS, Linux, or Windows (via [WSL](https://learn.microsoft.com/en-us/windows/wsl/) or [Git Bash](https://gitforwindows.org/))
- Git
- Bash 3+

## License

MIT
