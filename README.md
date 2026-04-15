# Salat Streak

Salat Streak est une app mobile Flutter très simple, pensée pour être vendable sans pub, sans backend, et sans dépendance à une infra.

## Positionnement

- **usage utile et clair**: cocher les 5 prières du jour
- **offline-first**: aucune infra requise pour le MVP
- **monétisation propre**: achat unique ou premium léger, pas de publicité
- **scope halal-friendly**: produit de discipline personnelle, sans éléments douteux

## Objectif business

Atteindre environ **100$ par mois** avec un produit minimal mais crédible.

Exemple réaliste:
- prix premium: **4.99$**
- objectif: **~25 ventes/mois**

## MVP actuel

- dashboard journalier
- suivi Fajr / Dhuhr / Asr / Maghrib / Isha
- progression du jour
- current streak / best streak
- aperçu visuel des 30 derniers jours
- pitch de monétisation intégré au prototype

## Roadmap courte

1. stockage local persistant
2. rappels locaux
3. thèmes premium
4. export/import JSON local
5. analytics locales simples
6. paywall one-time purchase

## Lancer le projet

```bash
/home/nzima/.local/share/flutter/bin/flutter pub get
/home/nzima/.local/share/flutter/bin/flutter run
```

## Build Android

```bash
/home/nzima/.local/share/flutter/bin/flutter build apk
```
