#!/bin/bash

calculate_md5() {
    md5sum "$1" | awk '{print $1}'
}

save_md5_checksums() {
    latest_checksum=$(calculate_md5 $1)
    local md5_file_path=$1.md5
    checksum_changed=0
    if [ ! -f "$md5_file_path" ]; then
        echo "$latest_checksum" > "$md5_file_path"
        checksum_changed=1
    else
        if ! grep -q "$latest_checksum" "$md5_file_path"; then
            echo "$latest_checksum" >> "$md5_file_path"
            checksum_changed=1
        fi
    fi
}

get_changed_ssm_document_files() {
    files_changed=()
    for file in $(find $1 -type f -not -name "*.md5"); do
        save_md5_checksums $file
        if [ "$checksum_changed" -eq 1 ]; then
            files_changed+=($file)
        fi
    done
}
