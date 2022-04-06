##########Download data from ASF############
import asf_search as asf
import geopandas as gpd
from shapely.geometry import box
from datetime import date 
import fiona
import os
import pandas as pd


###########Inputs#################
download_path = '/mnt/36464FC4464F8419/Data/Ukraine/BlackSea/toprocess'
AOI_Path    = '/home/drew/Documents/GitHub/ShipDetection/inputs/AOI/BlackSea.kml'


# startdate   = date(2022, 3, 21)
data = pd.read_csv('startdate.txt', header=None)
startdate = str(data.values[0,0])
enddate = str(date.today())
# enddate = date(2022, 3, 23)

file = open("startdate.txt", "w")
file.write(enddate)
file.close

# os.mkdir(download_path)

## 1. Read Shapefile using Geopandas
gpd.io.file.fiona.drvsupport.supported_drivers['KML'] = 'rw'
gdf = gpd.read_file(AOI_Path, driver='KML')

### 2. Extract the Bounding Box Coordinates
bounds = gdf.total_bounds

### 3. Create GeoDataFrame of the Bounding Box 
gdf_bounds = gpd.GeoSeries([box(*bounds)])

### 4. Get WKT Coordinates
wkt_aoi = gdf_bounds.to_wkt().values.tolist()[0]

results = asf.search(
    platform= asf.PLATFORM.SENTINEL1A,
    processingLevel=[asf.PRODUCT_TYPE.GRD_HD],
    start = startdate,
    end = enddate,
    intersectsWith = wkt_aoi
    )

print(f'Total Images Found: {len(results)}')
### Save Metadata to a Dictionary
metadata = results.geojson()


session = asf.ASFSession().auth_with_creds('drew_branson.9', 'Razz4ever')


results.download(
     path = download_path,
     session = session, 
     processes = 2
  )
