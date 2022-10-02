# cleaning script
# find /mnt/sdb1/Data/* -mtime +14 -exec rm {} \; #delete all data more than 2 weeks old

# find /mnt/36464FC4464F8419/Data/* -empty -type d -delete

find /mnt/sdb1/Products/* -name "*.img" -mtime +1 -type f -delete   #delete all image product files older than 2 weeks


