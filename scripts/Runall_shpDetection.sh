### Runall_shpDetection.sh
## call with
# Runall_shpDetection.sh "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" "/home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/BlackSea_buffer200.shp"

sourceDirectory="$1"
targetDirectory="$2"
AOI="$3"

cd /home/drew/Documents/GitHub/ShipDetection/scripts

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py ${sourceDirectory} ${AOI}

# ./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" SHP
# sed "s/\$AOI/$AOI/" ShipDetection.xml
./processDataset.sh ShipDetection.xml SHP_DET.propterties ${sourceDirectory} ${targetDirectory} SHP 

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py 

./Leaflet_Scripts/convert_csv_geojson.sh 

./cleaning.sh

./../../gitpush_shpDet_web.sh
