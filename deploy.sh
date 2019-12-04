docker build -t psenos/multi-client:latest -t psenos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t psenos/multi-server:latest -t psenos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t psenos/multi-worker:latest -t psenos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push psenos/multi-client:latest
docker push psenos/multi-server:latest
docker push psenos/multi-worker:latest

docker push psenos/multi-client:$SHA
docker push psenos/multi-server:$SHA
docker push psenos/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=psenos/multi-client:$SHA
kubectl set image deployments/server-deployment server=psenos/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=psenos/multi-worker:$SHA