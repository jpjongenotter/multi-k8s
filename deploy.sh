docker build -t jpjongenotter/multi-client:latest -t jpjongenotter/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jpjongenotter/multi-server:latest -t jpjongenotter/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jpjongenotter/multi-worker:latest -t jpjongenotter/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jpjongenotter/multi-client:latest
docker push jpjongenotter/multi-server:latest
docker push jpjongenotter/multi-worker:latest

docker push jpjongenotter/multi-client:$SHA
docker push jpjongenotter/multi-server:$SHA
docker push jpjongenotter/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jpjongenotter/multi-server:$SHA
kubectl set image deployments/client-deployment client=jpjongenotter/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jpjongenotter/multi-worker:$SHA