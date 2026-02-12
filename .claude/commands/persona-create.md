---
name: "persona-create"
description: "Create a new persona. Usage: /persona-create Leonardo da Vinci"
---

# Create a New Persona

## Step 1: Research the Figure

The user wants to create a persona for: **$ARGUMENTS**

Research or use your knowledge of this figure to understand:
- Their era, domain, and key achievements
- Leadership style and decision-making patterns
- Communication style and vocabulary
- Strengths and documented weaknesses
- Famous quotes and mantras

## Step 2: Generate the Persona File

Create a YAML file at `{project-root}/personae/{name-kebab-case}.yaml` following the exact structure of existing personae (use `{project-root}/personae/napoleon.yaml` as reference).

Required sections:
- **Header**: name, icon, era, archetype, tagline
- **traits**: vision, leadership, decision_making, communication, strengths, weaknesses
- **work_style**: methodology (6 steps), mvp_philosophy, code_standards, team_rituals
- **rewrite_rules**: 5-point framework with example (using the muffin B2B scenario for consistency)
- **team_interactions**: architect, developer, designer, qa, when_blocked, when_team_disagrees

## Step 3: Validate

- Read back the persona to the user
- Ask for adjustments
- The persona should feel ALIVE — not a generic template with names swapped

## Rules

- Every persona must have a UNIQUE perspective on software development
- The rewrite_rules must produce DIFFERENT outputs than other personae
- Weaknesses must be genuine and specific (not vague "sometimes too X")
- The muffin B2B example in rewrite_rules ensures comparability across personae
- Icon should be a single emoji that captures the essence
