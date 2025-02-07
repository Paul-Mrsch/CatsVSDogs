# **3DOKR Paul et Jimmy Notice Docker Compose**
[⬅️Retour](README.md)

## **Introduction**
Cette documentation décrit comment configurer et exécuter un environnement multi-conteneurs avec Docker Compose pour le projet Cats vs Dogs. Elle explique la structure du fichier `docker-compose.yml` et comment utiliser Docker Compose pour démarrer, arrêter et superviser les services de l'application.

Ce guide vous permettra de déployer tous les services nécessaires pour exécuter l'application en local avec une gestion simplifiée des dépendances.

---

## **Pré-requis**
Avant de commencer, assurez-vous d’avoir Docker et Docker Compose installés sur votre machine. Vous pouvez vérifier leur installation avec ces commandes :

```bash
docker -v
docker compose version
```

Si Docker ou Docker Compose ne sont pas installés, vous pouvez les télécharger depuis le site officiel : [Docker](https://docs.docker.com/get-docker/) et [Docker Compose](https://docs.docker.com/compose/install/).

---

## **1. Démarrer les Services avec Docker Compose**

1. **Créer un fichier `docker-compose.yml`**
   Le fichier `docker-compose.yml` définit les services nécessaires à l'application, incluant le module de vote, le worker, le module de résultats, ainsi que les bases de données Redis et PostgreSQL.

2. **Lancer l’environnement**
   Une fois le fichier `docker-compose.yml` en place, exécutez la commande suivante pour démarrer tous les services :

   ```bash
   docker compose up -d
   ```

   L’option `-d` exécute les conteneurs en arrière-plan.

3. **Vérifier l’état des services**
   Pour voir les conteneurs en cours d’exécution, utilisez :

   ```bash
   docker ps
   ```

4. **Arrêter les services**
   Pour arrêter et supprimer tous les conteneurs et réseaux, utilisez :

   ```bash
   docker compose down
   ```

---

## **2. Structure des Services**

Le fichier `docker-compose.yml` définit plusieurs services :

### **Service Vote**

- Application web permettant aux utilisateurs de voter.
- Dépend de Redis pour stocker temporairement les votes.
- Exposé sur le port `8080`.

```yaml
vote:
  build:
    context: .
    dockerfile: vote/Dockerfile
  networks:
    - vote
  ports:
    - "8080:8080"
  depends_on:
    - redis
```

### **Service Worker**

- Traite les votes et les stocke dans PostgreSQL.
- Connecté aux réseaux `vote` et `result`.

```yaml
worker:
  build:
    context: .
    dockerfile: worker/Dockerfile
  networks:
    - vote
    - result
  depends_on:
    - redis
    - postgres
```

### **Service Result**

- Application affichant les résultats sous forme de graphiques.
- Dépend de PostgreSQL et du worker.
- Exposé sur le port `8888`.

```yaml
result:
  build:
    context: .
    dockerfile: result/Dockerfile
  networks:
    - result
  ports:
    - "8888:8888"
  depends_on:
    - postgres
    - worker
```

### **Service Redis**

- Stockage temporaire des votes.
- Exposé sur le port `6379`.

```yaml
redis:
  image: redis:latest
  networks:
    - vote
  ports:
    - "6379:6379"
```

### **Service PostgreSQL**

- Base de données relationnelle.
- Exposé sur le port `5432`.
- Stocke les données de manière persistante avec un volume dédié.

```yaml
postgres:
  image: postgres:latest
  environment:
    POSTGRES_USER: postgres
    POSTGRES_PASSWORD: postgres
    POSTGRES_DB: postgres
  networks:
    - result
  ports:
    - "5432:5432"
  volumes:
    - postgres_data:/var/lib/postgresql/data
```

---

## **3. Vérification et Suivi des Services**

### **Afficher les logs d’un service**
Pour voir les logs d’un service spécifique, utilisez :

```bash
docker compose logs -f vote
```

### **Redémarrer un service spécifique**
Si un service rencontre un problème, vous pouvez le redémarrer avec :

```bash
docker compose restart worker
```

### **Vérifier l’état de santé des services**
Si des checks de santé sont configurés, utilisez :

```bash
docker compose ps
```

---

## **4. Persistance des Données**

- Le service PostgreSQL utilise un volume Docker (`postgres_data`) pour éviter la perte de données après un redémarrage.
- Les volumes sont définis en bas du fichier `docker-compose.yml` :

```yaml
volumes:
  postgres_data:
```

---

## **Conclusion**

Cette documentation vous guide à travers l'utilisation de Docker Compose pour orchestrer les services de l'application Cats vs Dogs. Avec cette configuration, vous pouvez facilement gérer les dépendances entre les services, surveiller leur état et assurer la persistance des données.

Cela permet une gestion efficace du développement et des tests en local avant de passer à un déploiement sur Docker Swarm ou une autre plateforme d’orchestration.

Bonne utilisation ! 😊

