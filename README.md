# vps-init

对 DD 系统后的新机一键初始化（ 添加公钥、改高位端口、启用密钥登录、禁用密码登录 ）

## 一键运行

```bash
curl -fsSL https://raw.githubusercontent.com/metclose/vps-init/main/init.sh | bash -s -- \
  "你的公钥" \
  "你的端口"
```

例如：

```bash
curl -fsSL https://raw.githubusercontent.com/metclose/vps-init/main/init.sh \
  | bash -s -- "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILL9baT/MTkNFuHdhRFZo5aqWHi/10fhBaejaDwDj49k" "55520"
```
