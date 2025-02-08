# Stopper les conteneurs actifs

docker ps
docker stop $(docker ps -q)
docker ps

# # Supprimer les contenants existants 

# docker ps -a
# docker rm $(docker ps -a -q)
# docker ps -a


# Lance le docker compose
docker compose up -d

# Vérifier docker actif

docker ps -a

