#!/bin/bash

folder_path="./imgs/svgNfts/"  # 替换为你的文件夹路径
file_extension=".svg"  # 文件后缀名

count=1

# 遍历文件夹中的文件
for file in "$folder_path"/*"$file_extension"; do
  # 检查文件是否存在
  if [ -e "$file" ]; then
    # 构造新的文件名
    new_name="$folder_path/$count$file_extension"
    # 使用 mv 命令进行重命名
    mv "$file" "$new_name"
    echo "已将文件 $file 重命名为 $new_name"
    count=$((count + 1))
  fi
done