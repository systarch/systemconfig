# Select reference image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HAS_BUILDTOOLS=yes

# Create app directory
WORKDIR /src

# Copy project files into the docker image
COPY . .

# Install
RUN apt-get update -y && apt install -y make git
RUN make install-buildtools

# run the build-process
ENTRYPOINT ["/usr/bin/make", "build"]
