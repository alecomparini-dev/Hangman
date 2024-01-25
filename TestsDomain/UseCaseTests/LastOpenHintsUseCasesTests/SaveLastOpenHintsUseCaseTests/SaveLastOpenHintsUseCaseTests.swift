//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class SaveLastOpenHintsUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: SaveLastOpenHintsUseCaseImpl!
    var saveLastOpenHintsGatewaySpy: SaveLastOpenHintsUseCaseGatewaySpy!
    
    override func setUp() {
        (self.sut, self.saveLastOpenHintsGatewaySpy) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        saveLastOpenHintsGatewaySpy = nil
    }
    
    func test_save_success() async {
        var expectedResult = false
        
        saveLastOpenHintsGatewaySpy.result = .success(true)
        
        do {
            _ = try await sut.save(userID, [1,2,3])
            expectedResult = true
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    
    func test_save_failure() async {
        saveLastOpenHintsGatewaySpy.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.save(userID, [1,2,3])
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_get_correct_values() async {
        do {
            _ = try await sut.save(userID, [1,2,3])
            
            XCTAssertEqual(saveLastOpenHintsGatewaySpy.userID, userID)
            XCTAssertEqual(saveLastOpenHintsGatewaySpy.indexes, [1,2,3])
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}

//  MARK: - EXTENSION SUT
extension SaveLastOpenHintsUseCaseTests {
        
    func makeSut() -> (sut: SaveLastOpenHintsUseCaseImpl, saveLastOpenHintsGatewaySpy: SaveLastOpenHintsUseCaseGatewaySpy) {
        let saveLastOpenHintsGatewaySpy = SaveLastOpenHintsUseCaseGatewaySpy()
        let sut = SaveLastOpenHintsUseCaseImpl(saveLastOpenHintsUseCaseGateway: saveLastOpenHintsGatewaySpy)
        return (sut, saveLastOpenHintsGatewaySpy)
    }
        
}
