#!/bin/bash

# Generate SSH host keys if not exist
ssh-keygen -A

# Create user if not exist
if ! id -u $SSH_USER > /dev/null 2>&1; then
    useradd -m -d /home/$SSH_USER -s /bin/bash $SSH_USER
    echo "$SSH_USER:$SSH_PASSWORD" | chpasswd
fi

# Create .ssh directory
mkdir -p /home/$SSH_USER/.ssh
chmod 700 /home/$SSH_USER/.ssh

# Auto-copy public key if provided
if [ ! -z "$PUBLIC_KEY" ] && [ ! -f /home/$SSH_USER/.ssh/authorized_keys ]; then
    echo "$PUBLIC_KEY" > /home/$SSH_USER/.ssh/authorized_keys
    chmod 600 /home/$SSH_USER/.ssh/authorized_keys
    chown -R $SSH_USER:$SSH_USER /home/$SSH_USER/.ssh
    echo "Public key installed. Next login will be key-based."
else
    echo "No public key provided or key already exists. Password login still active."
fi

# Ensure proper ownership
chown -R $SSH_USER:$SSH_USER /home/$SSH_USER

exec /usr/sbin/sshd -D -e
