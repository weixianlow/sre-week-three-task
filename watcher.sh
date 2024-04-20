#TODO

NAMESPACE="sre"

DEPLOYMENT="swype-app"

MAX_RESTARTS=3

while true; do
    RESTARTS=$(kubectl get pods -n ${NAMESPACE} -l app=${DEPLOYMENT} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")

    echo "Current number of restarts: ${RESTARTS}"

    if ((RESTARTS > MAX_RESTARTS )); then
        echo "Maximum number of restarts exceeded. Will now scaling down the deployment."
        kubectl scale --replicas=0 deployment/${DEPLOYMENT} -n ${NAMESPACE}
        break
    fi

    sleep 60
done