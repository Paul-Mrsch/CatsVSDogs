# Projet Cats vs Dogs

## Introduction

Ce projet est un projet de vote pour les chats et les chiens. Il est composé de plusieurs modules : 

- Le module de vote est une application web qui permet aux utilisateurs de voter pour les chats ou les chiens.
- Le module worker est une application qui récupère les votes et les stocke dans une base de données.
- Le module de résultat est une application web qui récupère les votes et les affiche sous forme de graphique.

Ainsi qu'une partie base de donnée

- La DB redis qui est la base de données à mémoire temporaire (non persistant) qui transmet les votes User au module worker.
- La DB postgres, une base de données relationnelles qui conserve les résultats des votes.

## Lien Documentation

### Pour la partie Docker-Compose
-[TODO](TODO.md)

### Pour la partie Docker-Swarm
-[Docker-Swarm Notice](Notice-Docker-Swarm.md)


### Structure du projet
```
Projet CATS VSDOGS
├── result
│   ├── views
│   │   ├── stylesheets
│   │   │   ├── style.css
│   │   ├── angular.min.js
│   │   ├── app.js
│   │   ├── index.html
│   │   ├── socket.io.js
│   ├── .gitignore
│   ├── dockerfile
│   ├── package-lock.json
│   ├── package.json
│   ├── server.js
├── src
│   ├── voting-app
│   │   ├── run
│   │   │   ├── reset.bash
│   │   │   ├── step-1.bash
│   │   │   ├── step-2.bash
│   │   │   ├── step-3.bash
│   │   │   ├── step-4.bash
│   │   │   ├── step-5.bash
│   │   ├── .gitignore
│   │   ├── vote
│   │   │   ├── static
│   │   │   │   ├── stylesheets
│   │   │   │   │   ├── style.css
│   │   │   ├── templates
│   │   │   │   ├── index.html
│   │   │   ├── .gitignore
│   │   │   ├── app.py
│   │   │   ├── dockerfile
│   │   │   ├── requirements.txt
├── worker
│   ├── .gitignore
│   ├── dockerfile
│   ├── Program.cs
│   ├── Worker.csproj
├── .gitignore
├── docker-compose.yml
├── docker-stack.yml
├── Notice-Docker-Swarm.md
├── README.md
├── #TODO WIP A SUPP SI BESOIN
```

## Barème

### Légende 
- ✅ : Mise en place
- ❌ : Non implémenté
 
### Les conteneurs
- Le module vote est conteneurisé et respecte au mieux les bonnes pratiques : 3 points ✅
- Le module worker est conteneurisé et respecte au mieux les bonnes pratiques : 3 points ✅
- Le module result est conteneurisé et respecte au mieux les bonnes pratiques : 3 points ✅

### Le fichier Docker Compose
- Tous les conteneurs sont regroupés dans un fichier Docker Compose complet : 7 points ✅
- Le fichier Docker Compose dégnit les dépendances entre les composants : 2 points ✅
- Le fichier Docker Compose fait en sorte de sonder le statut des conteneurs : 2 points ✅

### Compartimentation et conservation de l'information
- Les données de l'application ne sont pas perdues au redémarrage de celle-ci : 4 points ✅
- Les composants du projet sont isolés dans des réseaux appropriés : 4 points ✅

### Docker swarn
- Un processus de déploiement sur un cluster Docker Swarm est fourni dans le rendu : 6 points ✅
- Le fichier Docker Compose a été dupliqué puis adapté pour Docker Swarm : 2 points ✅
- Les deux applications web restent accessibles même si un des nœuds Docker Swarm quitte le cluster : 2 points ✅
- Les instructions fournies avec le code source modigé sont claires et concises : 2 points ✅

