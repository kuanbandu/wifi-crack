# wifi-crack

Interactive wrapper for `aircrack-ng`. Pick a wordlist and a capture file from a menu, run the crack, abort anytime with `q`.

[简体中文说明](README.zh-CN.md)

## Features

- Menu-driven wordlist selection, optionally showing only lists that contain 8+ char passwords
- Pick capture (.cap) file from a directory
- Abort a running crack anytime by pressing `q`
- Loop back to the menu after each run; no restart needed

## Usage

```bash
./wifi_crack.sh
```

Menu:

1. Select wordlist (asks whether to filter to lists with 8+ char passwords)
2. Select capture file
3. Run crack (press `q` to abort)
4. Reconfigure directories
5. Exit

## First run

On first run you'll be asked to enter the wordlist directory and the capture directory. They are saved to `~/.config/wifi-crack.conf` and auto-loaded on later starts. Use menu `4` to reconfigure anytime.

Example:

```bash
=== Configure directories ===
Wordlist directory: /home/kali/Desktop/wordlists
Cap capture directory: /home/kali/Desktop/cap
```

Delete `~/.config/wifi-crack.conf` to re-run the setup wizard.

## Dependencies

- aircrack-ng

```bash
sudo apt install aircrack-ng
```