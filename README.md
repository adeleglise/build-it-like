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
Marie Curie insistera sur la rigueur méthodique et l'innovation fondamentale.

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

## 🪝 Hooks

Les hooks interceptent le flux de travail à des points clés :

| Hook | Déclencheur | Rôle |
|------|-------------|------|
| `persona:rewrite` | Prompt initial | Réécrit la demande à travers la personae |
| `persona:decide` | Choix d'architecture / design | La personae tranche selon ses valeurs |
| `persona:review` | Code review, QA | Évalue le travail selon les standards de la personae |
| `persona:rally` | Blocage, conflit d'équipe | Discours de motivation / recadrage in-character |
| `persona:retrospective` | Fin de sprint / livraison | Bilan façon personae |

---

## 🚀 Utilisation

### 1. Définir la personae

```bash
# Créer ou choisir une personnalité
build-it-like persona create napoleon
build-it-like persona list
```

### 2. Lancer un projet

```bash
# L'agent adopte la personae et lance l'équipe
build-it-like start --persona napoleon "Application SaaS B2B de vente de muffins"
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
│   └── commands/             # Commandes Claude Code intégrées
├── personae/                 # 🎭 Définitions de personnalités
│   ├── napoleon.yaml
│   ├── steve-jobs.yaml
│   └── ...
├── hooks/                    # 🪝 Hooks d'interception
│   ├── rewrite.md
│   ├── decide.md
│   └── ...
├── _bmad-output/             # Artefacts générés
└── README.md
```

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

- [ ] Bibliothèque de personae prédéfinies (leaders historiques, figures tech, archétypes fictifs)
- [ ] Hook `persona:rewrite` — réécriture automatique du prompt initial
- [ ] Hook `persona:decide` — prise de décision in-character
- [ ] Mode multi-personae (débat entre personnalités sur les choix clés)
- [ ] Scoring de cohérence (l'agent reste-t-il fidèle à sa personae ?)
- [ ] Personae custom en langage naturel ("Un mélange de Elon Musk et de Bob Ross")

---

## 📜 Licence

MIT

---

*« On s'engage, et puis on voit. »* — Napoléon Bonaparte
