# cleaning script
find /home/drew/Documents/Data/* -mtime +3 -exec rm {} \; #delete all data more than 3 days old

# find /mnt/36464FC4464F8419/Data/* -empty -type d -delete

find /home/drew/Documents/Products/* -name "*.img" -mtime +3 -type f -delete   #delete all image product files older than 2 weeks


