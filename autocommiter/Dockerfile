FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt
COPY autocommiter.sh autocommiter.sh
RUN chmod +x autocommiter.sh && \
    apt update && \
    apt install -y jq curl git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_*

CMD ./autocommiter.sh
