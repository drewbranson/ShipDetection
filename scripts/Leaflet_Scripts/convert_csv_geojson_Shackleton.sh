AOI="$1"

case $AOI in 
"Pacific2") number="1";;
"Pacific1") number="2";;
"SouthIndian") number="3";;
"NorthIndian") number="4";;
"ArabianSea") number="5";;
"BalticSea") number="6";;
"Caribbean") number="7";;
"SouthEastAsia") number="8";;
"SouthAtlantic") number="9";;
"NorthAtlantic") number="10";;
"NortheastAtlantic") number="11";;
"MediterraneanSeaWest") number="12";;
"MediterraneanSeaEast") number="13";;
"BlackSea") number="14";;
esac

csv2geojson ../output/ShipDetections_${AOI}.csv > ../output/geodata.geojson

sed -i '1 s/^.*$/var json_'${AOI}'_'${number}' = {/' ../output/geodata.geojson

cp ../output/geodata.geojson /run/user/1000/gvfs/smb-share:server=drew-thinkcentre-2.local,share=nansen/GitHub/ShipDetection.github.io/data/${AOI}_${number}.js