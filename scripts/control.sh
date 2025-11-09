#!/usr/bin/env bash

if [ "$1" == "" ]; then
    echo "Help"
    echo "Arguments: drain, start"
    echo "./control.sh drain"
    echo "Get all nodes and drain them one by one"
    echo "./control.sh start"
    echo "Uncordon all nodes"
fi

if [ "$1" == "drain" ]; then
    NODES=($(kubectl get nodes -o name))
    for NODE in "${NODES[@]}"; do
        kubectl drain --ignore-daemonsets --delete-emptydir-data $NODE
    done
    echo ""
    echo "Draining completed"
    kubectl get node
fi

if [ "$1" == "start" ]; then
    NODES=($(kubectl get nodes -o name))
    for NODE in "${NODES[@]}"; do
        kubectl uncordon $NODE
    done
fi