## Extract Ship Detection CSVs 

import os
import pandas as pd
from datetime import date
import sys

ShipDetection = pd.DataFrame(columns=[ 'ShipDetections', 'geometry:Point', 'Detected_x:Integer', 'Detected_y:Integer', 'Detected_width:Double', 'Detected_length:Double', 'style_css:String', 'Date', 'Year', 'Month', 'Day', 'Time'])

# ShipDetection = pd.DataFrame(columns=[ 'ShipDetections', 'Point', 'Detected_x', 'Detected_y', 'Detected_width', 'Detected_length', 'style_css', 'Date', 'Time'])
enddate = (date.today())

# indir = '/mnt/sdb1/Products/BlackSea_ShipDet'
indir = sys.argv[1]

# outdir = '/media/drew/sbd1/Products/ShipDetection_shp'
print("extracting files from "+indir)
for root, dirs, files in os.walk(indir):
    for file in files:
        if file.endswith('ShipDetections.csv'):
            fullname = os.path.join(root, file).replace('\\', '/')
            filename = os.path.splitext(os.path.basename(fullname))[0]
            
            # get date from pathname
            datetime = fullname.split('_')[7]
            date1 = datetime.split('T')[0]
            year = date1[:4]
            month = date1[4:6]
            day = date1[6:8]
            
            year1 = int(year)
            month1 = int(month)
            day1 = int(day)
           
            date2 = date(year1, month1, day1)

            ddate = enddate - date2
            time = datetime.split('T')[1]

            df = pd.read_csv(fullname,sep='\t',skiprows=(1),header=(0))

            df['Date'] = date1
            df['Time'] = time 
            df['Year'] = year
            df['Month'] = month
            df['Day'] = day
            df['DaysOld'] = ddate.days

            if ddate.days > 100:
                # ddate = 100
                df['DaysOld'] = 100


           


            # ShipDetection = ShipDetection.append(df, ignore_index = True)
            ShipDetection = pd.concat([ShipDetection, df])

            # ShipDetection.to_csv('/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections_'+sys.argv[2]+'.csv')

            # raise ValueError('debug')

ShipDetection = ShipDetection.drop(['geometry:Point', 'Detected_x:Integer', 'Detected_y:Integer', 'style_css:String'], axis = 1)
ShipDetection = ShipDetection.rename(columns={'Detected_width:Double': 'Detected_width', 'Detected_length:Double': 'Detected_length', 'Detected_lat:Double': 'Latitude', 'Detected_lon:Double': 'Longitude'})
ShipDetection.index.name = 'field_1'
ShipDetection = ShipDetection.sort_values("Date")       #needs to be sorted to set drawing order in leaflet


ShipDetection.to_csv('/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections_'+sys.argv[2]+'.csv')