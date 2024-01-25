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
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
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
            
            let value = updateDataStorageSpy.value as! [String: Any]
            XCTAssertEqual(value["hints"] as! Int, expectedValue)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_update_correct_collection() async {
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            
            XCTAssertEqual(updateDataStorageSpy.collection, "\(K.Collections.users)/\(userID)/\(K.Collections.game)")
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_update_correct_documentID() async {
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            
            XCTAssertEqual(updateDataStorageSpy.documentID, K.Collections.Documents.help)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
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



