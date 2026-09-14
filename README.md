# wifi-crack

Interactive wrapper for `aircrack-ng`. Pick a wordlist and a capture file from a menu, run the crack, abort anytime with `q`.

交互式 `aircrack-ng` 破解脚本：从菜单中选择字典和 cap 抓包文件，运行破解，随时按 `q` 终止。

## 功能 Features

- 菜单选择字典文件（可选仅列出含 8 位以上密码的字典）Menu-driven wordlist selection (optionally show only lists with 8+ char passwords)
- 从指定目录选择 cap 文件 Pick capture file from a directory
- 破解过程中按 `q` 主动终止 Abort cracking anytime by pressing `q`
- 循环操作，可连续破解多个抓包 Re-run without restarting

## 使用 Usage

```bash
./wifi_crack.sh
```

按提示操作：

1. `1` 选择字典文件（会询问是否只列出 8 位以上密码的字典）select wordlist
2. `2` 选择 cap 文件 select capture file
3. `3` 执行破解 run crack（按 `q` 终止 press `q` to abort）
4. `4` 退出 exit

## 目录配置 Directory config

脚本顶部可修改默认路径（wifi_crack.sh:3-4）：

```bash
WORDLIST_DIR="/home/kali/Desktop/wordlists"   # 字典目录 wordlists dir
CAP_DIR="/home/kali/Desktop/cap"              # 抓包目录 capture dir
```

## 依赖 Dependencies

- aircrack-ng

```bash
sudo apt install aircrack-ng
```