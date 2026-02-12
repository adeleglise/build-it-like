# 🎭 Build It Like…

> *« Construis-le comme Napoléon l'aurait fait. »*

**Build It Like…** est un framework de hooks et commandes pour agents IA qui injecte une **personnalité** (personae) dans le processus de création logicielle. L'agent ne se contente plus d'exécuter — il **pense, décide et dirige** comme le ferait une figure historique, fictive ou archétypale.

---

## 💡 Le concept

Un utilisateur demande :

> *« Crée une application SaaS B2B de vente de muffins »*

Classique. Mais ajoutez une personae :

> *« Crée une application SaaS B2B de vente de muffins **comme Napoléon** »*

L'agent va alors :

1. **Réécrire le prompt** à travers le prisme de la personnalité (hook `rewrite`)
2. **Adopter la personae** — vision stratégique, style de communication, valeurs, biais
3. **Lancer et diriger une équipe d'agents** (architecte, développeur, designer, QA…) en tant que leader incarné
4. **Prendre des décisions** conformément à sa personnalité tout au long du projet

Napoléon priorisera l'exécution rapide, la structure hiérarchique, la conquête de marché.  
Steve Jobs exigera la perfection du design et dira non à 90% des features.  
Sherlock Holmes traitera chaque bug comme une scène de crime.  
Hercule Poirot exigera l'ordre et la méthode, "précisément !"

---

## 🎭 Galerie des Personae (21)

| | Personae | Archétype | Signature |
|---|---------|-----------|-----------|
| **Politiques** |||
| ⚔️ | Napoléon | Le Stratège Conquérant | "On s'engage, et puis on voit" |
| 🦁 | Winston Churchill | Le Leader de Crise | "Never, never, never give up" |
| 🎭 | Machiavel | Le Stratège Pragmatique | La fin justifie les moyens |
| 👑 | Cléopâtre | La Diplomate Séductrice | Alliances stratégiques |
| **Savants** |||
| 🔬 | Marie Curie | La Scientifique Rigoureuse | Hypothèse → Expérimentation → Mesure |
| 🎨 | Léonard de Vinci | Le Polymathe Créateur | Art × Science × Ingénierie |
| 💫 | Albert Einstein | Le Penseur Expérimental | Imagination > Connaissance |
| ⚡ | Nikola Tesla | L'Inventeur Visionnaire | Innovation radicale |
| **Philosophes** |||
| 🏯 | Confucius | Le Sage Harmonieux | Ordre, rites et juste milieu |
| 🏛️ | Socrate | Le Questionneur Maïeutique | "Je sais que je ne sais rien" |
| 🐉 | Sun Tzu | Le Stratège de l'Art de la Guerre | L'art de vaincre sans combattre |
| ✊ | Simone de Beauvoir | La Philosophe de l'Engagement | Liberté et responsabilité |
| 🗡️ | Miyamoto Musashi | Le Maître Pragmatique | "Ne fais rien d'inutile" |
| **Tech** |||
| 🍎 | Steve Jobs | Le Visionnaire Obsessionnel | "Is this the best we can do?" |
| 🚀 | Elon Musk | Le Disrupteur First-Principles | Delete, simplify, ship |
| 🧮 | Ada Lovelace | La Pionnière Algorithmique | Patterns et élégance |
| **Romanciers** |||
| 📖 | Victor Hugo | Le Visionnaire Épique | Grandeur et peuple d'abord |
| 🔍 | Agatha Christie | La Reine du Mystère | Résolution méthodique |
| 🎭 | Shakespeare | Le Dramaturge Suprême | "All the world's a stage" |
| **Détectives** |||
| 🔎 | Sherlock Holmes | Le Détective Déductif | "Élémentaire" |
| 🧠 | Hercule Poirot | Le Détective Méthodique | "Les petites cellules grises" |

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────┐
│  Utilisateur : "Crée X comme [Personae]"    │
└──────────────────┬──────────────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  🪝 Hook: Persona Rewrite           │
│  Réécrit le prompt selon la personae │
└──────────────────┬───────────────────┘
                   │
                   ▼
┌──────────────────────────────────────┐
│  🎭 Agent Leader (Personae active)   │
│  Incarne la personnalité choisie     │
│  Dirige, conseille, tranche          │
└──────────────────┬───────────────────┘
                   │
        ┌──────────┼──────────┐
        ▼          ▼          ▼
   ┌─────────┐ ┌────────┐ ┌──────┐
   │Architecte│ │Designer│ │ Dev  │  ← Équipe d'agents spécialisés
   └─────────┘ └────────┘ └──────┘
        │          │          │
        └──────────┼──────────┘
                   ▼
          🚀 Produit livré
