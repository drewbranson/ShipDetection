uri = "file:/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections.csv?encoding=%s&delimiter=%s&xField=%s&yField=%s&crs=%s" % ("UTF-8",",", "Detected_lon:Double", "Detected_lat:Double","epsg:4326")

# #Make a vector layer
ShipDetections=QgsVectorLayer(uri,"ShipDetections","delimitedtext")

#Check if layer is valid
if not ShipDetections.isValid():
    print ("Layer not loaded")

#Add CSV data    
QgsProject.instance().addMapLayer(ShipDetections)

# csv_layer=QgsVectorLayer(uri:string,layer name: string, library:string)