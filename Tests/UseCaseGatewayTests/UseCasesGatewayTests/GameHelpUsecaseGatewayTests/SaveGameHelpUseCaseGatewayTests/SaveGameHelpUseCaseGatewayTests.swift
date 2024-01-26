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
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
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
            
            let value = insertDataStorageSpy.value as! [String: Any]
            let expected = GameHelpModelFactory.toJSON()
            XCTAssertEqual(value["dateRenewFree"] as! String, expected["dateRenewFree"] as! String)
            XCTAssertEqual(value["lives"] as! Int, expected["lives"] as! Int)
            XCTAssertEqual(value["hints"] as! Int, expected["hints"] as! Int)
            XCTAssertEqual(value["revelations"] as! Int, expected["revelations"] as! Int)
            
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_save_correct_collection() async {
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
            
            XCTAssertEqual(insertDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.game)")
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_save_correct_documentID() async {
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
            
            XCTAssertEqual(insertDataStorageSpy.documentID, K.Collections.Documents.help)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
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



