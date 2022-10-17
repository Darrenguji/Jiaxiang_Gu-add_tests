import XCTest
@testable import MyLibrary


final class MyLibraryTests: XCTestCase {
    func testIsLuckyBecauseWeAlreadyHaveLuckyNumber() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)
        
        // When
        let isLuckyNumber = await myLibrary.isLucky(8)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    //let weatherservice = MyLibrary(weatherService:WeatherServiceImpl)

    
    
    func testIsLuckyBecauseWeatherHasAnEight() async throws {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: true
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(0)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == true)
    }

    func testIsNotLucky() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: true,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNotNil(isLuckyNumber)
        XCTAssert(isLuckyNumber == false)
    }

    func testIsNotLuckyBecauseServiceCallFails() async {
        // Given
        let mockWeatherService = MockWeatherService(
            shouldSucceed: false,
            shouldReturnTemperatureWithAnEight: false
        )

        let myLibrary = MyLibrary(weatherService: mockWeatherService)

        // When
        let isLuckyNumber = await myLibrary.isLucky(7)

        // Then
        XCTAssertNil(isLuckyNumber)
        
    }

    func testWeather(){
        
        let jsonString = """
{
        "main" : {
    
    "temp" : 65.0

    }

}
"""
        let jasonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let testData = try! decoder.decode (Weather.self, from: jasonData)
        
        
        XCTAssert(testData.main.temp == 65.0)
    }
    
}

final class MyIntegrationTest: XCTestCase{

    func testWeather() async throws{

        //Given
        let myService  = WeatherServiceImpl()

        //when
        let temp = try await myService.getTemperature()

        //Then


       // XCTAssertEqual(temp,62)
        XCTAssertEqual(temp,288)

    }



} 
