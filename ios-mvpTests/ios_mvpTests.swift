//
//  ios_mvpTests.swift
//  ios-mvpTests
//
//  Created by Ahsan Ali on 19/09/2020.
//  Copyright © 2020 Ahsan Ali. All rights reserved.
//

import XCTest
@testable import ios_mvp

// Mock Coordinator
// Test Cities
class CitiesMockCoordinator: CitiesCoordinator {
    fileprivate let citiesArray: [City]
    
    init(cities: [City]) {
        self.citiesArray = cities
    }
    
    override func fetchData(cities: ([City]) -> Void) {
        cities(citiesArray)
    }
}

class CitiesMockView : NSObject, CitiesViewDelegate{
    var isDataFetched = false
    func fetchingData() {
        
    }
    
    func dataFetched() {
        isDataFetched = true
    }
    
    func handleError(error: Error) {
        
    }
}

class MapCityTests: XCTestCase {

    let citiesMockCoordinator = CitiesMockCoordinator(cities: [City(id: 1, name: "Lahore", longitude: 74.343611, latitude: 31.549722)])
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEitherCitiesDataFetched() throws {
        // SetUp
        let citiesMockView = CitiesMockView()
        let citiesPresenterTesting = CitiesPresenter(citiesCoordinator: citiesMockCoordinator)
        citiesPresenterTesting.setDelegae(delegate: citiesMockView)
        
        // When
        citiesPresenterTesting.fetchCities()
        
        // Verify Results
        XCTAssertTrue(citiesMockView.isDataFetched)
    }
}
