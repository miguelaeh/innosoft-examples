# Machine learning examples for the Innosoft Days

This repo contains examples used to show bitnami solutions, mainly Helm Charts, for Machine Learning (ML).

## Prepare the environment

### T follow the docker-compose examples:

1. Install Docker: https://docs.docker.com/engine/install/

2. Install docker-compose: https://docs.docker.com/compose/install/

### To follow the Kubernetes examples:

1. Install Kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/

2. Install Helm: https://helm.sh/docs/intro/install/

3. Add bitnami Helm Chart repo:

```
helm repo add bitnami https://charts.bitnami.com/bitnami
```

## Examples

1. The first example will deploy Tensorflow Serving that will serve a pre-loaded ResNet model using the [bitnami/tensorflow-serving](https://github.com/bitnami/bitnami-docker-tensorflow-serving) container. In this example, we will also show how to perform queries from the [bitnami/tensorflow-resnet](https://github.com/bitnami/bitnami-docker-tensorflow-resnet) container. We will follow the process either using Helm Charts and docker-compose. Follow the complete guide [here](tensorflow/README.md).

2. TODO: pytorch example


