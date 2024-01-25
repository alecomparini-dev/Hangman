//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class UpdateGameHelpUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: UpdateGameHelpUseCaseImpl!
    var updateGameGateway: UpdateGameHelpUseCaseGatewaySpy!
    
    override func setUp() {
        self.updateGameGateway = UpdateGameHelpUseCaseGatewaySpy()
        self.sut = UpdateGameHelpUseCaseImpl(updateGameGateway: updateGameGateway)
    }
    
    override func tearDown() {
        sut = nil
        updateGameGateway = nil
    }
    

//  MARK: - TEST AREA
    
    func test_update_success() async {
        var expectedResult = false
        
        updateGameGateway.result = .success(nil)
        
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            expectedResult = true
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
        
        XCTAssertTrue(expectedResult)
    }
    
    func test_update_failure() async {
        updateGameGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_update_correct_values() async {
        do {
            _ = try await sut.update(userID, gameHelp: GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }

        XCTAssertEqual(updateGameGateway.userID, userID)
        XCTAssertEqual(updateGameGateway.gameHelp, GameHelpModelFactory.make())
    }
    
}
