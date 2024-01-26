//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class DeleteLastOpenHintsUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: DeleteLastOpenHintsUseCaseImpl!
    var updateLastOpenHintsGateway: UpdateLastOpenHintsUseCaseGatewaySpy!
    
    override func setUp() {
        (self.sut, self.updateLastOpenHintsGateway) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        updateLastOpenHintsGateway = nil
    }
    
    func test_save_success() async {
        var expectedResult = false
        
        updateLastOpenHintsGateway.result = .success(true)
        
        do {
            _ = try await sut.delete(userID)
            expectedResult = true
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
    func test_save_failure() async {
        updateLastOpenHintsGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.delete(userID)
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_get_correct_values() async {
        do {
            _ = try await sut.delete(userID)
            
            XCTAssertEqual(updateLastOpenHintsGateway.userID, userID)
            XCTAssertEqual(updateLastOpenHintsGateway.indexes, [])
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
}

//  MARK: - EXTENSION SUT
extension DeleteLastOpenHintsUseCaseTests {
        
    func makeSut() -> (sut: DeleteLastOpenHintsUseCaseImpl, updateLastOpenHintsGateway: UpdateLastOpenHintsUseCaseGatewaySpy) {
        let updateLastOpenHintsGateway = UpdateLastOpenHintsUseCaseGatewaySpy()
        let sut = DeleteLastOpenHintsUseCaseImpl(updateLastOpenHintsGateway: updateLastOpenHintsGateway)
        return (sut, updateLastOpenHintsGateway)
    }
        
}

