# Supprimer les services existants
docker service ls
docker service rm $(docker service ls -q)
docker service ls

# stopper les conteneurs actifs
docker ps
docker stop $(docker ps -q)
docker ps

# Supprimer les contenants existants 

docker ps -a
docker rm $(docker ps -a -q)
docker ps -a

# supprime le registre Docker local
docker rm -f registry

# reset docker si besoin (pense a commenté les lignes ci-dessus si tu veux pas tout supprimer) 
docker system prune -a --volumes -f
docker network prune -f
docker volume prune -f
docker image prune -a -f



