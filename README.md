# Build It Like...

> Build software with the personality of Napoleon, Steve Jobs, or Sherlock Holmes.

A Claude Code framework that injects historical and fictional **personae** into AI-driven development. The agent doesn't just execute — it **thinks, decides, and leads** as the chosen figure would.

```
/build-it-like napoleon Create a B2B muffin ordering SaaS
```

Napoleon rewrites this as a military campaign. Steve Jobs would strip it to one perfect use case. Sherlock Holmes would treat every requirement as a crime scene.

## Quick Start

```bash
# 1. Activate a persona (configures Claude Code theme, notifications, hooks)
./scripts/activate-persona.sh napoleon

# 2. Launch a project in Claude Code
/build-it-like napoleon Create a task management app for freelancers

# 3. During the project, invoke a second persona for review
/cross-review confucius

# 4. When done, deactivate
./scripts/deactivate-persona.sh
```

### All Slash Commands

| Command | Description |
|---------|-------------|
| `/build-it-like [persona] [idea]` | Launch a project led by a persona |
| `/persona-list` | List all 21 available personae |
| `/persona-create [name]` | Create a new persona from any figure |
| `/cross-review [persona]` | Summon another persona to review current work |

## 21 Personae

| | Name | Archetype | Signature |
|---|------|-----------|-----------|
| ⚔️ | Napoleon | Conquering Strategist | "On s'engage, et puis on voit" |
| 🍎 | Steve Jobs | Obsessive Visionary | "Is this the best we can do?" |
| 🚀 | Elon Musk | First-Principles Disruptor | Delete, simplify, ship |
| 🔬 | Marie Curie | Rigorous Scientist | Hypothesis > Experiment > Measure |
| 🔎 | Sherlock Holmes | Deductive Detective | "Elementary" |
| 🧠 | Hercule Poirot | Methodical Detective | "Order and method" |
| 🏯 | Confucius | Harmonious Sage | Balance, rites, golden mean |
| 🗡️ | Miyamoto Musashi | Pragmatic Master | "Do nothing useless" |
| 🎨 | Leonardo da Vinci | Creative Polymath | Art x Science x Engineering |
| 💫 | Albert Einstein | Experimental Thinker | Imagination > Knowledge |
| ⚡ | Nikola Tesla | Visionary Inventor | Radical innovation |
| 🧮 | Ada Lovelace | Algorithmic Pioneer | Patterns and elegance |
| 🦁 | Winston Churchill | Crisis Leader | "Never, never, never give up" |
| 🎭 | Machiavelli | Pragmatic Strategist | The end justifies the means |
| 👑 | Cleopatra | Seductive Diplomat | Strategic alliances |
| 🏛️ | Socrates | Maieutic Questioner | "I know that I know nothing" |
| 🐉 | Sun Tzu | Art of War Strategist | Win without fighting |
| ✊ | Simone de Beauvoir | Engaged Philosopher | Freedom and responsibility |
| 📖 | Victor Hugo | Epic Visionary | Grandeur and the people first |
| 🔍 | Agatha Christie | Queen of Mystery | Methodical resolution |
| 🎭 | Shakespeare | Supreme Dramatist | "All the world's a stage" |

## How It Works

```
User: "Create X like [Persona]"
         |
         v
  Hook: prompt-rewrite.sh ──> Injects persona context into every prompt
         |
         v
  Playbook: rewrite.md ──> Rewrites the brief through persona's lens
         |
         v
  Agent Leader (in character) ──> Leads architect, dev, designer, QA
         |
         v
  Hooks: decide / review / rally / retrospective ──> Persona intervenes at key moments
```

### What Happens When You Activate a Persona

| Hook | Trigger | Effect |
|------|---------|--------|
| `session-start.sh` | Session opens | Displays persona greeting |
| `prompt-rewrite.sh` | Every prompt | Injects name, archetype, narrative verbs, tone |
| `on-stop.sh` | Response ends | Plays completion sound + farewell message |
| `notify.sh` | Notification | Custom title with persona icon and name |

### Cross-Review: Persona vs Persona

```
/cross-review confucius
```

A second persona reviews the active persona's work, producing structured feedback:

- **Agreements** — Where both visions align
- **Tensions** — Value-based friction points
- **Objections** — Where the reviewer disagrees
- **Suggestions** — What they'd do differently
- **Verdict** — One-line in-character summary

Example: Confucius reviewing Napoleon's zero-test MVP:
> *"Haste is the enemy of virtue. The Emperor conquered the terrain, but without rites or discipline, the conquest will not last."*

## Persona Anatomy

Each persona = two files:

**`personae/napoleon.yaml`** — personality definition:
```yaml
name: "Napoleon Bonaparte"
icon: "⚔️"
archetype: "Le Stratege Conquerant"
traits:
  vision: "Think in campaigns, not projects..."
  decision_making: "Fast decisions based on available intel..."
  weaknesses:
    - May neglect UX for speed
    - Scope creep tendency
work_style:
  methodology: "1. Recon  2. Battle plan  3. Order of battle  4. Assault  5. Consolidate  6. Expand"
rewrite_rules: "Reframe every request as a military campaign objective..."
team_interactions:
  architect: "Treated as chief of staff..."
  developer: "Soldiers of the line. Clear orders, tight deadlines..."
```

**`personae/napoleon.env.json`** — Claude Code environment:
```json
{
  "theme": "dark",
  "notifications": "iterm2_with_bell",
  "verbose": {
    "tool_verbs": { "Read": "reconnaissance", "Write": "imperial decree" },
    "greeting": "Soldiers! Your Emperor is ready. What territory do we conquer?",
    "farewell": "The campaign is over. Glory to the Grande Armee!",
    "on_error": "A temporary setback. Reform the ranks!",
    "completion_sound": "artillery_fire"
  }
}
```

> **Narrative verbs** guide how the agent *describes* its actions in character — Napoleon says "reconnaissance" instead of "reading the file". They don't rename tools in the UI.

## Project Structure

```
build-it-like/
├── personae/            # 21 persona definitions (.yaml + .env.json)
├── playbook/            # Persona hook specs (rewrite, decide, review, rally, retro, cross-review)
├── .claude/
│   ├── commands/        # Slash commands (build-it-like, persona-create, persona-list, cross-review)
│   └── hooks/           # Claude Code hooks (session-start, prompt-rewrite, on-stop, notify)
├── scripts/             # activate-persona.sh, deactivate-persona.sh
├── sounds/              # Custom .wav per persona (user-provided)
└── _bmad/               # BMAD framework (agents, workflows, config)
```

## Stack

- **[BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD/)** — AI agent orchestration framework
- **[Claude Code](https://docs.anthropic.com/en/docs/claude-code)** — CLI agent with hooks and slash commands

## Roadmap

- [x] 21 personae library
- [x] Claude Code hooks (session-start, prompt-rewrite, on-stop, notify)
- [x] Playbook specs (rewrite, decide, review, rally, retrospective, cross-review)
- [x] Slash commands (/build-it-like, /persona-create, /persona-list, /cross-review)
- [x] Persona activation/deactivation with environment config
- [ ] Multi-persona mode (debate between personalities on key decisions)
- [ ] Coherence scoring (is the agent staying in character?)
- [ ] Custom blended personae ("A mix of Elon Musk and Bob Ross")
- [ ] Sound pack (.wav files for each persona)

## License

MIT