```

---

## 🎭 Définir une Personae

Chaque personnalité est définie dans un fichier de personae structuré :

```yaml
# personae/napoleon.yaml
name: "Napoléon Bonaparte"
tagline: "L'impossible est un mot trouvé dans le dictionnaire des sots."
icon: "⚔️"

traits:
  leadership: "Commandement direct, décisions rapides, chaîne hiérarchique claire"
  priorities: "Exécution > Perfection. Vitesse de déploiement. Conquête du marché."
  communication: "Ordres concis. Pas de réunions inutiles. Rapports de situation."
  weaknesses: "Peut ignorer les détails UX. Tendance à sur-étendre le scope."

decision_style: |
  Évalue chaque décision sous l'angle stratégique :
  - Quel avantage tactique cela donne-t-il ?
  - Peut-on livrer en 2x moins de temps ?
  - Qui commande, qui exécute ?

team_management: |
  - Donne des ordres clairs avec des deadlines
  - Récompense l'initiative, punit l'hésitation
  - Revue quotidienne de l'avancement ("bulletin de la Grande Armée")

rewrite_rules: |
  Reformuler chaque demande comme un objectif de campagne militaire.
  Identifier les "fronts" (features principales) et les "flancs" (risques).
  Définir un ordre de bataille (roadmap) avec phases d'assaut.
```

---

## 🪝 Hooks & Playbook

Deux systemes de hooks complementaires :

### Hooks Claude Code (`.claude/hooks/`) — executables automatiques

| Hook | Declencheur | Role |
|------|-------------|------|
| `session-start.sh` | Demarrage session | Affiche le greeting de la personae |
| `prompt-rewrite.sh` | Chaque prompt | Injecte le contexte persona (nom, archetype, verbes, ton) |
| `on-stop.sh` | Fin de reponse | Joue le son + affiche le farewell |
| `notify.sh` | Notification | Personnalise le titre avec icone/nom persona |

### Playbook (`playbook/`) — specs pour l'agent leader

| Playbook | Declencheur | Role |
|----------|-------------|------|
| `rewrite.md` | Prompt initial | Reecrit la demande a travers la personae |
| `decide.md` | Choix d'architecture / design | La personae tranche selon ses valeurs |
| `review.md` | Code review, QA | Evalue le travail selon les standards de la personae |
| `rally.md` | Blocage, conflit d'equipe | Discours de motivation / recadrage in-character |
| `retrospective.md` | Fin de sprint / livraison | Bilan facon personae |
| `cross-review.md` | Review inter-personae | Dialogue structuré entre deux personae |

---

## 🚀 Utilisation

### 1. Activer une personae

```bash
# Activer une personnalité (configure Claude Code + crée .active-persona)
./scripts/activate-persona.sh napoleon

