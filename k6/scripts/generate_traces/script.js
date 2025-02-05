import http from 'k6/http'
import { check, sleep } from 'k6';

export let options = {
    vus: 1,
    stages:[
        {target: 5, duration: '10s'}
    ]
}

export default function() {
    const response = http.get("http://host.docker.internal:5055/trace")
    check(response, {
        "status is 200": (r) => r.status == 200,
    });
    sleep(1);
}
