## 🐋 **Docker (Commandes générales)**  
[⬅️Retour](README.md)
### 📌 **Gestion des Conteneurs**  
- **Lister les conteneurs actifs** :  
  ```bash
  docker ps
  ```
- **Lister tous les conteneurs (actifs + arrêtés)** :  
  ```bash
  docker ps -a
  ```
- **Créer et démarrer un conteneur** :  
  ```bash
  docker run -d --name mon-conteneur image:tag
  ```
- **Arrêter un conteneur** :  
  ```bash
  docker stop <ID/NOM>
  ```
- **Démarrer un conteneur arrêté** :  
  ```bash
  docker start <ID/NOM>
  ```
- **Redémarrer un conteneur** :  
  ```bash
  docker restart <ID/NOM>
  ```
- **Voir les logs d'un conteneur** :  
  ```bash
  docker logs -f <ID/NOM>
  ```
- **Supprimer un conteneur** :  
  ```bash
  docker rm <ID/NOM>
  ```

### 📌 **Gestion des Images**  
- **Lister les images disponibles** :  
  ```bash
  docker images
  ```
- **Télécharger une image depuis Docker Hub** :  
  ```bash
  docker pull image:tag
  ```
- **Créer une image depuis un Dockerfile** :  
  ```bash
  docker build -t mon-image:latest .
  ```
- **Afficher les détails d'une image** :  
  ```bash
  docker inspect image:tag
  ```
- **Supprimer une image** :  
  ```bash
  docker rmi <IMAGE_ID>
  ```

### 📌 **Volumes et Réseaux**  
- **Lister les volumes** :  
  ```bash
  docker volume ls
  ```
- **Créer un volume** :  
  ```bash
  docker volume create mon-volume
  ```
- **Supprimer un volume** :  
  ```bash
  docker volume rm mon-volume
  ```
- **Lister les réseaux** :  
  ```bash
  docker network ls
  ```
- **Créer un réseau** :  
  ```bash
  docker network create mon-reseau
  ```
- **Supprimer un réseau** :  
  ```bash
  docker network rm mon-reseau
  ```

---

## 🛠 **Docker Compose**  

### 📌 **Gestion des Services**  
- **Démarrer tous les services définis dans `docker-compose.yml`** :  
  ```bash
  docker-compose up -d
  ```
- **Arrêter tous les services** :  
  ```bash
  docker-compose down
  ```
- **Recréer les services** :  
  ```bash
  docker-compose up -d --force-recreate
  ```
- **Afficher les logs en temps réel** :  
  ```bash
  docker-compose logs -f
  ```
- **Voir les conteneurs en cours d'exécution** :  
  ```bash
  docker-compose ps
  ```
- **Exécuter une commande dans un service** :  
  ```bash
  docker-compose exec <service> <commande>
  ```
- **Arrêter un seul service** :  
  ```bash
  docker-compose stop <service>
  ```

---

## ⚡ **Docker Swarm** (Orchestration de conteneurs)

### 📌 **Initialiser un Swarm**  
- **Démarrer un cluster Swarm** :  
  ```bash
  docker swarm init
  ```
- **Lister les nœuds du cluster** :  
  ```bash
  docker node ls
  ```

### 📌 **Gestion des Services Swarm**  
- **Déployer un service** :  
  ```bash
  docker service create --name mon-service -p 80:80 image:latest
  ```
- **Lister les services en cours** :  
  ```bash
  docker service ls
  ```
- **Mettre à jour un service** :  
  ```bash
  docker service update --image nouvelle-image:latest mon-service
  ```
- **Supprimer un service** :  
  ```bash
  docker service rm mon-service
  ```

### 📌 **Gestion des Stacks (Multi-services)**  
- **Déployer une stack depuis un fichier `docker-compose.yml`** :  
  ```bash
  docker stack deploy -c docker-compose.yml mon-stack
  ```
- **Lister les stacks actives** :  
  ```bash
  docker stack ls
  ```
- **Arrêter une stack** :  
  ```bash
  docker stack rm mon-stack
  ```

---

## 🔍 **Autres Commandes Utiles**
- **Afficher l’utilisation des ressources Docker** :  
  ```bash
  docker stats
  ```
- **Accéder à un conteneur en cours d'exécution** :  
  ```bash
  docker exec -it <ID/NOM> bash
  ```
- **Sauvegarder une image Docker sous forme d’archive** :  
  ```bash
  docker save -o mon-image.tar mon-image:latest
  ```
- **Restaurer une image Docker à partir d’une archive** :  
  ```bash
  docker load -i mon-image.tar
  ```

---

## 🛠 **Nettoyage de Docker**
- **Supprimer tous les conteneurs arrêtés**  
  ```bash
  docker container prune -f
  ```
- **Arrêter et supprimer tous les conteneurs**  
  ```bash
  docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
  ```
- **Supprimer toutes les images Docker**  
  ```bash
  docker rmi -f $(docker images -aq)
  ```
- **Supprimer tous les volumes Docker**  
  ```bash
  docker volume prune -f
  ```
- **Supprimer tous les réseaux Docker non utilisés**  
  ```bash
  docker network prune -f
  ```
- **Tout supprimer d’un coup (dangereux, supprime tout sauf Docker lui-même)**  
  ```bash
  docker system prune -a --volumes -f
  ```

⚠️ **Attention**, la dernière commande supprimera absolument **tout**, y compris les images, conteneurs, réseaux et volumes non utilisés. Assure-toi que tu n’as rien d’important avant de l’exécuter.

---

Avec ce guide, tu as tout ce qu’il faut pour bien gérer Docker, Docker Compose et Docker Swarm 🚀

