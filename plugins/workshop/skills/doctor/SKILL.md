---
name: doctor
description: Checks that a Windows computer is set up for the AI workshop (Git, GitHub CLI, Node.js, Claude Code, gitleaks, private commit email, repo safety hook, AGENTS.md) and says how to fix anything missing. Use when someone says "run the doctor", "check my setup", or something isn't working and the cause is unclear.
---

# Doctor: check my setup

Look at the setup, report what you find, and suggest fixes. **Change nothing.**
Don't install anything, change any setting or edit any file. After the
report, offer to run each fix, one at a time, only if the person says yes.

Run every check in PowerShell. A check that errors or can't run counts as
"missing" or "needs attention", never as OK. Don't guess.

## Checks

Run each command on its own line, so one failure can't hide the others.

| # | Check | Command | OK when |
|---|---|---|---|
| 1 | Git | `git --version` | it prints a version |
| 2 | GitHub CLI | `gh --version` | it prints a version |
| 3 | GitHub sign-in | `gh auth status` | it reports a signed-in account |
| 4 | Node.js (optional) | `node --version` | it prints a version; if not, report `optional`, since only some extra tools need it |
| 5 | Claude Code CLI | `claude --version` | it prints a version |
| 6 | gitleaks (secret scanner) | `gitleaks version` | it prints a version |
| 7 | Private commit email | `git config --global user.email` | it ends in `@users.noreply.github.com` |
| 8 | Safety hook (only if the current folder has `.githooks/`) | `git config core.hooksPath` | it prints `.githooks` |
| 9 | Agent instructions (current folder) | `Test-Path AGENTS.md`, then read `CLAUDE.md` if it exists | `AGENTS.md` exists, and `CLAUDE.md` (if any) contains `@AGENTS.md` |

Privacy while checking:
- From check 3, report only "signed in as <GitHub username>" or "not signed in".
  Never repeat token lines.
- From check 7, don't print the email itself. Say only whether it's the private
  noreply kind.
- Write any path under the user's home folder as `~`.

## Fixes

| # | Fix |
|---|---|
| 1 | `winget install --id Git.Git -e` |
| 2 | `winget install --id GitHub.cli -e` |
| 3 | `gh auth login`, then follow the prompts (choose GitHub.com and HTTPS, then log in with a web browser) |
| 4 | `winget install --id OpenJS.NodeJS.LTS -e` |
| 5 | `winget install --id Anthropic.ClaudeCode -e` (other ways: https://code.claude.com/docs/en/setup) |
| 6 | `winget install --id Gitleaks.Gitleaks -e` |
| 7 | See "Why the email matters" below |
| 8 | `git config core.hooksPath .githooks` |
| 9 | Missing `AGENTS.md`: ask whoever set up the repo. A `CLAUDE.md` that doesn't point to it: add the line `@AGENTS.md` at the top |

After installing anything with winget, close and reopen the terminal so the new
command is found.

### Why the email matters (check 7)

Every commit is stamped with an email address. In a public repo, anyone can
read it, and it stays in the history permanently. GitHub gives every account
a private stand-in address. To use it:

1. On github.com, open **Settings → Emails** and tick **Keep my email
   addresses private**. Copy the address shown there; it ends in
   `@users.noreply.github.com`.
2. Run `git config --global user.email "PASTE-THE-ADDRESS-HERE"`.

## Report

Show one table, then one summary line, then the offer:

| Check | Status | Details | Fix |
|---|---|---|---|
| Git | OK | 2.55.0 | none |
| Private commit email | needs attention | not a noreply address | see "Why the email matters" |

- **Status** is exactly one of: `OK`, `missing`, `needs attention`, or `optional` (check 4 only).
- **Summary line**, for example: "7 OK, 1 missing, 1 needs attention."
- **Offer**: "Want me to run any of these fixes? I'll do them one at a time and
  check each one afterwards." Run a fix only after a clear yes, then run its
  check again to confirm it worked.
