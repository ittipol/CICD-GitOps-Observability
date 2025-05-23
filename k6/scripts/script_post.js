import http from 'k6/http'
import { check, sleep } from 'k6';

export let options = {
    vus: 1,
    stages:[
        {target: 50, duration: '1m'},
        {target: 50, duration: '1m'},
        {target: 5, duration: '20s'},
    ]
}

export default function() {
    const url = 'http://host.docker.internal:5055/login';
    const payload = JSON.stringify({
        email: 'test@mail.com',
        password: '1234',
    });

    const params = {
        headers: {
            'Content-Type': 'application/json',
        },
    };
    
    const response = http.post(url, payload, params);
    check(response, {
        "status = 200": (r) => r.status == 200,
        "transaction time OK": (r) => r.timings.duration < 200
    });
    sleep(1);
}
