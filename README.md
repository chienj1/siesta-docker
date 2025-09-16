# siesta-docker

This repository provides Dockerfiles for building and running **[Siesta](https://siesta-project.org/siesta/)** — a program for performing *Density Functional Theory (DFT)* calculations.

It includes:

- **Build image**: Compiles Siesta from source (single-core version)  
- **Runtime image**: A minimal environment for running Siesta executables

Serial version \
NetCDF enabled 

## Build Instructions

To build the Docker images, run the following commands:

```bash
# Build the image that compiles Siesta from source
docker build -t siesta-build -f Dockerfile.build .

# Build the minimal runtime image
docker build -t siesta-runtime -f Dockerfile.runtime .
```

To run the program with input:
```bash
docker run --rm -it --init -v "$(pwd):/work" -w /work siesta-runtime siesta foo.fdf > foo.out
```

