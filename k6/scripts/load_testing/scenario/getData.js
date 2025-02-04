import http from 'k6/http';
import { check, sleep } from 'k6';
import * as module from '../logs/logger.js'

export function getDataTest() {
  const url = 'http://host.docker.internal:6068/service/default/Check';
  
  const res = http.get(url);
  check(res, {
    'status is 200': (r) => r.status === 200
  }); 

  module.logger(url, res.status, res.timings.duration)

  sleep(1);
}