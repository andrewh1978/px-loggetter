# What

This will collect Portworx logs from all nodes in the cluster and dump them to `/var/tmp/px-loggetter`. This can then be consumed by an ELK stack.

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

2. Clone this repo to your master node:
```
Cloning into 'px-loggetter'...
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
remote: Compressing objects: 100% (9/9), done.
remote: Total 12 (delta 4), reused 11 (delta 3), pack-reused 0
Unpacking objects: 100% (12/12), done.
```

3. Configure:
```
[root@master-2 ~]# cd px-loggetter
[root@master-2 px-loggetter]# vi go.sh
```

 * Verify the `NODES` variable is being populated according to your infrastructure

4. Run:
```
[root@master-2 px-loggetter]# sh go.sh
```

5. Clone this repo to your laptop.

6. Copy `/var/tmp/loggetter` to where you clone the repo.

7. Start ELK:
```
mbp$ docker run -e MAX_MAP_COUNT=262144 -p 5601:5601 -p 9200:9200 -p 5044:5044 -v $PWD/loggetter:/loggetter -v $PWD/conf.d:/etc/logstash/conf.d --rm -it --name elk sebp/elk
```

8. Browse to `http://localhost:5601`.

9. Click 'Connect to your Elasticsearch index'.

10. Under Index Pattern, enter `*` and click Next.

11. From the dropdown, select @timestamp and click Create.

12. On the far left, click the compass icon for Discover.
