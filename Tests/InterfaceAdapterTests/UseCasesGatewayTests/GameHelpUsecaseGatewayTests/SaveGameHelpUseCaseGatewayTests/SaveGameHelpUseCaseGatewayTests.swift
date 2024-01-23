//  Created by Alessandro Comparini on 23/01/24.
//

import XCTest
import Handler
import Domain
import UseCaseGateway

final class SaveGameHelpUseCaseGatewayTests: XCTestCase {

    let userID = "123"
    var sut: SaveGameHelpUseCaseGatewayImpl!
    var insertDataStorageSpy: InsertDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.insertDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        insertDataStorageSpy = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_save_gameHelp_success() async {
        insertDataStorageSpy.insertResult = .success([:])
        
        var expectedResult = false
        
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
            expectedResult = true
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
        XCTAssertTrue(expectedResult)
    }
    
    func test_save_gameHelp_failure() async {
        insertDataStorageSpy.insertResult = .failure(MockError.throwError)
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_save_correct_values() async {
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        let value = insertDataStorageSpy.value as! [String: Any]
        XCTAssertEqual(value["dateRenewFree"] as! String, "2024-1-12")
        XCTAssertEqual(value["lives"] as! Int, 1)
        XCTAssertEqual(value["hints"] as! Int, 2)
        XCTAssertEqual(value["revelations"] as! Int, 3)
    }
    
    func test_save_correct_collection() async {
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(insertDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.game)")
    }

    func test_save_correct_documentID() async {
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(insertDataStorageSpy.documentID, K.Collections.Documents.help)
    }


}


//  MARK: - EXTENSION SUT
extension SaveGameHelpUseCaseGatewayTests {
    
    func makeSut() -> (sut: SaveGameHelpUseCaseGatewayImpl, insertDataStorageSpy: InsertDataStorageProviderSpy) {
        let insertDataStorageSpy = InsertDataStorageProviderSpy()
        let sut = SaveGameHelpUseCaseGatewayImpl(insertDataStorage: insertDataStorageSpy)
        return (sut, insertDataStorageSpy)
    }
    
}


//  MARK: - InsertDataStorageProviderSpy

class InsertDataStorageProviderSpy: InsertDataStorageProvider {
    var collection: String!
    var documentID: String!
    var value: Any!
    
    var insertResult: Result<[String: Any]?, Error> = .success([:])
    
    func insert<T>(_ collection: String, _ documentID: String, _ value: T) async throws -> T? {
        self.collection = collection
        self.documentID = documentID
        self.value = value
        
        switch insertResult {
            case .success(_):
                return nil
            case .failure(let error):
                throw error
        }
    }
    
    func insert<T>(_ value: T) async throws -> T? {
        return nil
    }
    
    func insert<T>(_ collection: String, _ value: T) async throws -> T? {
        return nil
    }
    
    
}

