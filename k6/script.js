import http from 'k6/http'

export let options = {
    stages:[
        {target: 5, duration: '5s'},
        {target: 50, duration: '1m'},
        {target: 10, duration: '20s'},
    ]
}

export default function() {
    http.get("http://host.docker.internal:5055/health")
}