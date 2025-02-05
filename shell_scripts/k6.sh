#!/bin/bash
set -e

logs() {
    cd ../k6
    docker-compose run --rm k6 run /scripts/generate_logs/script.js
}

traces() {
    cd ../k6
    docker-compose run --rm k6 run /scripts/generate_traces/script.js
}

case "$1" in
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