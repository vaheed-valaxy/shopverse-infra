## ArgoCD Port Forward  
```bash
kubectl port-forward \
  -n argocd \
  svc/argocd-server \
  8090:80 \
  --address 0.0.0.0 \
  > /tmp/argocd-port-forward.log 2>&1 &

nohup kubectl port-forward \
  -n argocd \
  svc/argocd-server \
  8090:80 \
  --address 0.0.0.0 \
  > /tmp/argocd-port-forward.log 2>&1 &
```

## Initial Admin Password  
```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
echo
```
