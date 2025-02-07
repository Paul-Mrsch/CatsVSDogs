

# **3DOKR Paul et Jimmy Notice Docker Swarm**
[⬅️Retour](README.md)

## **Introduction**
Cette documentation explique les étapes nécessaires pour configurer Docker Swarm sur un cluster de plusieurs nœuds. Elle présente comment initialiser un Swarm sur le premier nœud, ajouter un deuxième nœud, et déployer une stack Docker partagée entre les nœuds tout en garantissant que les services (tels que la base de données) partagent les mêmes ressources.

Ce guide permettra de déployer ces services à travers plusieurs nœuds tout en maintenant une architecture de haute disponibilité.

---

## **Pré-requis**

Avant de commencer, assurez-vous d’avoir Docker installé sur les deux machines ou sur les deux instances (qu’elles soient locales ou distantes). Vous pouvez vérifier l’installation de Docker avec cette commande :

```bash
docker -v
```

Si Docker n'est pas installé, vous pouvez le télécharger et l'installer depuis le site officiel : [Lien](https://docs.docker.com/get-docker/).

---

## **1. Initialiser Docker Swarm sur le Premier Nœud (Manager)**

Le premier nœud sera configuré en tant que manager Docker Swarm. Voici les étapes pour initialiser un Swarm sur ce nœud :

1. **Initialisation du Swarm :**
   Sur le premier nœud (manager), exécutez la commande suivante pour initialiser Docker Swarm :

   ```bash
   docker swarm init
   ```

2. **Obtenir le token d'adhésion pour ajouter des workers :**
   Une fois le Swarm initialisé, Docker vous donnera un token à utiliser pour connecter d'autres nœuds (workers) au Swarm. Utilisez la commande suivante pour obtenir ce token :

   ```bash
   docker swarm join-token worker
   ```

   Cette commande retournera un message avec une commande que vous devrez exécuter sur les nœuds workers (voir la prochaine étape).

---

## **2. Ajouter un Deuxième Nœud (Worker) au Swarm**

1. **Exécuter la commande d'adhésion sur le deuxième nœud :**
   Sur le deuxième nœud (worker), exécutez la commande retournée par la commande précédente, quelque chose du genre :

   ```bash
   docker swarm join --token <TOKEN> <IP_NŒUD_MANAGER>:****
   ```

   Cela ajoutera le deuxième nœud à votre cluster Docker Swarm en tant que worker.

2. **Vérification des nœuds :**
   Sur le nœud manager, vous pouvez vérifier que le deuxième nœud a été ajouté avec succès en utilisant :

   ```bash
   docker node ls
   ```

   Vous devriez voir les deux nœuds listés : un manager et un worker.

---

## **3. Déployer une Stack Docker sur le Swarm**

Maintenant que votre Swarm est configuré avec deux nœuds, vous pouvez déployer votre application Docker avec les services définis dans un fichier de stack `docker-stack.yml`.

1. **Créer et taguer les images Docker :**
   Avant de déployer votre stack, assurez-vous que les images de votre application sont prêtes et disponibles dans un registre local. Voici les commandes pour taguer les images et les pousser vers le registre local :

   ```bash
   docker run -d -p 5000:5000 --restart=always --name registry registry:2

   docker tag catsvsdogs-vote localhost:5000/vote
   docker tag catsvsdogs-worker localhost:5000/worker
   docker tag catsvsdogs-result localhost:5000/result

   docker push localhost:5000/vote
   docker push localhost:5000/worker
   docker push localhost:5000/result
   ```

   En effect Docker Swarm ne pourra pas build les images donc il faut lui donner un chemin d'accès, on a choisi la possibilité de le faire via un registre mais publier son image sur Docker Hub est aussi une solution possible

2. **Déployer la stack sur le Swarm :**
   Une fois les images prêtes, utilisez `docker stack deploy` pour déployer votre stack sur le Swarm. Le fichier `docker-stack.yml` doit être configuré comme suit :

   ```bash
   docker stack deploy -c docker-stack.yml catsvsdogs
   ```

3. **Vérifier le déploiement des services :**
   Pour vérifier que les services ont bien été déployés, exécutez :

   ```bash
   docker service ls
   ```

   Cela devrait afficher tous les services de votre stack avec leur état actuel.

---

## **4. Ajouter ou Modifier la Scalabilité des Services**

Docker Swarm permet de modifier facilement le nombre de répliques des services en fonction des besoins. Par exemple, pour augmenter le nombre de répliques du service `worker` à 4, vous pouvez utiliser la commande suivante :

```bash
docker service scale catsvsdogs_worker=4
```

Cela va automatiquement ajuster le nombre de répliques de `worker` et les distribuer entre les nœuds du Swarm. (c'est la scalablilité horizontal possible avec Swarm)

---

## **5. Configurer un Volume Partagé pour la Base de Données**

Si vous souhaitez partager les mêmes données de base de données (par exemple PostgreSQL) entre vos nœuds, vous devez configurer un volume partagé accessible par tous les nœuds. Voici un exemple de volume NFS dans votre fichier `docker-stack.yml` :

```yaml
volumes:
  postgres_data:
    driver: local
    driver_opts:
      type: "nfs"
      o: "addr=<IP_SERVEUR_NFS>,rw"
      device: ":/path/to/nfs/directory"
```

Cela garantit que tous les nœuds accèdent aux mêmes données de base de données.
En effet sans ça, le deuxième noeuds ne pourras pas avoir accès au  docker volume de la première machine   

---

## **6. Vérification et Suivi des Services**

Une fois que tout est déployé, vous pouvez surveiller l'état des services en continu avec :

```bash
docker service ls
docker service ps catsvsdogs_vote
```

Cela vous permettra de suivre les répliques des services et leur état.

---

## **Conclusion**

Ce guide explique comment configurer Docker Swarm avec deux nœuds et déployer une application multi-services. Avec Swarm, vous bénéficiez d'un mécanisme de gestion des services en haute disponibilité et d'un contrôle simplifié sur la scalabilité de vos services. Vous pouvez facilement ajouter des nœuds supplémentaires et ajuster la capacité de vos services en fonction de l'évolution de la charge.

Cela vous permettra de gérer efficacement vos environnements de production Docker, tout en maintenant une infrastructure flexible et scalable.

J'espère que vous avez apprécié la lecture ^^