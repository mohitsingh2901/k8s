eksctl create cluster \
--name flink-cluster \
--version 1.18 \
--region us-east-1 \
--nodegroup-name linux-nodes \
--node-type t2.large \
--nodes 2

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml
kubectl get deployment metrics-server -n defualt
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta8/aio/deploy/recommended.yaml
kubectl apply -f eks-admin-service-account.yaml
kubectl -n default describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
kubectl proxy &
echo "use the token to connect to login to dashboard!!!"
echo "<herf>http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login</herf>"
echo "Now deploy the flink session cluster"
cd /Users/snghwrd/kubernetes/flink-on-k8s-operator
make deploy
echo "kubectl apply -f config/samples/flinkoperator_v1beta1_flinksessioncluster.yaml"
echo "cd ../k8s/eks/"
echo "start the flink ui"
echo "kubectl port-forward svc/[FLINK_CLUSTER_NAME]-jobmanager 8081:8081 &"
echo "submit world count job"
echo "kubectl apply -f wordcount.yaml"