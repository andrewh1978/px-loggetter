# What

This will collect Portworx logs from all nodes in the cluster and dump them to `/var/tmp/px-loggetter`.

# How

1. Ensure your Kubernetes cluster is up and running:
```
[root@master-2 ~]# kubectl get nodes
NAME       STATUS   ROLES    AGE     VERSION
master-2   Ready    master   5h59m   v1.16.2
node-2-1   Ready    <none>   5h58m   v1.16.2
node-2-2   Ready    <none>   5h58m   v1.16.2
node-2-3   Ready    <none>   5h58m   v1.16.2
```

2. Clone this repo:
```
Cloning into 'px-loggetter'...
remote: Enumerating objects: 23, done.
remote: Counting objects: 100% (23/23), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 23 (delta 8), reused 10 (delta 2), pack-reused 0
Unpacking objects: 100% (23/23), done.
```

3. Configure:
```
[root@master-2 ~]# cd px-loggetter
[root@master-2 px-preflight]# vi go.sh
```

 * Verify the `NODES` variable is being populated according to your infrastructure

4. Run:
```
[root@master-2 px-loggetter]# sh go.sh
