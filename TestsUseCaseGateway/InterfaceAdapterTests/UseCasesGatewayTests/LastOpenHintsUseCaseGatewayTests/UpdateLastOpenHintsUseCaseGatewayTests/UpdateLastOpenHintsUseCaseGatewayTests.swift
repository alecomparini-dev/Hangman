//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class UpdateLastOpenHintsUseCaseGatewayTests: XCTestCase {
    
    let userID = "123"
    var sut: UpdateLastOpenHintsUseCaseGatewayImpl!
    var updateDataStorageSpy: UpdateDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.updateDataStorageSpy) = makeSut()
    }
    
    override func tearDown() {
        sut = nil
        updateDataStorageSpy = nil
    }
    
    
    //  MARK: - TESTE AREA
    func test_update_success() async {
        updateDataStorageSpy.updateResult = .success([:])
        
        var expectedResult = false
        
        do {
            _ = try await sut.update(userID, [1,2,3])
            expectedResult = true
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
        XCTAssertTrue(expectedResult)
    }
    
    func test_update_failure() async {
        updateDataStorageSpy.updateResult = .failure(MockError.throwError)
        do {
            _ = try await sut.update(userID, [1,2,3])
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_update_correct_values() async {
        let expectedValue = [1,2,3]
        do {
            _ = try await sut.update(userID, expectedValue)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        let value = updateDataStorageSpy.value as! [String: Any]
        
        XCTAssertEqual(value["indexes"] as! [Int], expectedValue)
    }
    
    func test_update_correct_collection() async {
        do {
            _ = try await sut.update(userID, [1,2,3])
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(updateDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.openHints)")
    }

    func test_update_correct_documentID() async {
        do {
            _ = try await sut.update(userID, [1,2,3])
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(updateDataStorageSpy.documentID, K.Collections.Documents.openHints)
    }
    
}


//  MARK: - EXTENSION SUT
extension UpdateLastOpenHintsUseCaseGatewayTests {
        
    func makeSut() -> (sut: UpdateLastOpenHintsUseCaseGatewayImpl, updateDataStorageSpy: UpdateDataStorageProviderSpy) {
        let updateDataStorageSpy = UpdateDataStorageProviderSpy()
        let sut = UpdateLastOpenHintsUseCaseGatewayImpl(updateDataStorage: updateDataStorageSpy)
        return (sut, updateDataStorageSpy)
    }
        
}
