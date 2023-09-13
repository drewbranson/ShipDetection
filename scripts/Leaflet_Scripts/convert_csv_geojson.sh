# Basically just bloat after migrating to vector tiles but json-to-csv.pl will need to be modified without this

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
"CaspianSea") number="15";;
esac

node --max-old-space-size=4096 /usr/local/bin/csv2geojson ../output/ShipDetections_${AOI}.csv > ../output/geodata.geojson

sed -i '1 s/^.*$/var json_'${AOI}'_'${number}' = {/' ../output/geodata.geojson

# for geojson 
cp ../output/geodata.geojson ../../ShipDetection.github.io/points/data/${AOI}_${number}.js
# for tiles 
# cp ../output/geodata.geojson ../output/data/${AOI}_${number}.js

csv2geojson ../output/ShipDetections_${AOI}_live.csv > ../output/geodata.geojson

sed -i '1 s/^.*$/var json_'${AOI}'_'${number}' = {/' ../output/geodata.geojson

# for geojson 
cp ../output/geodata.geojson ../../ShipDetection.github.io/live/data/${AOI}_${number}_live.js