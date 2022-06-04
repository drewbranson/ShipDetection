### Runall_shpDetection.sh

cd /home/drew/Documents/GitHub/ShipDetection/scripts

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py

./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/36464FC4464F8419/Data/Ukraine/BlackSea/toprocess" "/mnt/36464FC4464F8419/Products/BlackSea_ShipDet" SHP

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py

