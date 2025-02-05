import { testLogDebug, testLogInfo, testLogWarn, testLogError } from './scenario/test.js'

export const options = {
  discardResponseBodies: true,
  scenarios: {
    "log-debug": {
      executor: 'per-vu-iterations',
      exec: 'test1',
      vus: 1,
      iterations: 10,
    },
    "log-info": {
      executor: 'per-vu-iterations',
      exec: 'test2',
      vus: 1,
      iterations: 10,
    },
    "log-warn": {
      executor: 'per-vu-iterations',
      exec: 'test3',
      vus: 1,
      iterations: 10,
    },
    "log-error": {
      executor: 'per-vu-iterations',
      exec: 'test4',
      vus: 1,
      iterations: 10,
    },
  },
};

export function test1() {
  testLogDebug()
}

export function test2() {
  testLogInfo()
}

export function test3() {
  testLogWarn()
}

export function test4() {
  testLogError()
}