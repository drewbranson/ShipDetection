## Extract Ship Detection CSVs 

import os
import pandas as pd
from datetime import date

ShipDetection = pd.DataFrame(columns=[ 'ShipDetections', 'geometry:Point', 'Detected_x:Integer', 'Detected_y:Integer', 'Detected_width:Double', 'Detected_length:Double', 'style_css:String', 'Date', 'Year', 'Month', 'Day', 'Time'])

# ShipDetection = pd.DataFrame(columns=[ 'ShipDetections', 'Point', 'Detected_x', 'Detected_y', 'Detected_width', 'Detected_length', 'style_css', 'Date', 'Time'])


indir = '/mnt/36464FC4464F8419/Products/BlackSea_ShipDet'
# outdir = '/media/drew/36464FC4464F8419/Products/ShipDetection_shp'
print("extracting files from "+indir)
for root, dirs, files in os.walk(indir):
    for file in files:
        if file.endswith('ShipDetections.csv'):
            fullname = os.path.join(root, file).replace('\\', '/')
            filename = os.path.splitext(os.path.basename(fullname))[0]
            
            # get date from pathname
            datetime = fullname.split('_')[7]
            date = datetime.split('T')[0]
            year = date[:4]
            month = date[4:6]
            day = date[6:8]

            time = datetime.split('T')[1]

            df = pd.read_csv(fullname,sep='\t',skiprows=(1),header=(0))

            df['Date'] = date

            df['Time'] = time 
            df['Year'] = year
            df['Month'] = month
            df['Day'] = day


            # ShipDetection = ShipDetection.append(df, ignore_index = True)
            ShipDetection = pd.concat([ShipDetection, df])



            ShipDetection.to_csv('/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections.csv')

            # raise ValueError('debug')

ShipDetection = ShipDetection.drop(['geometry:Point', 'Detected_x:Integer', 'Detected_y:Integer', 'style_css:String'], axis = 1)
ShipDetection = ShipDetection.rename(columns={'Detected_width:Double': 'Detected_width', 'Detected_length:Double': 'Detected_length', 'Detected_lat:Double': 'Latitude', 'Detected_lon:Double': 'Longitude'})

ShipDetection.to_csv('/home/drew/Documents/GitHub/ShipDetection/output/ShipDetections.csv')