# Persona Sound Effects

Place `.wav` files here matching the `completion_sound` names in persona `.env.json` files.
The `on-stop.sh` hook plays these sounds when Claude finishes responding.

## Required sound files

| File | Persona |
|------|---------|
| `artillery_fire.wav` | Napoleon |
| `cathedral_bells.wav` | Victor Hugo |
| `chess_move.wav` | Machiavel |
| `cosmic_hum.wav` | Albert Einstein |
| `electric_crackling.wav` | Nikola Tesla |
| `glass_tap.wav` | Steve Jobs |
| `golden_chimes.wav` | Cleopatre |
| `harp_note.wav` | Ada Lovelace |
| `liberating_bells.wav` | Simone de Beauvoir |
| `mystery_chord.wav` | Agatha Christie |
| `pocket_watch_chime.wav` | Hercule Poirot |
| `renaissance_lute.wav` | Leonard de Vinci |
| `rocket_launch.wav` | Elon Musk |
| `soft_chime.wav` | Marie Curie |
| `taiko_drum.wav` | Miyamoto Musashi |
| `temple_bell.wav` | Confucius |
| `temple_chimes.wav` | Socrate |
| `theatre_applause.wav` | Shakespeare |
| `victory_bells.wav` | Winston Churchill |
| `violin_note.wav` | Sherlock Holmes |
| `war_drums.wav` | Sun Tzu |

## How to add sounds

1. Find or create short `.wav` sound effects (1-3 seconds recommended)
2. Name them exactly as listed above
3. Place them in this directory
4. The `on-stop.sh` hook will play them automatically via `afplay` (macOS), `aplay`, or `paplay` (Linux)

If no `.wav` file is found, the hook falls back to a terminal bell (if configured in the persona's `notifications` field).
