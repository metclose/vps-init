# vps-init

对 DD 系统后的新机一键初始化（ 添加公钥、改高位端口、启用密钥登录、禁用密码登录 ）

## 一键运行

把公钥和端口替换成你自己的：

```bash
curl -fsSL https://raw.githubusercontent.com/metclose/vps-init/main/init.sh | bash -s -- "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILL9baT/MTkNFuHdhRFZo5aqWHi/10fhBaejaDwDj49k" 55520
```

- 第一个参数：你的 SSH 公钥（整串，用双引号包起来）
- 第二个参数：你想使用的 SSH 端口
