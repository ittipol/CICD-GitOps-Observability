import http from 'k6/http';
import { check, sleep } from 'k6';
import * as module from '../logs/logger.js'

export function testLogDebug() {
  const url = 'http://host.docker.internal:5055/debug';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function testLogInfo() {
  const url = 'http://host.docker.internal:5055/info';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function testLogWarn() {
  const url = 'http://host.docker.internal:5055/warn';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}

export function testLogError() {
  const url = 'http://host.docker.internal:5055/error';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}