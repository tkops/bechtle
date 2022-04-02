# Kubernetes / Openshift Deployment Example
## Flowchart Build Process
```mermaid
flowchart TD
  subgraph dev1[Developer]
    build[2. build custom image]
  end
  subgraph pub1[Public Repository]
    docker[docker.io]
  end
  subgraph priv1[Private Repository]
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
      bechtle-web-B-01
      bechtle-web-B-02
    end
    subgraph svc[Service]
      bechtle-web-svc
    end
    subgraph route[Route]
      bechtle-web-route
    end
  end
  subgraph client[Client]
    user[User]
  end
  user --http--> route
  deploy -- create --> rs
  rs -- create --> pod
  route -- route --> svc
  svc -- route --> pod
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
