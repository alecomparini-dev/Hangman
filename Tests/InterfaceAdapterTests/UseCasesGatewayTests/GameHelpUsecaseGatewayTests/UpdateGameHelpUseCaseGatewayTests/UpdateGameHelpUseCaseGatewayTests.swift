//  Created by Alessandro Comparini on 23/01/24.
//

import XCTest
import Handler
import Domain
import UseCaseGateway

final class UpdateGameHelpUseCaseGatewayTests: XCTestCase {

    let userID = "123"
    var sut: UpdateGameHelpUseCaseGatewayImpl!
    var updateDataStorageSpy: UpdateDataStorageProviderSpy!
    
    override func setUp() {
        (self.sut, self.updateDataStorageSpy) = makeSut()
    }

    override func tearDown() {
        sut = nil
        updateDataStorageSpy = nil
    }
    
    
//  MARK: - TEST AREA
    
    func test_update_gameHelp_success() async {
        updateDataStorageSpy.updateResult = .success([:])
        
        var expectedResult = false
        
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            expectedResult = true
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
        XCTAssertTrue(expectedResult)
    }
    
    func test_update_gameHelp_failure() async {
        updateDataStorageSpy.updateResult = .failure(MockError.throwError)
        
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }

    func test_update_correct_values() async {
        let expectedValue = 5
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModel(typeGameHelp: TypeGameHelpModel(hints: expectedValue)))
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        let value = updateDataStorageSpy.value as! [String: Any]
        
        XCTAssertEqual(value["hints"] as! Int, expectedValue)
    }
    
    func test_update_correct_collection() async {
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(updateDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.game)")
    }

    func test_update_correct_documentID() async {
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        XCTAssertEqual(updateDataStorageSpy.documentID, K.Collections.Documents.help)
    }

}


//  MARK: - EXTENSION SUT
extension UpdateGameHelpUseCaseGatewayTests {
    
    func makeSut() -> (sut: UpdateGameHelpUseCaseGatewayImpl, updateDataStorageSpy: UpdateDataStorageProviderSpy) {
        let updateDataStorageSpy = UpdateDataStorageProviderSpy()
        let sut = UpdateGameHelpUseCaseGatewayImpl(updateDataStorage: updateDataStorageSpy)
        return (sut, updateDataStorageSpy)
    }
    
}


//  MARK: - InsertDataStorageProviderSpy

class UpdateDataStorageProviderSpy: UpdateDataStorageProvider {
    var collection: String!
    var documentID: String!
    var value: Any!
    
    var updateResult: Result<[String: Any]?, Error> = .success([:])
    
    func update<T>(_ collection: String, _ documentID: String, _ value: T) async throws {
        self.collection = collection
        self.documentID = documentID
        self.value = value
        
        switch updateResult {
            case .success(_):
                return
            case .failure(let error):
                throw error
        }
    }
    
    
    
}

