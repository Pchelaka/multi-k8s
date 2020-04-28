docker build -t destination/multi-client:latest -t destination/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t destination/multi-server:latest -t destination/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t destination/multi-worker:latest -t destination/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push destination/multi-client:latest
docker push destination/multi-server:latest
docker push destination/multi-worker:latest

docker push destination/multi-client:$SHA
docker push destination/multi-server:$SHA
docker push destination/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=destination/multi-client:$SHA
kubectl set image deployments/server-deployment server=destination/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=destination/multi-worker:$SHA 