import Alamofire

public protocol WeatherService {
    func getTemperature() async throws -> Int
        
}

enum BaseUrl : String{
    case openweathermap = "https://api.openweathermap.org"
    case mockServer = "http:127.0.0.1:5000/weather"
    
}


class WeatherServiceImpl: WeatherService {
    //let url = "\(BaseUrl.openweathermap.rawValue)/data/2.5/weather?q=corvallis&units=imperial&appid=9f0cf3c31a6a02d7a07b5d82608d0420"
    let url = BaseUrl.mockServer.rawValue

    func getTemperature() async throws -> Int {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: Weather.self) { response in
                switch response.result {
                case let .success(weather):
                    let temperature = weather.main.temp
                    let temperatureAsInteger = Int(temperature)
                    continuation.resume(with: .success(temperatureAsInteger))

                case let .failure(error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
}

 struct Weather: Decodable {
    let main: Main

    struct Main: Decodable {
        let temp: Double
    }
}
