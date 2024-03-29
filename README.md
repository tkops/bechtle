# Kubernetes / Openshift Deployment Example
||Dieser Text ist versteckt||
## Flowchart Build Process
```mermaid
flowchart TD
  subgraph dev1[Developer]
    build[2. build custom image]
  end
  subgraph pub1[Public Registry]
    docker[registry.redhat.io]
  end
  subgraph priv1[Private Registry]
    quay[quay.io/t_koch]
  end
  subgraph ocp1[Openshift]
    subgraph master
      m1;m2;m3
    end
    subgraph worker
      w1;w2
    end
  end
dev1 -- 1. pull base image --- pub1
dev1 -- 3. push custom image --- priv1
priv1 -- 4. deploy --- ocp1
```

## Flowchart Deployment Resource
```mermaid
flowchart TD
  subgraph app[bechtle-web-app]
    subgraph deploy[Deployment]
      bechtle-web
    end
    subgraph rs[Replicaset]
      bechtle-web-A
      bechtle-web-B
      bechtle-web-C
    end
    subgraph pod[Pods]
      pod1[bechtle-web-B-01]
      pod2[bechtle-web-B-02]
    end
    subgraph svc[Service]
      svc1[bechtle-web-svc]
    end
    subgraph route[Route]
      bechtle-web-route
    end
  end
  subgraph client[Client]
    user[User]
  end
  user --http--> bechtle-web-route
  user --deploy-->deploy
  deploy -- create --> rs
  rs -- create --> pod
  bechtle-web-route -- route --> svc1
  svc1 -- route --> pod1
  svc1 -- route --> pod2
```

## Instructions
### Window 1
```
source vars
oc create ns $namespace
sh build.sh <version>
```
### Window 2
```
while true;do curl bechtle-web-route-bechtle.apps.tk.env.av360.org;sleep 1;done
```
### Window 3
```
watch oc get all -n $namespace
```
