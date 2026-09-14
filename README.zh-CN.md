# wifi-crack

基于 `aircrack-ng` 的交互式破解脚本。从菜单中选择字典和 cap 抓包文件，运行破解，随时按 `q` 终止。

[English](README.md)

> **免责声明**：本工具仅用于学习、测试和安全研究。未经授权破解 WiFi 网络属违法行为。使用本工具的一切后果由使用者自行承担。请勿对非本人拥有或未经明确授权的网络使用本工具。

## 功能

- 菜单选择字典文件，可选仅列出含 8 位以上密码的字典
- 从指定目录选择 cap 抓包文件
- 破解过程中按 `q` 主动终止
- 循环操作，可连续破解多个抓包，无需重启

## 使用

```bash
./wifi_crack.sh
```

菜单：

1. 选择字典文件（会询问是否只列出 8 位以上密码的字典）
2. 选择 cap 文件
3. 执行破解（按 `q` 终止）
4. 修改目录配置
5. 退出

## 首次运行

首次运行会引导你输入密码库文件夹和 cap 文件夹路径，保存到 `~/.config/wifi-crack.conf`，之后启动自动读取。可通过菜单 `4` 随时重新配置。

示例：

```bash
=== 请配置目录 ===
密码库文件夹路径: /home/kali/Desktop/wordlists
cap抓包文件夹路径: /home/kali/Desktop/cap
```

删除 `~/.config/wifi-crack.conf` 即可重新运行配置向导。

## 依赖

- aircrack-ng

```bash
sudo apt install aircrack-ng
```