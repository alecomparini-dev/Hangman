//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class CountDollsUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: CountDollsUseCaseImpl!
    var countModelGateway: GenericCountModelGatewaySpy!
    
    override func setUp() {
        self.countModelGateway = GenericCountModelGatewaySpy()
        self.sut = CountDollsUseCaseImpl(countModelGateway: countModelGateway)
    }
    
    override func tearDown() {
        sut = nil
        countModelGateway = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_count_success() async {
        let expectedResult = 1
        
        countModelGateway.result = .success(expectedResult)
        
        do {
            let result = try await sut.count()
            XCTAssertEqual(result, expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_count_failure() async {
        countModelGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.count()
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_count_correct_collection() async {
        countModelGateway.result = .success(1)
        
        do {
            _ = try await sut.count()
        } catch let error {
            XCTAssertNotNil(error)
        }
        
        XCTAssertEqual(countModelGateway.model, K.Collections.dolls)
    }
    
    
}
