# Pytorch word language model example

In this example we will show how to train a LSTM model and use that model to create a text of 1000 words.

# Get required files

Clone this repo and move to the `pytorch` directory:

```console
git clone https://github.com/miguelaeh/innosoft-examples
cd innosoft-examples/pytorch
```

We will use the code at [the TensorFlow examples repo](https://github.com/pytorch/examples.git). It is already added as submodule, to initialize the git submodules execute the following:

```console
git submodule init --update
```

# Training the model

> NOTE: In this example we will mount local folders into the docker image to be able to use the Python code and to avoid losing the trained models.

First, let's create a container and exec into it, mounting the code we hace just downloaded, to start training the model. Execute the following from the `pytorch` directory.

```console
docker run --rm -it -v `pwd`/examples/word_language_model:/app bitnami/pytorch bash
```

Ensure the files have been properly mounted by executing `ls -l`. The output should be similar to the following:

```console
I have no name!@ae81a52b4d9e:/app$ ls -l
total 54696
-rw-rw-r-- 1 1001 1000     2914 Nov 24 15:59 README.md
drwxr-xr-x 2 1001 root     4096 Nov 24 16:06 __pycache__
drwxrwxr-x 3 1001 1000     4096 Nov 24 15:59 data
-rw-rw-r-- 1 1001 1000     1482 Nov 24 15:59 data.py
-rw-rw-r-- 1 1001 1000     3080 Nov 24 15:59 generate.py
-rw-rw-r-- 1 1001 1000    10210 Nov 24 15:59 main.py
-rw-r--r-- 1 1001 root 55955986 Nov 24 16:21 model.pt
-rw-rw-r-- 1 1001 1000     6367 Nov 24 15:59 model.py
-rw-rw-r-- 1 1001 1000        6 Nov 24 15:59 requirements.txt
```

Let's train the model:

```console
python main.py --epochs 6
```

You should see something like the following:

```
I have no name!@c20227d78abe:/app$ python main.py --epochs 6


| epoch   1 |   200/ 2983 batches | lr 20.00 | ms/batch 275.91 | loss  7.64 | ppl  2081.53
| epoch   1 |   400/ 2983 batches | lr 20.00 | ms/batch 257.21 | loss  6.86 | ppl   951.76
| epoch   1 |   600/ 2983 batches | lr 20.00 | ms/batch 262.82 | loss  6.49 | ppl   656.18
| epoch   1 |   800/ 2983 batches | lr 20.00 | ms/batch 278.12 | loss  6.30 | ppl   545.85
| epoch   1 |  1000/ 2983 batches | lr 20.00 | ms/batch 310.73 | loss  6.15 | ppl   470.88
| epoch   1 |  1200/ 2983 batches | lr 20.00 | ms/batch 279.13 | loss  6.06 | ppl   428.85
| epoch   1 |  1400/ 2983 batches | lr 20.00 | ms/batch 271.61 | loss  5.95 | ppl   382.26
| epoch   1 |  1600/ 2983 batches | lr 20.00 | ms/batch 293.87 | loss  5.95 | ppl   383.62
| epoch   1 |  1800/ 2983 batches | lr 20.00 | ms/batch 344.54 | loss  5.80 | ppl   328.82
| epoch   1 |  2000/ 2983 batches | lr 20.00 | ms/batch 277.37 | loss  5.77 | ppl   320.32
| epoch   1 |  2200/ 2983 batches | lr 20.00 | ms/batch 304.51 | loss  5.66 | ppl   285.80
| epoch   1 |  2400/ 2983 batches | lr 20.00 | ms/batch 293.11 | loss  5.67 | ppl   290.47
| epoch   1 |  2600/ 2983 batches | lr 20.00 | ms/batch 286.82 | loss  5.66 | ppl   287.38
| epoch   1 |  2800/ 2983 batches | lr 20.00 | ms/batch 271.11 | loss  5.54 | ppl   254.25
-----------------------------------------------------------------------------------------
| end of epoch   1 | time: 891.63s | valid loss  5.56 | valid ppl   259.02
-----------------------------------------------------------------------------------------
| epoch   2 |   200/ 2983 batches | lr 20.00 | ms/batch 281.76 | loss  5.54 | ppl   255.24
| epoch   2 |   400/ 2983 batches | lr 20.00 | ms/batch 273.99 | loss  5.52 | ppl   250.66
| epoch   2 |   600/ 2983 batches | lr 20.00 | ms/batch 271.26 | loss  5.36 | ppl   212.21
| epoch   2 |   800/ 2983 batches | lr 20.00 | ms/batch 267.95 | loss  5.37 | ppl   215.91
| epoch   2 |  1000/ 2983 batches | lr 20.00 | ms/batch 456.79 | loss  5.35 | ppl   209.67
| epoch   2 |  1200/ 2983 batches | lr 20.00 | ms/batch 281.69 | loss  5.33 | ppl   206.82
```

This will take some time to complete. You can dicrease the epochs for testing purpose to make faster. It should create a file called `./model.pt`.

Once it finish, to generate a text of `1000` words from the trained
model execute the following:

```console
 python generate.py
```

You should get something like:

```
I have no name!@ae81a52b4d9e:/app$ python generate.py --seed=1
| Generated 0/1000 words
| Generated 100/1000 words
| Generated 200/1000 words
| Generated 300/1000 words
| Generated 400/1000 words
| Generated 500/1000 words
| Generated 600/1000 words
| Generated 700/1000 words
| Generated 800/1000 words
| Generated 900/1000 words
```

And the resulting text is stored into a file called `generated.txt`. Execute a `cat` to show its content:

```console
cat generated.txt
```

You can play with the text generation options as well as with the parameters for the model training. See: https://github.com/pytorch/examples/tree/master/word_language_model.

You can also check the bitnami Helm Chart to train models in a distributed way using Pytorch at: https://github.com/bitnami/charts/tree/master/bitnami/pytorch
