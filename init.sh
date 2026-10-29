#!/usr/bin/env bash
set -euo pipefail

# 1. 确保 .ssh 目录存在并设置权限
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# 2. 清空并写入公钥
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILL9baT/MTkNFuHdhRFZo5aqWHi/10fhBaejaDwDj49k" > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 3. 删除端口+启用密钥+禁用密码
sed -i '/^#*Port/d' /etc/ssh/sshd_config
sed -i '/^#*PubkeyAuthentication/d' /etc/ssh/sshd_config
sed -i '/^#*PasswordAuthentication/d' /etc/ssh/sshd_config

echo "Port 55520" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# 4. 重启ssh
systemctl daemon-reload
systemctl restart ssh.socket 2>/dev/null || systemctl restart sshd
