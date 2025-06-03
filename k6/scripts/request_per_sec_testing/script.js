import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
    discardResponseBodies: true,
    scenarios: {
        content: {
            executor: 'per-vu-iterations',
            vus: 1,
            iterations: 1000,
            startTime: '0s',
            maxDuration: '1h',
        }
    },
    thresholds: {
        http_req_failed: ['rate<=0.05'],
        http_req_duration: ['p(90) < 400'],
        http_req_duration: ['p(95) < 800'],
        http_req_duration: ['p(99.9) < 2000'],
    },
};

export default function () {
    // const delay = Math.floor(Math.random() * 5) + 1;
    const res = http.get('http://localhost:3000/test');

    check(res, {
        'status is 200': (r) => r.status === 200
    }); 

    // sleep(Math.random() * 5);
    sleep(1)
}