## Import data into QGIS
import requests
from qgis.utils import iface
from qgis.core import *
from qgis.gui import (
    QgsLayerTreeMapCanvasBridge,
)

# Supply path to qgis install location
QgsApplication.setPrefixPath("/usr", True)

# Create a reference to the QgsApplication.  Setting the
# second argument to False disables the GUI.
qgs = QgsApplication([], False)

# Load providers
qgs.initQgis()

# Write your code here to load some layers, use processing
# algorithms, etc.


# Get the project instance
project = QgsProject.instance()
# Print the current project file name (might be empty in case no projects have been loaded)
# print(project.fileName())

# bridge = QgsLayerTreeMapCanvasBridge( \
#          QgsProject.instance().layerTreeRoot(), canvas)
# Now you can safely load your project and see it in the canvas
# Load another project
project.read('../output/ShipDetections.qgs')
print(project.fileName())

## Clear Previous Data
qinst = QgsProject.instance()
qinst.removeMapLayer(qinst.mapLayersByName('ShipDetections')[0].id())

### import CSV to QGIS
uri = "file:/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections.csv?encoding=%s&delimiter=%s&xField=%s&yField=%s&crs=%s" % ("UTF-8",",", "Longitude", "Latitude","epsg:4326")
## Make a vector layer
ShipDetections=QgsVectorLayer(uri,"ShipDetections","delimitedtext")

#Check if layer is valid
if not ShipDetections.isValid():
    print ("Layer not loaded")

#Add CSV data    
QgsProject.instance().addMapLayer(ShipDetections)


# Add symbology
# layer = iface.activeLayer()


# # Add background map
# service_url = "mt1.google.com/vt/lyrs=s&x={x}&y={y}&z={z}" 
# service_uri = "type=xyz&zmin=0&zmax=21&url=https://"+requests.utils.quote(service_url)
# tms_layer = iface.addRasterLayer(service_uri, "Google Sat", "wms")
# #lyrs=y - hybrid
# #lyrs=s - sat
#lyrs=m - road map

# Save the project to the same
project.write('../output/ShipDetections.qgs')


# Finally, exitQgis() is called to remove the
# provider and layer registries from memory
qgs.exitQgis()


