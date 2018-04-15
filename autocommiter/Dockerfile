#FROM alpine/git
FROM samueldebruyn/debian-git

COPY autocommiter.sh /opt/autocommiter.sh
RUN chmod +x /opt/autocommiter.sh && \
    apt update && \
    apt install -y jq curl

CMD /opt/autocommiter.sh