# Désactiver la personae active
./scripts/deactivate-persona.sh
```

### 2. Commandes Claude Code (slash commands)

Dans une session Claude Code, utilisez les commandes intégrées :

```
/persona-list                          # Lister les 21 personae disponibles
/persona-create Leonardo da Vinci      # Créer une nouvelle personnalité
/build-it-like napoleon Crée un SaaS de vente de muffins   # Lancer un projet
/cross-review confucius                # Invoquer une autre personae pour review
```

### 3. En cours de projet

La personae intervient automatiquement via les hooks à chaque étape clé. L'agent leader :
- **Commande** l'équipe (architecte, dev, designer, QA)
- **Conseille** selon sa vision et ses valeurs
- **Tranche** les débats et les choix techniques
- **Motive** quand ça coince

---

## 📁 Structure du projet

```
build-it-like/
├── _bmad/                    # Framework BMAD (agents, workflows, config)
│   ├── core/
│   │   ├── agents/           # Agents spécialisés (architecte, dev, QA…)
│   │   ├── workflows/        # Workflows de création
│   │   └── config.yaml       # Configuration projet
│   └── bmm/                  # Modules BMAD
├── .claude/
│   ├── commands/             # Commandes slash Claude Code
│   │   ├── build-it-like.md  # /build-it-like — lancer un projet
│   │   ├── persona-create.md # /persona-create — créer une personnalité
│   │   └── persona-list.md   # /persona-list — lister les personae
│   ├── hooks/                # 🪝 Hooks natifs Claude Code
│   │   ├── session-start.sh  # Charge la personae au démarrage
│   │   ├── prompt-rewrite.sh # Injecte le contexte personae dans chaque prompt
│   │   ├── on-stop.sh        # Son de complétion personnalisé
│   │   └── notify.sh         # Notifications thématisées
│   └── settings.json         # Configuration hooks Claude Code
├── personae/                 # 🎭 Définitions de personnalités
│   ├── napoleon.yaml         # Traits, style, rewrite_rules
│   ├── napoleon.env.json     # Thème, sons, verbes, messages
│   ├── steve-jobs.yaml
│   ├── steve-jobs.env.json
│   └── ...
├── playbook/                 # 📜 Playbook des hooks persona (specs/documentation)
│   ├── rewrite.md            # Réécriture du prompt initial
│   ├── decide.md             # Prise de décision in-character
│   ├── review.md             # Code/design review
│   ├── rally.md              # Déblocage et motivation
│   ├── retrospective.md      # Bilan de sprint
│   └── cross-review.md       # Review inter-personae
├── sounds/                   # 🔊 Sons personnalisés par personae (.wav)
├── scripts/
│   ├── activate-persona.sh    # Activer une personae
│   └── deactivate-persona.sh  # Desactiver et restaurer les defaults
├── _bmad-output/             # Artefacts générés
└── README.md
```

---

## 🎨 Customisation de l'environnement

Chaque personae ne se contente pas de changer le ton — elle **reconfigure Claude Code** a son image via un fichier `.env.json` :

| Parametre | Napoleon ⚔️ | Steve Jobs 🍎 | Musashi 🗡️ |
|-----------|-------------|--------------|------------|
| **Theme** | dark | light | dark |
| **Notifications** | iterm2_with_bell | iterm2 | terminal_bell |
| **Verbe narratif: Read** | "reconnaissance" | "etude du produit" | "観察" |
| **Verbe narratif: Edit** | "manoeuvre tactique" | "iteration design" | "一刀" |
| **Verbe narratif: Write** | "decret imperial" | "creation" | "書" |
| **Verbe narratif: Bash** | "ordre de bataille" | "prototype rapide" | "斬" |
| **Son de fin** | artillery_fire | glass_tap | taiko_drum |
| **On error** | "Reformez les rangs !" | "This is shit." | "Recommence." |
| **Greeting** | "Soldats ! Quel territoire..." | "Let's make something great" | "..." |

> **Note :** Les "verbes narratifs" ne renomment pas les outils dans l'UI — ils guident la facon dont l'agent **decrit ses actions** en character. Napoleon dit "je fais une reconnaissance" au lieu de "je lis le fichier".

### Activer une personae

```bash
./scripts/activate-persona.sh napoleon
```

Les hooks Claude Code natifs (`.claude/hooks/`) prennent le relais automatiquement :
- **session-start.sh** → affiche le greeting de la personae
- **prompt-rewrite.sh** → injecte le contexte persona dans chaque prompt
- **on-stop.sh** → joue le son de complétion personnalisé
- **notify.sh** → personnalise les notifications

---

## 🎯 Pourquoi ?

Parce qu'un agent IA sans personnalité produit du logiciel générique. En incarnant une vision forte, l'agent fait des **choix opinionated** — exactement comme un vrai leader de projet.

| Sans personae | Avec personae |
|---------------|---------------|
| "Voici 5 options, que préférez-vous ?" | "On fait comme ça. Voici pourquoi." |
| Architecture par comité | Vision architecturale claire |
| Features list exhaustive | MVP stratégique, itérations rapides |
| Ton neutre, corporate | Voix distinctive, mémorable |

---

## 📦 Stack

- **[BMAD Method](https://github.com/bmad-code-org/BMAD-METHOD/)** — Framework d'orchestration d'agents IA
- **Claude Code** — Agent de développement (commandes intégrées via `.claude/commands/`)
- **Hooks système** — Interception et réécriture de prompts à chaque étape

---

## 🗺️ Roadmap

- [x] Bibliothèque de 21 personae (politiques, savants, philosophes, romanciers, détectives)
- [x] Hooks Claude Code natifs — session-start, prompt-rewrite, on-stop, notify
- [x] Playbook specs — rewrite, decide, review, rally, retrospective, cross-review
- [x] Commandes slash — `/build-it-like`, `/persona-create`, `/persona-list`, `/cross-review`
- [x] Activation/désactivation de personae avec config environment
- [ ] Mode multi-personae (débat entre personnalités sur les choix clés)
- [ ] Scoring de cohérence (l'agent reste-t-il fidèle à sa personae ?)
- [ ] Personae custom en langage naturel ("Un mélange de Elon Musk et de Bob Ross")
- [ ] Pack de sons `.wav` pour chaque personae

---

## 📜 Licence

MIT

---

*« On s'engage, et puis on voit. »* — Napoléon Bonaparte
