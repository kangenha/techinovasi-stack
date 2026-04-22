#!/bin/bash

# Create FTP user if not exists
if ! id -u $FTP_USER > /dev/null 2>&1; then
    useradd -m -d /home/$FTP_USER -s /bin/bash $FTP_USER
    echo "$FTP_USER:$FTP_PASS" | chpasswd
fi

# Set proper permission
chown -R $FTP_USER:$FTP_USER /home/$FTP_USER

# Create empty directory for secure_chroot
mkdir -p /var/run/vsftpd/empty

# Start vsftpd
echo "Starting vsftpd on port 21 (explicit FTPS)..."
vsftpd /etc/vsftpd.conf
