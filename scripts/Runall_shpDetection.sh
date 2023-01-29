### Runall_shpDetection.sh
## call with
# Runall_shpDetection.sh "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" BlackSea
# Runall_shpDetection.sh "/mnt/sdb1/Data/MediterraneanSea_East/toprocess" "/mnt/sdb1/Products/MediterraneanSea_East" MediterraneanSea_East
# Runall_shpDetection.sh "/home/drew/Documents/Data/BlackSea/toprocess" "/home/drew/Documents/Products/BlackSea" BlackSea

sourceDirectory="$1"
targetDirectory="$2"
AOI="$3"
tiles=$4
# AOI=BlackSea_buffer200

cd /home/drew/Documents/GitHub/ShipDetection/scripts

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py ${sourceDirectory} /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/${AOI} ${AOI}
# python3 /home/drew/Documents/GitHub/ShipDetection/scripts/asf_download.py "/mnt/sdb1/Data/Pacific1" /home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/Pacific1 Pacific1

# # ./processDataset.sh ShipDetection.xml SHP_DET.propterties "/mnt/sdb1/Data/Ukraine/BlackSea/toprocess" "/mnt/sdb1/Products/BlackSea_ShipDet" SHP
sed "s/\AOI/$AOI/g" ShipDetection.xml > ShipDetection_tmp.xml
./processDataset.sh ShipDetection_tmp.xml SHP_DET.propterties ${sourceDirectory} ${targetDirectory} SHP 

python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py ${targetDirectory} ${AOI}
# # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/home/drew/Documents/Products/BlackSea" BlackSea
# # python3 /home/drew/Documents/GitHub/ShipDetection/scripts/extract_results.py "/mnt/sdb1/Products/Mediterranean_East" Mediterranean_East

./Leaflet_Scripts/convert_csv_geojson.sh ${AOI}

./cleaning.sh

if [ ${tiles} -eq 1 ]
then
    cd ./../../ShipDetection.github.io/
    python json-to-csv.py 
    cd /home/drew/Documents/GitHub/ShipDetection/scripts
fi

./../../gitpush_shpDet_web.sh


