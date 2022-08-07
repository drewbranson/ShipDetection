csv2geojson ../output/ShipDetections.csv > ../output/geodata.geojson

sed -i '1 s/^.*$/var json_ShipDetections_1 = {/' ../output/geodata.geojson

cp ../output/geodata.geojson ../../ShipDetection.github.io/data/ShipDetections_1.js