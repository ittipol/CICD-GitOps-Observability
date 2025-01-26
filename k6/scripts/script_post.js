import http from 'k6/http'
import { check, sleep } from 'k6';

export let options = {
    vus: 10,
    stages:[
        {target: 20, duration: '1m'},
        {target: 10, duration: '20s'},
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
        'status = 200': (r) => r.status === 200
    });
    sleep(1);
}