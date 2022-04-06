## Extract Ship Detection CSVs 

import os
import pandas as pd

ShipDetection = pd.DataFrame(columns=[ 'ShipDetections', 'geometry:Point', 'Detected_x:Integer', 'Detected_y:Integer', 'Detected_width:Double', 'Detected_length:Double', 'style_css:String', 'Date', 'Time'])

indir = '/media/drew/36464FC4464F8419/Products/Vancouver'
outdir = '/media/drew/36464FC4464F8419/Products/ShipDetection_shp'

for root, dirs, files in os.walk(indir):
    for file in files:
        if file.endswith('ShipDetections.csv'):
            fullname = os.path.join(root, file).replace('\\', '/')
            filename = os.path.splitext(os.path.basename(fullname))[0]
            
            # get date from pathname
            datetime = fullname.split('_')[6]
            date = datetime.split('T')[0]
            time = datetime.split('T')[1]

            df = pd.read_csv(fullname,sep='\t',skiprows=(1),header=(0))

            df['Date'] = date 
            df['Time'] = time 
            
            # ShipDetection = ShipDetection.append(df, ignore_index = True)
            ShipDetection = pd.concat([ShipDetection, df])



            ShipDetection.to_csv('/home/drew/Documents/GitHub/ShipDetection/output/van_ShipDetections.csv')

            # raise ValueError('debug')


