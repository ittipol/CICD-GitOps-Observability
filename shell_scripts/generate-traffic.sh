#!/bin/bash

# link multiple commands
curl -s http://localhost:5055/debug; curl -s http://localhost:5055/info; curl -s http://localhost:5055/warn; curl -s http://localhost:5055/error

# watch 'curl -s http://localhost:5055/debug; curl -s http://localhost:5055/info; curl -s http://localhost:5055/warn; curl -s http://localhost:5055/error'

# k6 run test1.js ; k6 run test2.js ; …

# k6 run test1_spec.js &
# k6 run test2_spec.js &
# k6 run test3_spec.js