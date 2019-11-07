docker build -t aye20dockerhub/multi-client:latest -t aye20dockerhub/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aye20dockerhub/multi-server:latest -t aye20dockerhub/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aye20dockerhub/multi-worker:latest -t aye20dockerhub/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aye20dockerhub/multi-client:latest
docker push aye20dockerhub/multi-server:latest
docker push aye20dockerhub/multi-worker:latest

docker push aye20dockerhub/multi-client:$SHA
docker push aye20dockerhub/multi-server:$SHA
docker push aye20dockerhub/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aye20dockerhub/multi-server:$SHA
kubectl set image deployments/client-deployment client=aye20dockerhub/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aye20dockerhub/multi-worker:$SHA