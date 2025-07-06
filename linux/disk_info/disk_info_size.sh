#!/bin/sh

# disk_info_size.sh
# Author: @usrunsudo

# linux_hdd_space_info
DISK_SIZE_TOTAL=$(df -k . | tail -n1 | awk '{print $2}')
DISK_SIZE_USED=$(df -k . | tail -n1 | awk '{print $3}')
DISK_SIZE_FREE=$(df -k . | tail -n1 | awk '{print $4}')
DISK_PERCENT_USED=$(df -kh . | tail -n1 | awk '{print $5}')
DATETIME=$(date -uIseconds)

# variable=$(echo "OPTIONS; OPERATIONS" | bc)
GiB_DISK_SIZE_TOTAL=$(echo "scale=3; $DISK_SIZE_TOTAL / 1024 / 1024" | bc)
GiB_DISK_SIZE_USED=$(echo "scale=3; $DISK_SIZE_USED / 1024 / 1024" | bc)
GiB_DISK_SIZE_FREE=$(echo "scale=3; $DISK_SIZE_FREE / 1024 / 1024" | bc)

#echo "${GiB_DISK_SIZE_FREE} GiB available out of ${GiB_DISK_SIZE_TOTAL} GiB total ${GiB_DISK_SIZE_FREE} GiB (${DISK_PERCENT_USED}) used."
echo "DISK_SIZE_TOTAL = ${GiB_DISK_SIZE_TOTAL} GiB"
echo "DISK_SIZE_USED = ${GiB_DISK_SIZE_USED} GiB"
echo "DISK_SIZE_FREE = ${GiB_DISK_SIZE_FREE} GiB"
echo "DISK_PERCENT_USED = ${DISK_PERCENT_USED}"
