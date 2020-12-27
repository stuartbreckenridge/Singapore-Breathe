# NEA APIs

There are two APIs that are required: Polluntant Standards Index (PSI) and PM2.5. No authentication is needed.

## Polluntant Standards Index

Request: `GET https://api.data.gov.sg/v1/environment/psi`

Response:

```json
{
  "region_metadata": [
    {
      "name": "west",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.7
      }
    },
    {
      "name": "national",
      "label_location": {
        "latitude": 0,
        "longitude": 0
      }
    },
    {
      "name": "east",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.94
      }
    },
    {
      "name": "central",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.82
      }
    },
    {
      "name": "south",
      "label_location": {
        "latitude": 1.29587,
        "longitude": 103.82
      }
    },
    {
      "name": "north",
      "label_location": {
        "latitude": 1.41803,
        "longitude": 103.82
      }
    }
  ],
  "items": [
    {
      "timestamp": "2020-12-15T08:00:00+08:00",
      "update_timestamp": "2020-12-15T08:08:53+08:00",
      "readings": {
        "o3_sub_index": {
          "west": 4,
          "national": 4,
          "east": 2,
          "central": 2,
          "south": 3,
          "north": 4
        },
        "pm10_twenty_four_hourly": {
          "west": 20,
          "national": 25,
          "east": 25,
          "central": 21,
          "south": 24,
          "north": 19
        },
        "pm10_sub_index": {
          "west": 20,
          "national": 25,
          "east": 25,
          "central": 21,
          "south": 24,
          "north": 19
        },
        "co_sub_index": {
          "west": 5,
          "national": 5,
          "east": 5,
          "central": 4,
          "south": 4,
          "north": 4
        },
        "pm25_twenty_four_hourly": {
          "west": 6,
          "national": 13,
          "east": 13,
          "central": 7,
          "south": 9,
          "north": 8
        },
        "so2_sub_index": {
          "west": 3,
          "national": 3,
          "east": 2,
          "central": 2,
          "south": 2,
          "north": 2
        },
        "co_eight_hour_max": {
          "west": 0.48,
          "national": 0.54,
          "east": 0.54,
          "central": 0.43,
          "south": 0.44,
          "north": 0.42
        },
        "no2_one_hour_max": {
          "west": 8,
          "national": 32,
          "east": 32,
          "central": 24,
          "south": 24,
          "north": 21
        },
        "so2_twenty_four_hourly": {
          "west": 4,
          "national": 4,
          "east": 3,
          "central": 3,
          "south": 3,
          "north": 3
        },
        "pm25_sub_index": {
          "west": 26,
          "national": 52,
          "east": 52,
          "central": 31,
          "south": 38,
          "north": 34
        },
        "psi_twenty_four_hourly": {
          "west": 26,
          "national": 26,
          "east": 52,
          "central": 31,
          "south": 38,
          "north": 34
        },
        "o3_eight_hour_max": {
          "west": 9,
          "national": 9,
          "east": 4,
          "central": 4,
          "south": 7,
          "north": 9
        }
      }
    }
  ],
  "api_info": {
    "status": "healthy"
  }
}
```

## PM2.5 

Request `GET https://api.data.gov.sg/v1/environment/pm25`

Response

```json
{
  "region_metadata": [
    {
      "name": "west",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.7
      }
    },
    {
      "name": "east",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.94
      }
    },
    {
      "name": "central",
      "label_location": {
        "latitude": 1.35735,
        "longitude": 103.82
      }
    },
    {
      "name": "south",
      "label_location": {
        "latitude": 1.29587,
        "longitude": 103.82
      }
    },
    {
      "name": "north",
      "label_location": {
        "latitude": 1.41803,
        "longitude": 103.82
      }
    }
  ],
  "items": [
    {
      "timestamp": "2020-12-15T08:00:00+08:00",
      "update_timestamp": "2020-12-15T08:08:53+08:00",
      "readings": {
        "pm25_one_hourly": {
          "west": 5,
          "east": 25,
          "central": 6,
          "south": 14,
          "north": 7
        }
      }
    }
  ],
  "api_info": {
    "status": "healthy"
  }
}
```

