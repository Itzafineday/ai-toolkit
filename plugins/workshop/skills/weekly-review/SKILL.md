---
name: weekly-review
description: Summarizes a hub's open issues and recent progress. Use for a "weekly review", "what's on my list", or "what did I get done".
---

# Weekly review

Run this in the person's hub repo: it must have `AGENTS.md`, a `context/`
folder, and be a GitHub repo. If a folder is missing or it isn't a GitHub
repo, ask which hub repo to use and stop. Don't run this from the toolkit
repo unless it is their hub.

## Gather the week's activity

Run each command on its own.

1. Check `Test-Path AGENTS.md`.
2. Check `Test-Path context`.
3. Check `git rev-parse --show-toplevel`.
4. Check `gh repo view --json nameWithOwner`.
5. Check `gh auth status`. Don't repeat any token or other sensitive output.
   If they are not signed in, suggest running the doctor skill and stop.
6. Get open issues: `gh issue list --state open --json number,title,labels,createdAt --limit 100`
7. Get the date seven days ago: `$date = (Get-Date).AddDays(-7).ToString('yyyy-MM-dd')`
8. Use that date here:
   `gh issue list --state closed --search "closed:>=DATE" --json number,title,closedAt`
9. Get commits: `git log --since="7 days ago" --oneline`

If a command fails, say what couldn't be gathered and why. Don't guess or
silently leave out data.

## Write and show the digest

Show a digest in chat, keeping it to about 20 lines:

- **Done this week**: closed issues and notable commits.
- **Still open**: group issues under Bug, Feature, Idea, then Other. Put issues
  with multiple matching labels in the first applicable group only. Sort each
  group oldest first. Mark issues open for more than 30 days as **getting old**.
- **Suggested focus**: recommend up to three issues for next week and give one
  short reason for each. Base suggestions on the list, not guesses.

If a group is empty, say "None". Include issue numbers so the person can find
each item. Show the digest before asking whether to save it.

## Save only with permission

Offer to save the digest as `outputs/YYYY-MM/weekly-review-YYYY-MM-DD.md`,
using the current date. Save only if the person says yes. Create the dated
folder if needed, and write only that one file. Never edit, close, or label
issues, or make any other changes in the hub repo.
