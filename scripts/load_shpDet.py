uri = "file:/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections_Pacific2.csv?encoding=%s&delimiter=%s&xField=%s&yField=%s&crs=%s" % ("UTF-8",",", "Longitude", "Latitude","epsg:4326")

# #Make a vector layer
ShipDetections=QgsVectorLayer(uri,"Pacific2","delimitedtext")

#Check if layer is valid
if not ShipDetections.isValid():
    print ("Layer not loaded")

#Add CSV data    
QgsProject.instance().addMapLayer(ShipDetections)

# csv_layer=QgsVectorLayer(uri:string,layer name: string, library:string)
