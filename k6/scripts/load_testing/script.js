import { healthCheckTest } from './scenario/healthCheck.js'
import { getDataTest } from './scenario/getData.js'

export const options = {
  // discardResponseBodies: true,
  scenarios: {
    "health-check": {
      executor: 'per-vu-iterations',
      exec: 'healthCheck',
      vus: 100,
      // maxDuration: '1m',
      iterations: 1,
    },
    "get-data": {
      executor: 'per-vu-iterations',
      exec: 'getData',
      vus: 1,
      iterations: 1,
      startTime: '2s',
      // maxDuration: '1m',
    },
  },
};

export function healthCheck() {
  healthCheckTest()
}

export function getData() {
  getDataTest()
}