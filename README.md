# ai-toolkit

Shared agents and skills for running Claude Code as a personal AI workshop:
a private "hub" repo that holds your instructions and tools, a backlog that
turns annoyances into improvements, and agents that draft while you decide.

It is built for capable people who are not system administrators, and it is
meant to be maintained by the people who use it.

> **Status: early (v0.2).** Four skills are ready; see [Roadmap](#roadmap).

## Install

**New to all this (Windows)?** Open Windows PowerShell and paste this one line.
It installs Git, the GitHub CLI, the Claude app and Claude Code, signs you in
to GitHub, creates your private hub from the
[hub template](https://github.com/Itzafineday/hub-template), and adds this
toolkit. Read [the script](setup/install.ps1) first if you like.

```
irm https://raw.githubusercontent.com/Itzafineday/ai-toolkit/main/setup/install.ps1 | iex
```

**Already have Claude Code?** Run:

```
/plugin marketplace add Itzafineday/ai-toolkit
```

Then `/plugin` lists what you can install. To pick up updates later, run
`/plugin marketplace update ai-toolkit`. You don't need a GitHub account to
install or update.

## How it fits together

- **This toolkit (public):** shared skills and agents that anyone can install.
- **Your hub (private, your own GitHub account):** your `AGENTS.md`, context,
  outputs and logs. It's made from a template, and nobody else sees it.
- **Your work systems:** email, CRM and files stay where they are. Agents reach
  them through connectors (MCP), and that data never goes into Git.

`AGENTS.md` is the main instructions file, so the same hub works with Claude Code,
GitHub Copilot CLI and Antigravity CLI. `CLAUDE.md` is a one-line pointer to it.

The explainer page is [docs/ai-workshop.html](docs/ai-workshop.html).

## House rules

- Agents read and draft freely. Anything that leaves the building (sending
  email, changing a CRM, publishing) waits for a human click.
- Client and employer data stays in work systems, never in Git.
- Every automated run writes a note to `logs/`.
- Tax and legal agents analyze and draft. The professional signs.

## Roadmap

v1 skills, in order:

1. **doctor** (ready): checks your setup and says what's missing or out of date.
2. **capture-idea** (ready): "log this: ..." files a backlog issue in your hub.
3. **weekly-review** (ready): a short digest of open issues and what changed.
4. **research-report** (ready): a scheduled report on a topic, with every claim sourced.
5. **secretary**: surfaces and tracks your to-dos in Microsoft To Do / Planner.

## Contributing

Fork the repo, make your change on a branch, and open a pull request. Before your first commit,
turn on the safety hook (it needs [gitleaks](https://github.com/gitleaks/gitleaks)):

```
git config core.hooksPath .githooks
```

The hook blocks commits that contain secrets. You can also list private names
and terms, one per line, in `.git/info/private-terms`. That file never leaves
your computer, and the hook blocks any commit that adds one of those terms.

## License

[MIT](LICENSE)
