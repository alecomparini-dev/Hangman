//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class GetLastOpenHintsUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: GetLastOpenHintsUseCaseImpl!
    var getLastOpenHintsGateway: GetLastOpenHintsUseCaseGatewaySpy!
    
    override func setUp() {
        (self.sut, self.getLastOpenHintsGateway) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        getLastOpenHintsGateway = nil
    }
 
    func test_get_success() async {
        let expectedResult = [1,2]
        
        getLastOpenHintsGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.get(userID)
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_get_failure() async {
        getLastOpenHintsGateway.result = .failure(MockError.throwError)
        
        do {
            let result = try await sut.get(userID)
            XCTFail("Unexpected success: \(result)")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_get_correct_values() async {
        let expectedResult = userID
        
        do {
            _ = try await sut.get(userID)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        XCTAssertEqual(getLastOpenHintsGateway.userID, expectedResult)
    }
    
    
}


//  MARK: - EXTENSION SUT
extension GetLastOpenHintsUseCaseTests {
        
    func makeSut() -> (sut: GetLastOpenHintsUseCaseImpl, getLastOpenHintsGateway: GetLastOpenHintsUseCaseGatewaySpy) {
        let getLastOpenHintsGateway = GetLastOpenHintsUseCaseGatewaySpy()
        let sut = GetLastOpenHintsUseCaseImpl(getLastOpenHintsGateway: getLastOpenHintsGateway)
        return (sut, getLastOpenHintsGateway)
    }
        
}


