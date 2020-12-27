#  Air Quality Measurements

## PSI
- Polluntant Standards Index. Composed of PM<sub>10</sub>, PM<sub>2.5</sub>, O<sub>3</sub>, CO, NO<sub>2</sub>, and SO<sub>2</sub>.
  - A sub-index is calculated for each pollutant in each region and the highest value is used as the PSI value for the region (e.g. _central_).
- In the API: `psi_twenty_four_hourly`

## PM<sub>10</sub> 
- Inhalable Particulate Matter that is generally 10 micrometers and smaller.
- In the API: `pm10_sub_index` and `pm10_twenty_four_hourly`.

## PM<sub>2.5</sub>
- Inhalable fine Particulate Matter that is generally 2.5 micrometers and smaller.
- In the API: `pm25_sub_index`, `pm25_twenty_four_hourly`, and `pm25_one_hourly` (from the PM2.5 API.)

## O<sub>3</sub>
- Ozone. 
- In the API: `o3_sub_index` and `o3_eight_hour_max`

## CO
- Carbon Monoxide.
- In the API:  `co_sub_index` and  `co_eight_hour_max`

## NO<sub>2</sub>
- Nitrogen Dioxide.
- In the API: `no2_one_hour_max` 

## SO<sub>2</sub>
- Sulphur Dioxide.
- In the API: `so2_sub_index` and `so2_twenty_four_hourly`

## PSI Bands

Use the 24-hour PSI rating for next day activities.

- Good (0 - 50)
- Moderate (51 - 100)
- Unhealthy (101 - 200)
- Very Unhealthy (201 - 300)
- Hazardous (>= 301)

## PM2.5 Bands

Use the 1-hour PM2.5 rating for immediate activities.

- Band 1 (NORMAL) - 0-55
- Band 2 (ELEVATED) - 56 - 150
- Band 3 (HIGH) - 151 - 250
- Band 4 (VERY HIGH) - >= 251


#### References 

[Polluntant Standards Index in Singapore](https://en.wikipedia.org/wiki/Pollutant_Standards_Index)
