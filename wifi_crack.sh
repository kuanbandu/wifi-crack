#!/bin/bash

CONFIG_FILE="$HOME/.config/wifi-crack.conf"

setup_dirs() {
    echo "=== 请配置目录 ==="
    while true; do
        read -p "密码库文件夹路径: " WORDLIST_DIR
        read -p "cap抓包文件夹路径: " CAP_DIR
        WORDLIST_DIR="${WORDLIST_DIR/#\~/$HOME}"
        CAP_DIR="${CAP_DIR/#\~/$HOME}"
        if [ -d "$WORDLIST_DIR" ] && [ -d "$CAP_DIR" ]; then
            break
        fi
        echo "目录不存在，请重新输入"
    done
    mkdir -p "$(dirname "$CONFIG_FILE")"
    printf 'WORDLIST_DIR="%s"\nCAP_DIR="%s"\n' "$WORDLIST_DIR" "$CAP_DIR" > "$CONFIG_FILE"
    echo "目录配置已保存到 $CONFIG_FILE"
}

if [ ! -f "$CONFIG_FILE" ]; then
    setup_dirs
else
    source "$CONFIG_FILE"
fi

CURRENT_FILES=()

list_files() {
    local dir=$1
    CURRENT_FILES=()
    local files=($(find "$dir" -maxdepth 3 -name "*.txt" -o -name "*.cap" 2>/dev/null | sort))
    
    if [ ${#files[@]} -eq 0 ]; then
        echo "未找到文件"
        return 1
    fi
    
    echo "=== 选择文件 ==="
    local count=0
    for i in "${!files[@]}"; do
        local f="${files[$i]}"
        local size=$(du -h "$f" 2>/dev/null | cut -f1)
        local dir_part=$(dirname "$f" | sed "s|$WORDLIST_DIR||;s|$CAP_DIR||")
        local name=$(basename "$f")
        if [[ "$name" == *.txt ]] && [[ "$FILTER8" == "y" ]]; then
            if ! grep -qE '^.{8,}$' "$f" 2>/dev/null; then
                continue
            fi
        fi
        count=$((count+1))
        CURRENT_FILES+=("$f")
        printf "%3d) [%5s] %s/%s\n" $count "$size" "$dir_part" "$name"
    done
    if [ $count -eq 0 ]; then
        echo "没有符合条件的文件"
    fi
}

get_file_by_index() {
    local idx=$1
    echo "${CURRENT_FILES[$((idx-1))]}"
}

while true; do
    echo ""
    echo "=== WiFi 密码破解工具 ==="
    echo "1) 选择字典文件"
    echo "2) 选择 cap 文件"
    echo "3) 执行破解"
    echo "4) 修改目录配置"
    echo "5) 退出"
    
    read -p "请选择: " opt
    
    case $opt in
        1)
            echo ""
            echo "是否只列出含8位以上密码的字典？(y/n)"
            read -r FILTER8
            echo ""
            list_files "$WORDLIST_DIR"
            echo ""
            read -p "输入编号: " choice
            if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 1 ]; then
                wordlist=$(get_file_by_index "$choice")
                [ -n "$wordlist" ] && echo "已选: $wordlist"
            fi
            ;;
        2)
            echo ""
            list_files "$CAP_DIR"
            echo ""
            read -p "输入编号: " choice
            if [[ $choice =~ ^[0-9]+$ ]] && [ $choice -ge 1 ]; then
                capfile=$(get_file_by_index "$choice")
                [ -n "$capfile" ] && echo "已选: $capfile"
            fi
            ;;
        3)
            if [ -z "$wordlist" ] || [ -z "$capfile" ]; then
                echo "请先选择字典和 cap 文件"
                continue
            fi
            echo ""
            echo "执行: aircrack-ng -w $wordlist $capfile"
            echo "(按 q 终止破解)"
            echo ""
            aircrack-ng -w "$wordlist" "$capfile" &
            pid=$!
            while true; do
                read -t 0.5 -n 1 -s key
                if [ "$key" = "q" ]; then
                    kill $pid 2>/dev/null
                    echo ""
                    echo "已终止破解"
                    break
                fi
                if ! kill -0 $pid 2>/dev/null; then
                    break
                fi
            done
            wait $pid 2>/dev/null
            ;;
        4)
            setup_dirs
            ;;
        5)
            exit 0
            ;;
        *)
            echo "无效选项"
            ;;
    esac
done
