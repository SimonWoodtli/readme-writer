## Dockerfile used to build image:
## https://hub.docker.com/r/simonwoodtli/readme-writer
FROM alpine:latest
## add /root/.local/bin to PATH
ENV PATH=/root/.local/bin:$PATH
## install dependencies
RUN apk add --update \
  bash jq curl perl git
## symlink bash
RUN ln -sf /bin/bash /usr/bin/bash
## create dir
RUN mkdir -p /root/.local/bin
## fetch latest version of script
RUN wget https://raw.githubusercontent.com/SimonWoodtli/readme-scraper/main/readme-scraper -P /root/.local/bin/
## make it executable
RUN chmod u+x /root/.local/bin/readme-scraper
