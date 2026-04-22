FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y vsftpd openssl && apt-get clean

RUN mkdir -p /etc/vsftpd /var/run/vsftpd/empty /home/ftpuser

# Generate self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/vsftpd/vsftpd.key \
    -out /etc/vsftpd/vsftpd.crt \
    -subj "/C=ID/ST=Jakarta/L=Jakarta/O=TechInovasi/CN=10.10.10.1"

COPY vsftpd.conf /etc/vsftpd.conf

EXPOSE 21 40000-40009

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
