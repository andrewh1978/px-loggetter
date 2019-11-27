#!/bin/bash

NODES=$(kubectl get nodes -o wide -l 'px/enabled!=false,!node-role.kubernetes.io/master' --no-headers | awk '{print$6}')

kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: loggetter-config
  namespace: kube-system
data:
  nodes: "$NODES"
EOF

kubectl apply -f node.yml
kubectl wait pod -lname=node --for=condition=ready -n kube-system
NODE_PODS=$(kubectl get pods -lname=node -n kube-system --no-headers -o custom-columns=NAME:.metadata.name)

>/var/tmp/loggetter
for p in $NODE_PODS; do kubectl logs $p -n kube-system --tail=-1 >>/var/tmp/loggetter ; done

kubectl delete cm loggetter-config -n kube-system
kubectl delete cm node-script -n kube-system
kubectl delete ds node -n kube-system
