//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class SaveLastOpenHintsUseCaseGatewayTests: XCTestCase {
    
    let userID = "123"
    var sut: SaveLastOpenHintsUseCaseGatewayImpl!
    var insertDataStorageSpy: InsertDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.insertDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        insertDataStorageSpy = nil
    }
    
    
    //  MARK: - TESTE AREA
    func test_save_success() async {
        insertDataStorageSpy.insertResult = .success([:])
        
        var expectedResult = false
        
        do {
            _ = try await sut.save(userID, [1,2,3])
            expectedResult = true
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_save_failure() async {
        insertDataStorageSpy.insertResult = .failure(MockError.throwError)
        do {
            _ = try await sut.save(userID, [1,2,3])
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    
    func test_save_correct_values() async {
        let expectedValues = [1,2,3]
        do {
            _ = try await sut.save(userID, expectedValues)
            let value = insertDataStorageSpy.value as! [String: Any]
            XCTAssertEqual(value["indexes"] as! [Int], expectedValues)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

    }
    
    
    func test_save_helpDocument_success() async {
        insertDataStorageSpy.insertResult = .success([:])
        
        do {
            _ = try await sut.save(userID, [1,2,3])
            XCTAssertEqual(insertDataStorageSpy.documentID, K.Collections.Documents.openHints)
        } catch let error {
            XCTAssertNotNil(error)
        }
    }
    
    func test_save_collection_success() async {
        insertDataStorageSpy.insertResult = .failure(MockError.throwError)
        
        do {
            _ = try await sut.save(userID, [1,2,3])
            XCTAssertEqual(insertDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.openHints)")
        } catch let error {
            XCTAssertNotNil(error)
        }
        
        
    }
    
}


//  MARK: - EXTENSION SUT
extension SaveLastOpenHintsUseCaseGatewayTests {
        
    func makeSut() -> (sut: SaveLastOpenHintsUseCaseGatewayImpl, insertDataStorageSpy: InsertDataStorageProviderSpy) {
        let insertDataStorageSpy = InsertDataStorageProviderSpy()
        let sut = SaveLastOpenHintsUseCaseGatewayImpl(insertDataStorage: insertDataStorageSpy)
        return (sut, insertDataStorageSpy)
    }
        
}
