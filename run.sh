#!/bin/bash -e

source helper.sh

get_changed_ssm_document_files <dir_path_to_check>

# Echos the list with modified file names
for item in "${files_changed[@]}"; do
    echo "$item" # Change this according to your requirements
done
