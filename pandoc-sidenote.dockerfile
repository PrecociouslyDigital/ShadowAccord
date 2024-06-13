FROM pandoc/minimal:latest-ubuntu
RUN apt-get -y update && apt-get -y install pandoc-sidenote && rm -rf /var/lib/apt/lists/*
