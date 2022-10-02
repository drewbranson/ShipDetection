### Runall_shpDetection.sh
## call with
# Runall_shpDetection.sh "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" BlackSea
# Runall_shpDetection_tmp.sh "/mnt/sdb1/Data/MediterraneanSea_East/toprocess" "/mnt/sdb1/Products/MediterraneanSea_East" MediterraneanSea_East

sourceDirectory="$1"
targetDirectory="$2"
AOI="$3"
# AOI=BlackSea_buffer200

cd /home/drew/Documents/GitHub/ShipDetection/scripts

# python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py ${sourceDirectory} /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/${AOI}.shp ${AOI}
# python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/BlackSea_buffer200.shp BlackSea_buffer200

# ./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" SHP
sed "s/\AOI/$AOI/g" ShipDetection.xml > ShipDetection_MED.xml
./processDataset.sh ShipDetection_MED.xml SHP_DET.propterties ${sourceDirectory} ${targetDirectory} SHP 

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py ${targetDirectory} ${AOI}
# # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/mnt/sdb1/Products/BlackSea_ShipDet" BlackSea_buffer200
# # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/mnt/sdb1/Products/MediterraneanSea_East" MediterraneanSea_East


./Leaflet_Scripts/convert_csv_geojson.sh ${AOI}
# ./Leaflet_Scripts/convert_csv_geojson.sh MediterraneanSea_East

./cleaning.sh

./../../gitpush_shpDet_web.sh
