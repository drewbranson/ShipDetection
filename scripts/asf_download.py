##########Download data from ASF############
import asf_search as asf
import geopandas as gpd
from shapely.geometry import box
from datetime import date 
import os
import pandas as pd
import fiona
import sys
import os
from datetime import date, timedelta

###########Inputs#################
download_path = sys.argv[1]
# print(download_path)
# download_path = '/mnt/sdb1/Data/Ukraine/BlackSea/toprocess'

# AOI_Path    = '/home/drew/Documents/GitHub/ShipDetection/inputs/SeaMask/BlackSea_asf.shp'
AOI_Path = sys.argv[2]+"_asf.shp"

# Read startdate from the file
start_date_file_path = "startdate_" + sys.argv[3] + ".txt"
if os.path.exists(start_date_file_path) and os.stat(start_date_file_path).st_size > 0:
    data = pd.read_csv(start_date_file_path, header=None)
    startdate = str(data.values[0, 0])
else:
    # If the file is empty, set the date to the previous day
    previous_day = date.today() - timedelta(days=1)
    startdate = str(previous_day)
print(startdate)
# Update or create the startdate file
with open(start_date_file_path, "w") as file:
    file.write(str(date.today()))
# # startdate   = date(2022, 3, 21)
# data = pd.read_csv('startdate_'+sys.argv[3]+'.txt', header=None)
# # startdate = str(date(2023, 2, 22))
# startdate = str(data.values[0,0])

# enddate = str(date.today())
# # enddate = str(date(2023, 3, 6))

# file = open("startdate_"+sys.argv[3]+".txt", "w")             #uncomment block for production
# file.write(enddate)
# file.close()

gdf = gpd.read_file(AOI_Path, driver='shp')
# print(gdf)
# ### 2. Extract the Bounding Box Coordinates
# bounds = gdf.total_bounds
# print(bounds)

# ### 3. Create GeoDataFrame of the Bounding Box 
# gdf_bounds = gpd.GeoSeries([box(*bounds)])
# print(gdf_bounds)

# ### 4. Get WKT Coordinates
wkt_aoi = gdf.to_wkt().values.tolist()[0]
# print(wkt_aoi)

results = asf.search(
    platform= asf.PLATFORM.SENTINEL1A,
    processingLevel=[asf.PRODUCT_TYPE.GRD_HD],
    start = startdate,
    end = date.today(),
    intersectsWith = wkt_aoi[1]
    )

print(f'Total Images Found: {len(results)}')
### Save Metadata to a Dictionary
metadata = results.geojson()


session = asf.ASFSession().auth_with_creds('Username', 'Password')


results.download(
     path = download_path,
     session = session, 
     processes = 2
  )
