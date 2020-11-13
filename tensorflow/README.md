# TensorFlow Serving and ResNet example

In this example we will show how to deploy TensorFlow Serving and TensorFlow ResNet using bitnami images. To do that, we will follow two appraches, the first using docker-compose and the second one using Helm Charts.

# Get required files

Clone this repo and move to the `tensorflow` directory:

```console
git clone https://github.com/miguelaeh/innosoft-examples
cd innosoft-examples/tensorflow
```

# Using docker-compose

Into the `tensorflow` directory you will find a `docker-compose.yml` file. It will run a serving and a reset container.

They share a volume where the resnet container will initialize the model data that the serving will be serving in next calls.

Execute the following from the `tensorflow` directory:

```console
docker-compose up
```

Now, you should have two containers running. Open a new terminal and check it using:

```console
docker ps
```

You can see the container logs using:

```console
docker-compose logs
```

You will see that the resnet container waits for the serving to be running before continue its own initialization.

Let's initialize the ResNet model into the data folder so the Serving container can start to serve the model:

Exec into the ResNet container by executing:

```console
docker-compose exec tensorflow-resnet bash
```

And run the following commands inside the ResNet container:

```console
curl -o /bitnami/model-data/resnet_v2_fp32_savedmodel_NHWC_jpg.tar.gz http://download.tensorflow.org/models/official/20181001_resnet/savedmodels/resnet_v2_fp32_savedmodel_NHWC_jpg.tar.gz
cd /bitnami/model-data/ && tar -xzf resnet_v2_fp32_savedmodel_NHWC_jpg.tar.gz --strip-components=2
rm resnet_v2_fp32_savedmodel_NHWC_jpg.tar.gz
touch /bitnami/model-data/.initialized
```

We have downloaded a ResNet model and we loaded it into the data folder for the serving service.

Now, we can start to query the serving service and it will process our request based on the loaded model and send back the result:

Execute into the ResNet container the following command:

```console
resnet_client_cc --server_port=tensorflow-serving:8500 --image_file=/tmp/example.jpg
```

> NOTE: We are using here the same ResNet container that was deployed with the docker-compose, but since we already loaded the model into the serving volume, you can run the queries from wherever you want. You just need the `resnet_client_cc` binary in your `PATH`, and change the `--server-port` option to use the proper `IP:PORT`. You will also need to mount the image you want to send using the `-v` option. Be carefull with the Docker networking, the containers created using `docker run` are not in the same network than the ones create using `docker-compose`.

# Using the Bitnami Helm Chart

To use the bitnami Helm Chart we will need to have a Kubernetes cluster available. A simple way to get one is to create it locally using Kind.
Follow this guide to install Kind: https://kind.sigs.k8s.io/docs/user/quick-start/

To create the K8s cluster execute the `create_kind_cluster.sh` script:

```console
bash create_kind_cluster.sh
```

Once, we have out Kubernetes cluster, make sure you added the Bitnami Charts repository as explained in the [setup environment](../README.md) section.

Let's install the Bitnami Helm Chart:

```console
helm install serving bitnami/tensorflow-serving
```

And that's all.

We can skip the step of loading the model since an [init container](https://github.com/bitnami/charts/blob/039a8314982d80b12b700a2bcb5778d259a4dbad/bitnami/tensorflow-resnet/templates/deployment.yaml#L44) will do it for us.
It will be installed using a LoadBalancer service. You can follow the steps shown after the installation to get the service IP to perform queries to the server.

> NOTE: if you are using Kind you will need to configure it to provide LoadBalacer IPs.

Once you got the server IP you can use a container locally to perform the query:

```console
docker run --rm -it -v <path-to-image-file>:/tmp/example.jpg bitnami/tensorflow-resnet resnet_client_cc --server_port=<IP>:8500 --image_file=/tmp/example.jpg
```

