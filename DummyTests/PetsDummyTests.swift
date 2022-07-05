//
//  DummyTests.swift
//  DummyTests
//
//  Created by Akshay Patil on 27/06/22.
//

import XCTest
@testable import PetsDummy

class PetsDummyTests: XCTestCase {

    static let workingHours = "M-F 09:00 - 18:00"
    static let inWorkTime : Date = {
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    static let outWorkTime : Date = {
        var components = DateComponents()
        components.hour = 20
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    static let configSettingMock = ConfigSettings(true, true, workingHours)
    
    class ConfigSettingsRepositoryMock: ConfigSettingsRepositoryProtocol {
        func fetchConfigSettings(completion: @escaping (Result<ConfigSettings, Error>) -> Void) {
            completion(.success(configSettingMock))
        }
    }
    
    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testInWorkHours() throws {
        let result = WorkHourUtil.isTimeInWorkHours(PetsDummyTests.workingHours, PetsDummyTests.inWorkTime)
        XCTAssertEqual(result, true, "Error in current time is in the work hour")
    }
    
    func testOutWorkHours() throws {
        let result = WorkHourUtil.isTimeInWorkHours(PetsDummyTests.workingHours, PetsDummyTests.outWorkTime)
        XCTAssertEqual(result, false, "Error in current time is out the work hour")
    }
    
    func testConfigSetting_whenFetchingConfigSetting() {
        let expectation = self.expectation(description: "Fetch Config Settings")
        expectation.expectedFulfillmentCount = 1
        var config : ConfigSettings?
        let moviesQueriesRepository = ConfigSettingsRepositoryMock()
        moviesQueriesRepository.fetchConfigSettings { result in
            switch result {
            case .success(let mConfig):
                config = mConfig
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Config setting failed reason: \(error.localizedDescription)")
            }
        }
        waitForExpectations(timeout: 0.1, handler: nil)
        XCTAssertNotNil(config)
    }
}
