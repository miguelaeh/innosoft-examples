#!/bin/bash

cat > /tmp/config.yaml <<EOF
# three node (two workers) cluster config
kind: Cluster
apiVersion: kind.sigs.k8s.io/v1alpha3
nodes:
- role: control-plane
- role: worker
- role: worker
EOF

kind create cluster --config /tmp/config.yaml
