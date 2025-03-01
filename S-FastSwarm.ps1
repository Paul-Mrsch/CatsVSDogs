##si les images ont déjà été construites script plus rapide que S-RunDockerWithSwarm.ps1

docker service ls
docker service rm $(docker service ls -q)
docker service ls

docker run -d -p 5000:5000 --restart=always --name registry registry:2

docker tag catsvsdogs-vote localhost:5000/vote
docker tag catsvsdogs-worker localhost:5000/worker
docker tag catsvsdogs-result localhost:5000/result

docker push localhost:5000/vote
docker push localhost:5000/worker
docker push localhost:5000/result

docker stack deploy -c docker-stack.yml catsvsdogs

docker service ls

docker service scale catsvsdogs_worker=4

docker service ls

docker swarm join-token worker