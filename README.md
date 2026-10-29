# vps-init

对 DD 系统后的新机一键初始化（ 添加公钥、改高位端口、启用密钥登录、禁用密码登录 ）

## 一键运行

建议在编辑器中改好公钥端口再粘贴至服务器：

```bash
curl -fsSL https://raw.githubusercontent.com/metclose/vps-init/main/init.sh | bash -s -- \
  "你的公钥" \
  "你的端口"
```

例如：

```bash
curl -fsSL https://raw.githubusercontent.com/metclose/vps-init/main/init.sh | bash -s -- \
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOVtWN+UduTfoVmonlHIW21g5glLiE4DD2kgrOrPt0rp" \
  "55520"
```
