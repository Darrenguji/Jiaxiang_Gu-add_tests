from flask import Flask, json

weather = {
  "coord": {
    "lon": -123.262,
    "lat": 44.5646
  },
  "weather": [
    {
      "id": 800,
      "main": "Clear",
      "description": "clear sky",
      "icon": "01n"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 288,
    "feels_like": 288.28,
    "temp_min": 287.18,
    "temp_max": 291.27,
    "pressure": 1019,
    "humidity": 73
  },
  "visibility": 10000,
  "wind": {
    "speed": 2.06,
    "deg": 200
  },
  "clouds": {
    "all": 0
  },
  "dt": 1665113574,
  "sys": {
    "type": 2,
    "id": 2005452,
    "country": "US",
    "sunrise": 1665065818,
    "sunset": 1665107101
  },
  "timezone": -25200,
  "id": 5720727,
  "name": "Corvallis",
  "cod": 200
}

api = Flask(__name__)

@api.route('/weather', methods=['GET'])
def get_companies():
  return json.dumps(weather)

if __name__ == '__main__':
    api.run()

