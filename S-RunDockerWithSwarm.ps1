#!/bin/bash

# Supprimer les services existants
docker service ls
docker service rm $(docker service ls -q)
docker service ls

# Démarrer le registre Docker local
docker run -d -p 5000:5000 --restart=always --name registry registry:2

# Construire les images depuis le docker-compose
docker compose build

# Tagger les images pour le registre local
docker tag catsvsdogs-vote localhost:5000/vote
docker tag catsvsdogs-worker localhost:5000/worker
docker tag catsvsdogs-result localhost:5000/result

# Pousser les images dans le registre local
docker push localhost:5000/vote
docker push localhost:5000/worker
docker push localhost:5000/result

# Déployer la stack avec Docker Swarm
docker stack deploy -c docker-stack.yml catsvsdogs

# Vérifier les services
docker service ls

# Scaler les workers
docker service scale catsvsdogs_worker=4

# Vérifier encore les services
docker service ls

# Afficher le token pour rejoindre le swarm en tant que worker
docker swarm join-token worker
