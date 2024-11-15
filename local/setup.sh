kubectl apply -f namespace.yaml
kubectl apply -f serviceAccount.yaml
kubectl apply -f volume.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
echo "Waiting for the pod to be ready..."
kubectl wait --for=condition=Ready --timeout=-1s $(kubectl get pods -n jenkins -o name | grep '^pod/jenkins') -n jenkins
echo port: $(kubectl get svc jenkins-service -n jenkins -o jsonpath="{.spec.ports[0].nodePort}")
echo password: $(kubectl exec -it $(kubectl get pods -n jenkins -o name | grep '^pod/jenkins') -n jenkins -- cat /var/jenkins_home/secrets/initialAdminPassword)
