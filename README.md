# Bechtle Misc
## Flowchart
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
## Instructions
```
podman login -u t_koch quay.io
podman build -t bechtle-web
podman tag bechtle-web quay.io/t_koch/bechtle-web:v1.0
podman push quay.io/t_koch/bechtle-web:v1.0
```
