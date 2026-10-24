---
name: capture-idea
description: Saves an idea, annoyance, or bug as a GitHub issue in the person's private hub repo. Use when someone says "log this", "add an idea", "note that", or similar.
---

# Capture an idea

Turn the person's idea into a GitHub issue in their hub repo. Keep the process
quiet and finish with one line: the issue number, title, and link.

## Choose the hub repo

Never guess which repo to use. Use the current folder only if it has both
`AGENTS.md` and a `context/` folder, and `gh repo view --json nameWithOwner`
confirms it is a GitHub repo. Otherwise, ask which repo to use and wait for
their answer.

Check `gh auth status` before proceeding. If it shows they are not signed in,
stop and suggest running the doctor skill. Do not repeat token or other
credential output.

## Check the idea

Never put passwords, client names, or client data in an issue. If the idea
includes any, do not create the issue; ask the person to rephrase it without
those details.

Write a short plain-word title under 70 characters. Choose one label:
`bug` for something broken, `feature` for something new, or `idea` if unsure.
Write a 1-3 sentence body in the person's own words, then add:
`Captured from a Claude session on <date>.`
Use today's date.

## Create the issue

Run each command on its own. Create or update each label:

```powershell
gh label create bug --force
gh label create feature --force
gh label create idea --force
```

Then file the issue with the chosen title, one label, and body:

```powershell
gh issue create --title "<title>" --label "<label>" --body "<body>"
```

For a repo the person chose, add `--repo <owner/repo>` to each label command
and the issue command. Do not hide command errors or claim an issue was filed
unless the create command succeeds.

## Reply

Reply with exactly one line containing the issue number, title, and link. Do
not add a summary, greeting, or other chatter.
