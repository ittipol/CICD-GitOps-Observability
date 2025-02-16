#!/bin/bash
set -e

metrics() {
    cd ../k6
    docker-compose run --rm k6 run /scripts/generate_metrics/script.js
}

logs() {
    cd ../k6
    docker-compose run --rm k6 run /scripts/generate_logs/script.js
}

traces() {
    cd ../k6
    docker-compose run --rm k6 run /scripts/generate_traces/script.js
}

case "$1" in
    metrics)
		metrics
	;;
    logs)
		logs
	;;
	traces)
		traces
	;;
    *)
        echo "Invalid option" >&2
        exit 1
    ;;
esac