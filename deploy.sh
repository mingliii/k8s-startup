docker build -t bluerediceye/client:lastest -t bluerediceye/client:$SHA -f ./client/Dockerfile ./client
docker build -t bluerediceye/server:lastest -t bluerediceye/server:$SHA -f ./server/Dockerfile ./server
docker build -t bluerediceye/worker:lastest -t bluerediceye/worker:$SHA -f ./worker/Dockerfile ./worker

docker push bluerediceye/client:lastest
docker push bluerediceye/server:lastest
docker push bluerediceye/worker:lastest

docker push bluerediceye/client:$SHA
docker push bluerediceye/server:$SHA
docker push bluerediceye/worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=bluerediceye/server:$SHA
kubectl set image deployment/client-deployment client=bluerediceye/client:$SHA
kubectl set image deployment/worker-deployment worker=bluerediceye/worker:$SHA

