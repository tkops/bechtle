#!/bin/bash

# source vars
source ./vars

if [[ -z $1 ]];then
  echo "you have to set version :)"
  exit
fi
 

# clean up container and ocp deployment
podman ps -aq|xargs podman rm -f 2>/dev/null

# set version in index.html
echo "Hello Team Datacenter! Version: $version" > index.html

# build image based on Containerfile
podman build -t ${name}:${version} .

# create tag to push image to registry
podman tag ${name}:${version} $image

# push image to registry
podman push $image

# create container with new image on localhost
podman run --name $name -d -p ${lport}:${cport} $image
echo; sleep 5

# test http on localhost
curl localhost:${lport}

# create openshift deployment
oc create -n $namespace deployment $name --replicas=2 --image=$image  -oyaml --dry-run=client |oc apply -f -

# create openshift service
oc expose deployment -n $namespace $name --port=8080  -oyaml --dry-run=client |oc apply -f -


# create route to service
oc expose service -n $namespace $name  -oyaml --dry-run=client |oc apply -f -


