### Runall_shpDetection.sh

cd /home/drew/Documents/GitHub/ShipDetection/scripts

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py

./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" SHP

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py

./Leaflet_Scripts/convert_csv_geojson.sh 

./cleaning.sh

./../../gitpush_shpDet_web.sh