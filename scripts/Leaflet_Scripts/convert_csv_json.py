import pandas as pd
df = pd.read_csv ('../output/ShipDetections.csv')
df.to_json ('../output/geodata.json')

