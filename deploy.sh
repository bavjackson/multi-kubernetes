docker build -t bavjackson/multi-client:latest -t bavjackson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bavjackson/multi-server:latest -t bavjackson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bavjackson/multi-worker:latest -t bavjackson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bavjackson/multi-client:latest
docker push bavjackson/multi-server:latest
docker push bavjackson/multi-worker:latest

docker push bavjackson/multi-client:$SHA
docker push bavjackson/multi-server:$SHA
docker push bavjackson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bavjackson/multi-server:$SHA
kubectl set image deployments/client-deployment client=bavjackson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bavjackson/multi-worker:$SHA