---
name: research-report
description: Researches a topic using public web sources and saves a fully sourced report in the hub. Use when someone asks for a research report or asks to schedule regular research.
---

# Research report

Create a clear report about the requested topic using public information only.
Never put client or employer information into web searches.

## Choose a topic

Use the topic the person gives you. If they do not give one, read
`context/research-topics.md` in the hub and use its first heading and notes,
unless the request points to another heading. If there is no topic and the file
does not exist, ask what topic they want and offer to create that file. If the
file has several equally relevant topics and you cannot choose, ask which one.

## Research

Use web search to find sources, then open useful pages with web fetch. Prefer
primary sources, such as government, regulator, official organisation pages,
and original publications, over blogs and aggregators.

Check the publication date of every source and record it. If the person asks
what is new over a period, leave out sources published before that period. If
the date cannot be found, write "date not confirmed." Use current sources for
upcoming events and decisions. Compare sources when useful; if they disagree,
explain the disagreement and cite both. Do not state a detail you cannot
confirm; say "not confirmed."

## Write and save

Use a short, descriptive topic name in the file name. Save the report in the
hub at `outputs/YYYY-MM/research-<short-topic>-YYYY-MM-DD.md`, using the
current month and date. Create the month folder if needed.

Use these sections in the report:

- **Summary**: 3–5 bullets, each with source number(s), such as `[1]`.
- **Details**: short sections; add source number(s) to every factual sentence.
- **What to watch**: upcoming dates or decisions, each with source number(s).
- **Sources**: numbered list with each source's title, publisher, publication
  date, and link. Use "date not confirmed" if its publication date is unknown.

Number sources in order of first use and keep those numbers consistent
throughout. Support every factual claim with a source that directly backs it.
After saving, show the summary in chat and include the file name.

## Run it on a schedule

In the Claude desktop app, ask Claude to "schedule this every Monday at 8am."
A scheduled task runs on your computer, so your computer needs to be on. A
cloud routine cannot save files to your computer.
