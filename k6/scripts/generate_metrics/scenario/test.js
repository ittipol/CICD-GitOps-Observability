import http from 'k6/http';
import { check, sleep } from 'k6';
import * as module from '../logs/logger.js'

export function testHealth() {
  const url = 'http://host.docker.internal:5055/health';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function testRequestWithSleep() {
  const url = 'http://host.docker.internal:5055/test';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function test404() {
  const url = 'http://host.docker.internal:5055/xxxxxx';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function testLogin() {
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
  
  const res = http.post(url, payload, params);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}