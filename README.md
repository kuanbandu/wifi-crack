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

按提示操作：

1. `1` 选择字典文件（会询问是否只列出 8 位以上密码的字典）select wordlist
2. `2` 选择 cap 文件 select capture file
3. `3` 执行破解 run crack（按 `q` 终止 press `q` to abort）
4. `4` 修改目录配置 reconfigure directories
5. `5` 退出 exit

## 首次运行 First run

首次运行会引导你输入密码库文件夹和 cap 文件夹路径，保存到 `~/.config/wifi-crack.conf`，之后启动自动读取。可通过菜单 `4` 随时重新配置。

On first run you'll be asked to enter the wordlist directory and capture directory, saved to `~/.config/wifi-crack.conf` and auto-loaded afterwards. Use menu `4` to reconfigure anytime.

示例 Example：

```bash
=== 请配置目录 ===
密码库文件夹路径: /home/kali/Desktop/wordlists
cap抓包文件夹路径: /home/kali/Desktop/cap
```

旧版本路径从脚本顶部常量移到了配置文件，可删除 `~/.config/wifi-crack.conf` 恢复首次配置向导。

Old hardcoded paths moved to the config file; delete `~/.config/wifi-crack.conf` to re-run the setup wizard.

## 依赖 Dependencies

- aircrack-ng

```bash
sudo apt install aircrack-ng
```