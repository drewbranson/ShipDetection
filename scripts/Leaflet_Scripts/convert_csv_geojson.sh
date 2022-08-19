AOI="$1"

csv2geojson ../output/ShipDetections_${AOI}.csv > ../output/geodata.geojson

sed -i '1 s/^.*$/var json_ShipDetections_'${AOI}'_1 = {/' ../output/geodata.geojson

cp ../output/geodata.geojson ../../ShipDetection.github.io/data/ShipDetections_${AOI}_1.js