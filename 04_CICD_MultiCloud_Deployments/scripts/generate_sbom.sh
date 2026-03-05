
#!/usr/bin/env bash
set -e

IMAGE=$1

echo "Generating SBOM for $IMAGE"
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock   anchore/syft:latest $IMAGE -o json > sbom.json

echo "SBOM saved to sbom.json"
