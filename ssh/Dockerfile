FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y openssh-server && apt-get clean

RUN mkdir -p /var/run/sshd /home

COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]
