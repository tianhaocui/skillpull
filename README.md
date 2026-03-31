# skillpull

Sync AI agent skills from Git repositories. One command, all tools.

```bash
npx skillpull tianhaocui/ai-skills
```

## Install

```bash
git clone https://github.com/tianhaocui/skillpull.git
cd skillpull
bash install.sh
```

Or via npm:

```bash
npm i -g skillpull
```

## Usage

```bash
# GitHub shortname
skillpull user/repo

# Pull a specific skill
skillpull user/repo my-skill

# List available skills in a repo
skillpull list user/repo

# Search GitHub for skill repos
skillpull search coding-standards
```

## Source Formats

| Format | Example |
|---|---|
| GitHub shortname | `user/repo` |
| Full URL | `https://github.com/user/repo` |
| SSH | `git@github.com:user/repo.git` |
| Alias | `@myalias` |
| Bare name | `my-skill` (requires registry) |

## Targets

By default, skills install to `.claude/skills/`. Use flags to target other tools:

```bash
skillpull user/repo --claude    # .claude/skills/ (default)
skillpull user/repo --codex     # .codex/skills/
skillpull user/repo --kiro      # .kiro/skills/
skillpull user/repo --cursor    # .cursor/rules/ (auto-converts to .mdc)
skillpull user/repo --all       # All of the above
```

## Registry

Set a default skill repo so you can pull by skill name alone:

```bash
# Set default registry
skillpull registry tianhaocui/ai-skills

# Now just use the skill name
skillpull my-skill
```

## Aliases

Save frequently used repos as aliases:

```bash
skillpull alias add work git@github.com:myorg/skills.git
skillpull @work my-skill

skillpull alias list
skillpull alias rm work
```

## Options

| Flag | Description |
|---|---|
| `--global, -g` | Install to user-level directory |
| `--path <dir>` | Install to a custom directory |
| `--branch <ref>` | Use a specific branch/tag/commit |
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

## License

MIT
