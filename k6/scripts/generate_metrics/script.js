import { testHealth, testRequestWithSleep, test404, testLogin } from './scenario/test.js'

export const options = {
  discardResponseBodies: true,
  scenarios: {
    "health": {
      executor: 'per-vu-iterations',
      exec: 'test1',
      vus: 1,
      iterations: 10,
    },
    "request-with-sleep": {
      executor: 'per-vu-iterations',
      exec: 'test2',
      vus: 1,
      iterations: 10,
    },
    "request-404": {
      executor: 'per-vu-iterations',
      exec: 'test3',
      vus: 1,
      iterations: 10,
    },
    "login": {
      executor: 'per-vu-iterations',
      exec: 'test4',
      vus: 1,
      iterations: 10,
    },
  },
};

export function test1() {
  testHealth()
}

export function test2() {
  testRequestWithSleep()
}

export function test3() {
  test404()
}

export function test4() {
  testLogin()
}