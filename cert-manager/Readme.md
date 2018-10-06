#Install the helm
helm install --name cert-manager --namespace kube-system stable/cert-manager
#Install the nginx ingress controller
helm install --name nginx-ingress stable/nginx-ingress
