docker build -t leonpsm/multi-client:latest -t leonpsm/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leonpsm/multi-server:latest -t leonpsm/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leonpsm/multi-worker:latest -t leonpsm/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push leonpsm/multi-client:latest
docker push leonpsm/multi-server:latest
docker push leonpsm/multi-worker:latest

docker push leonpsm/multi-client:$SHA
docker push leonpsm/multi-server:$SHA
docker push leonpsm/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leonpsm/multi-server:$SHA
kubectl set image deployments/client-deployment client=leonpsm/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=leonpsm/multi-worker:$SHA
