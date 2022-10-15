### Runall_shpDetection.sh
## call with
# Runall_shpDetection.sh "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" BlackSea
# Runall_shpDetection.sh "/home/drew/Documents/Data/MediterraneanSea_East/toprocess" "/home/drew/Documents/Products/MediterraneanSea_East" MediterraneanSea_East
# Runall_shpDetection.sh "/home/drew/Documents/Data/BlackSea/toprocess" "/home/drew/Documents/Products/BlackSea" BlackSea

sourceDirectory="$1"
targetDirectory="$2"
AOI="$3"
# AOI=BlackSea_buffer200

cd /home/drew/Documents/GitHub/ShipDetection/scripts

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py ${sourceDirectory} /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/${AOI}.shp ${AOI}
# python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/BlackSea.shp BlackSea

# ./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" SHP
sed "s/\AOI/$AOI/g" ShipDetection.xml > ShipDetection_tmp.xml
./processDataset.sh ShipDetection_tmp.xml SHP_DET.propterties ${sourceDirectory} ${targetDirectory} SHP 

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py ${targetDirectory} ${AOI}
# # # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/mnt/sdb1/Products/BlackSea_ShipDet" BlackSea
# # # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/mnt/sdb1/Products/Mediterranean_East" Mediterranean_East

./Leaflet_Scripts/convert_csv_geojson.sh ${AOI}

./cleaning.sh

./../../gitpush_shpDet_web.sh
