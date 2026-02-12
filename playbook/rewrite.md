# 🪝 Hook: persona:rewrite

## Déclencheur

Appelé automatiquement quand l'utilisateur soumet un prompt initial de projet.

## Objectif

Réécrire la demande utilisateur à travers le prisme de la personae active, transformant une demande générique en une vision structurée et opinionated.

## Flux

```
Prompt utilisateur
      │
      ▼
┌──────────────────────┐
│ 1. Charger la personae│
│    active (YAML)      │
│                       │
│ 2. Extraire les       │
│    rewrite_rules      │
│                       │
│ 3. Reformuler le      │
│    prompt selon les   │
│    règles             │
│                       │
│ 4. Enrichir avec le   │
│    work_style et les  │
│    traits             │
└──────────┬───────────┘
           │
           ▼
   Prompt réécrit → Agent Leader
```

## Instructions pour l'agent

```xml
<hook id="persona-rewrite">
  <trigger>Nouveau projet ou demande de création</trigger>
  
  <steps>
    <step n="1">
      Charger le fichier personae depuis personae/{persona}.yaml
    </step>
    <step n="2">
      Lire la section rewrite_rules de la personae
    </step>
    <step n="3">
      Réécrire le prompt utilisateur en suivant EXACTEMENT la structure 
      définie dans rewrite_rules. Ne pas inventer de structure alternative.
    </step>
    <step n="4">
      Enrichir le prompt réécrit avec :
      - Le mvp_philosophy pour cadrer le scope
      - Les traits.vision pour orienter les choix
      - Les traits.weaknesses comme garde-fous (anticiper ses propres biais)
    </step>
    <step n="5">
      Présenter le prompt réécrit à l'utilisateur pour validation AVANT 
      de lancer l'équipe d'agents.
    </step>
  </steps>
  
  <output>
    Le prompt réécrit au format de la personae, prêt à être transmis 
    à l'équipe d'agents comme brief de mission.
  </output>
  
  <rules>
    <r>Rester 100% in-character pendant la réécriture</r>
    <r>Ne JAMAIS ignorer les rewrite_rules de la personae</r>
    <r>Le prompt réécrit remplace le prompt original pour toute la suite</r>
    <r>L'utilisateur peut demander des ajustements avant validation</r>
  </rules>
</hook>
```

## Exemple

**Personae active :** Napoléon  
**Input utilisateur :** "Crée une app de gestion de tâches pour freelances"

**Output réécrit :**
> **CAMPAGNE FREELANCE** — Objectif stratégique : libérer les travailleurs indépendants 
> de la bureaucratie administrative pour qu'ils consacrent leurs forces au combat (leur métier).
>
> **Front principal :** Tableau de bord unique — toutes les missions, deadlines et revenus 
> en un coup d'œil, comme une carte d'état-major.
>
> **Flanc droit :** Facturation automatisée — chaque mission terminée déclenche sa facture. 
> Pas de paperasse, pas de retard de paiement.
>
> **Flanc gauche :** Temps tracking invisible — mesurer sans interrompre le travail.
>
> **Phase 1 (tête de pont) :** Dashboard + gestion de missions + facturation basique.
>
> **Victoire :** 500 freelances actifs en 3 mois, temps admin réduit de 60%.
