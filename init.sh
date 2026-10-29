#!/usr/bin/env bash
set -euo pipefail

PUBKEY="${1:-}"
PORT="${2:-}"

if [[ -z "$PUBKEY" || -z "$PORT" ]]; then
  echo "脚本已退出，请添加公钥或端口参数"
  exit 1
fi

# 1. 确保 .ssh 目录存在并设置权限
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# 2. 清空并写入公钥
echo "$PUBKEY" > ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# 3. 删除端口+删除密钥+删除密码
sed -i '/^#*Port/d' /etc/ssh/sshd_config
sed -i '/^#*PubkeyAuthentication/d' /etc/ssh/sshd_config
sed -i '/^#*PasswordAuthentication/d' /etc/ssh/sshd_config

# 4. 添加端口+启用密钥+禁用密码
echo "Port $PORT" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# 4. 重启ssh
systemctl daemon-reload
systemctl restart ssh.socket 2>/dev/null || systemctl restart sshd
