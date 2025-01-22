files=(
    /data/app/*/*/lib/arm64/libpangleflipped.so
    /data/app/*/*/lib/arm64/libzeus_direct_dex.so
    /data/app/*/*/lib/arm64/libmetasec_ml.so
)

# 循环遍历文件列表并删除每个文件或文件夹
for file in "${files[@]}"; do
    # 检查文件或文件夹是否存在
    if [ -e "$file" ]; then
        # 删除文件或文件夹
        rm -rf "$file" > /dev/null 2>&1
    fi
done