//
//  CountWordsPlayedUseCaseTests.swift
//  TestsDomain
//
//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class CountWordsPlayedUseCaseTests: XCTestCase {
    var userID = "123"
    
    var countWordsPlayedGateway: CountWordsPlayedUseCaseGatewaySpy!
    var sut: CountWordsPlayedUseCaseImpl!
    
    override func setUp() {
        self.countWordsPlayedGateway = CountWordsPlayedUseCaseGatewaySpy()
        self.sut = CountWordsPlayedUseCaseImpl(countWordsPlayedGateway: countWordsPlayedGateway)
    }
    
    override func tearDown() {
        sut = nil
        countWordsPlayedGateway = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_count_success() async {
        let expectedResult = 1
        
        countWordsPlayedGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.count(userID: userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_count_failure() async {
        countWordsPlayedGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.count(userID: userID)
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_count_correct_values() async {
        countWordsPlayedGateway.result = .success(1)
        
        do {
            _ = try await sut.count(userID: userID)
            
            XCTAssertEqual(countWordsPlayedGateway.userID, userID)
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    
}
