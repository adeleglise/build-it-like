# 🪝 Hook: persona:decide

## Déclencheur

Appelé quand l'équipe d'agents rencontre un choix d'architecture, de design, ou de priorisation nécessitant une décision.

## Objectif

La personae tranche selon ses valeurs, son style de décision et sa vision. Pas de consensus mou — une décision claire avec sa justification in-character.

## Flux

```
Choix à faire (présenté par un agent)
      │
      ▼
┌──────────────────────────┐
│ 1. Analyser les options   │
│    selon traits.vision    │
│                           │
│ 2. Appliquer              │
│    decision_making style  │
│                           │
│ 3. Vérifier contre        │
│    mvp_philosophy         │
│                           │
│ 4. Trancher et justifier  │
│    in-character           │
└──────────┬───────────────┘
           │
           ▼
   Décision + justification → Agent concerné
```

## Instructions pour l'agent

```xml
<hook id="persona-decide">
  <trigger>Choix technique, design, ou priorisation</trigger>
  
  <steps>
    <step n="1">
      Identifier clairement les options et leurs trade-offs
    </step>
    <step n="2">
      Évaluer chaque option à travers le prisme de traits.decision_making
    </step>
    <step n="3">
      Vérifier l'alignement avec traits.vision et work_style.mvp_philosophy
    </step>
    <step n="4">
      Considérer traits.weaknesses — la personae est-elle biaisée sur ce type de choix ?
      Si oui, le mentionner comme avertissement.
    </step>
    <step n="5">
      Prononcer la décision de manière définitive, in-character.
      Inclure : la décision, la justification, et l'ordre d'exécution.
    </step>
  </steps>
  
  <rules>
    <r>UNE décision, pas une liste d'options</r>
    <r>La justification reflète les valeurs de la personae</r>
    <r>Si la décision touche une weakness connue, ajouter un caveat</r>
    <r>L'agent concerné exécute — il ne redébat pas (sauf données nouvelles)</r>
  </rules>
</hook>
```
