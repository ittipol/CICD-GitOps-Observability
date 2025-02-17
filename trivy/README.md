# Trivy

``` bash
# Scan a container image
trivy image node:18.20-alpine3.21

# Output format spdx-json
trivy image --scanners vuln --format spdx-json --output result_spdx.json repo:tag

# Generate List from spdx-json format
trivy sbom result_spdx.json

# Scan config files for misconfigurations
trivy config /path/to/project_dir

# Scan local filesystem
# Scan a local project including language-specific files
trivy filesystem --scanners vuln,secret,misconfig /path/to/project_dir

#  Output format cyclonedx
trivy filesystem --scanners vuln --format cyclonedx --output result.json ./dotnet_8

# Scan a single file
trivy filesystem ./pato/to/file
```