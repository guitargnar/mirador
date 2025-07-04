#!/bin/bash
# Archive outputs older than 7 days

ARCHIVE_DIR="outputs_archive_$(date +%Y%m%d)"
mkdir -p "$ARCHIVE_DIR"

echo "Archiving outputs older than 7 days..."
find outputs -type d -mtime +7 -maxdepth 1 | while read dir; do
    if [ "$dir" != "outputs" ]; then
        echo "Moving $dir to archive..."
        mv "$dir" "$ARCHIVE_DIR/"
    fi
done

echo "Compression archive..."
tar -czf "${ARCHIVE_DIR}.tar.gz" "$ARCHIVE_DIR" && rm -rf "$ARCHIVE_DIR"
echo "Archive created: ${ARCHIVE_DIR}.tar.gz"
