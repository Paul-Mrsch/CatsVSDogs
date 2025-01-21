# Projet Cats vs Dogs

Ce projet est un projet de vote pour les chats et les chiens. Il est composé de deux modules : un module de vote et un module de résultat.

- Le module de vote est une application web qui permet aux utilisateurs de voter pour les chats ou les chiens.
- Le module worker est une application qui récupère les votes et les stocke dans une base de données.
- Le module de résultat est une application web qui récupère les votes et les affiche sous forme de graphique.

## Barème

### Base

- Le module vote est conteneurisé et respecte au mieux les bonnes pratiques : 3 points
- Le module worker est conteneurisé et respecte au mieux les bonnes pratiques : 3 points
- Le module result est conteneurisé et respecte au mieux les bonnes pratiques : 3 points
- Tous les conteneurs sont regroupés dans un fichier Docker Compose complet : 7 points
- Le fichier Docker Compose dégnit les dépendances entre les composants : 2 points
- Le fichier Docker Compose fait en sorte de sonder le statut des conteneurs : 2 points
- Les données de l'application ne sont pas perdues au redémarrage de celle-ci : 4 points
- Les composants du projet sont isolés dans des réseaux appropriés : 4 points

### Docker swarn

- Un processus de déploiement sur un cluster Docker Swarm est fourni dans le rendu : 6 points
- Le fichier Docker Compose a été dupliqué puis adapté pour Docker Swarm : 2 points
- Les deux applications web restent accessibles même si un des nœuds Docker Swarm quitte le cluster : 2 points
- Les instructions fournies avec le code source modigé sont claires et concises : 2 points
