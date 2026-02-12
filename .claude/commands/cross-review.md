---
name: "cross-review"
description: "Invoke another persona to review the current work. Usage: /cross-review confucius"
---

# Cross-Review — Persona vs Persona

A second persona is summoned to review the work of the active persona.

## Step 1: Identify Players

- **Active persona:** Read from `{project-root}/.active-persona`. If none, ask the user who is leading.
- **Reviewer persona:** First argument from user input (e.g., "confucius"). Load from `{project-root}/personae/{reviewer}.yaml`.

If the reviewer file doesn't exist, list available personae and ask the user to choose.

## Step 2: Gather Context

Collect everything the active persona has produced so far:
- Architecture decisions and their justifications
- Code written or planned
- Design choices
- MVP scope and priorities
- Any decisions made via `persona:decide`

## Step 3: Load the Cross-Review Hook

Read and follow `{project-root}/hooks/cross-review.md` exactly.

## Step 4: Execute the Dialogue

1. **Switch to reviewer persona** — clearly mark with their icon
2. Produce the structured review report (Accords / Tensions / Objections / Suggestions / Verdict)
3. **Switch back to active persona** — clearly mark with their icon  
4. Respond to the review in-character
5. Present the synthesis to the user

## Step 5: User Decision

Present unresolved disagreements as clear choices. The user is the final arbiter.

## Rules

- Both personae must be AUTHENTIC — no fake consensus
- The reviewer must critique from THEIR values, not generic "best practices"
- The active persona must DEFEND their choices, not capitulate
- Mark every persona switch clearly: `⚔️ Napoléon:` / `🏯 Confucius:`
- If no active persona, the user can specify both: `/cross-review napoleon confucius`
