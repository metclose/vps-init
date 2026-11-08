#!/bin/sh
set -eu

PUBKEY="${1:-}"
PORT="${2:-}"

if [ -z "$PUBKEY" ] || [ -z "$PORT" ]; then
  echo "脚本已退出，请添加公钥或端口参数"
  exit 1
fi

# ── 系统检测 ──
IS_ALPINE=0
if [ -f /etc/alpine-release ]; then
  IS_ALPINE=1
fi

# 1. 确保 .ssh 目录存在并设置权限
mkdir -p /root/.ssh
chmod 700 /root/.ssh

# 2. 清空并写入公钥
echo "$PUBKEY" > /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# 3. 删除端口+删除密钥+删除密码（两套系统通用）
sed -i '/^[#[:space:]]*Port/d' /etc/ssh/sshd_config
sed -i '/^[#[:space:]]*PubkeyAuthentication/d' /etc/ssh/sshd_config
sed -i '/^[#[:space:]]*PasswordAuthentication/d' /etc/ssh/sshd_config

# 4. 添加端口+启用密钥+禁用密码（两套系统通用）
echo "Port $PORT" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

# 5. 按系统重启服务
if [ "$IS_ALPINE" -eq 1 ]; then
  sshd -t || { echo "sshd_config 语法错误，未重启"; exit 1; }
  rc-service sshd restart
else
  systemctl daemon-reload
  systemctl restart ssh.socket 2>/dev/null || systemctl restart sshd
fi
