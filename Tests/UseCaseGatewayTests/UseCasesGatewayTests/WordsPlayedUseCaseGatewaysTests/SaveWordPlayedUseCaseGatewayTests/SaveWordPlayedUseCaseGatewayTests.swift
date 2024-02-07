//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import UseCaseGateway

final class SaveWordPlayedUseCaseGatewayTests: XCTestCase {
    
    let userID = "123"
    var sut: SaveWordPlayedUseCaseGatewayImpl!
    var insertDataStorageSpy: InsertDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.insertDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        insertDataStorageSpy = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_save_success() async {
        insertDataStorageSpy.insertResult = .success([:])
        
        var expectedResult = false
        
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make() )
            expectedResult = true
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_save_failure() async {
        insertDataStorageSpy.insertResult = .failure(MockError.throwError)
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make() )
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_save_correct_values() async {
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make() )
            
            let expectedValue = WordPlayedUseCaseDTOFactory.toJSON()
            let value = insertDataStorageSpy.value as! [String: Any]
            XCTAssertEqual(value["id"] as! Int, expectedValue["id"] as! Int)
            XCTAssertEqual(value["success"] as? Bool, expectedValue["success"] as? Bool)
            XCTAssertEqual(value["correctLettersCount"] as? Int, expectedValue["correctLettersCount"] as? Int)
            XCTAssertEqual(value["wrongLettersCount"] as? Int, expectedValue["wrongLettersCount"] as? Int)
            XCTAssertEqual(value["timeConclusion"] as? Int, expectedValue["timeConclusion"] as? Int)
            XCTAssertEqual(value["level"] as? Int, expectedValue["level"] as? Int)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}

//  MARK: - EXTENSION SUT
extension SaveWordPlayedUseCaseGatewayTests {
        
    func makeSut() -> (sut: SaveWordPlayedUseCaseGatewayImpl, insertDataStorageSpy: InsertDataStorageProviderSpy) {
        let insertDataStorageSpy = InsertDataStorageProviderSpy()
        let sut = SaveWordPlayedUseCaseGatewayImpl(insertDataStorage: insertDataStorageSpy)
        return (sut, insertDataStorageSpy)
    }
    
        
}

