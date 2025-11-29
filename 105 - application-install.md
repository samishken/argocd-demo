## Application installation


1. access the default password to log in to argocd ui
```
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d; echo
```

2. Log into ArgoCD

```
argocd login localhost:8080
Username: admin
Password: 
```

3. set up and verify your local kubeconfig so your kubectl (and tools that use it like k9s or Argo CD CLI) can talk to the EKS cluster.

```
- aws eks --region us-east-1 update-kubeconfig --name argocd-cluster
- kubectl config current-context
```

4. Register EKS cluster with Argo CD so Argo CD can deploy and manage apps on that cluster.
```
argocd cluster add arn:aws:eks:us-east-1:<AWS_ACCOUNT>:cluster/argocd-cluster
```

5. Deploy the "guestbook" app from the official example repo into your EKS cluster. (Get the destination server ip)
```
argocd app create guestbook --repo https://github.com/argoproj/argocd-example-apps.git  --path guestbook --dest-server https://A62CA7263E52E0796D6E1872363F8B2F.gr7.us-east-1.eks.amazonaws.com --dest-namespace default
```

6. Open browser and go to http://localhost:8081 to access the Guestbook web UI,

```
kubectl port-forward svc/guestbook-ui -n default 8081:80
```

