# siesta-docker
Dockerfile for single-core build-from-source siesta. Plus, minimal version just for run.

how to build the image: \
docker build -t siesta-build -f Dockerfile.build .
docker build -t siesta-runtime -f Dockerfile.runtime .
