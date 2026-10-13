# ai-toolkit: instructions for agents working on this repo

This repo is PUBLIC. Everything committed here is permanent and readable by anyone.

## Never commit
- Names of real people, clients or employers; email addresses; tenant IDs.
- Local paths that contain a username (write `~/` or `%USERPROFILE%` instead).
- Secrets, tokens, certificates, `.env` files, or any client or employer data.

## Before every commit
- The pre-commit hook must be on: `git config core.hooksPath .githooks`.
  Never bypass it (`--no-verify`).
- Read the staged diff and check it against the list above.

## Layout
- `.claude-plugin/marketplace.json`: the plugin catalog.
- `plugins/<name>/`: one plugin per folder, each with `.claude-plugin/plugin.json`.
- Put the real instructions in skills (`SKILL.md`), which also load in other
  agents. Keep agent definitions as thin wrappers around skills.
- `docs/`: explainer pages for people using the toolkit.
- Validate after changes: `claude plugin validate .`

## Style
- Write for people who are not developers: plain words, short steps.
- Commit messages in the imperative mood ("Add doctor skill").
- Never push or publish without a human's OK.
