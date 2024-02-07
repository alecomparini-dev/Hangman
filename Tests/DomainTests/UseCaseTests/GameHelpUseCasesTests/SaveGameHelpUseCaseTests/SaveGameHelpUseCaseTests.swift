//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation


import XCTest
import Handler
import Domain

final class SaveGameHelpUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: SaveGameHelpUseCaseImpl!
    var saveGameHelpGatewaySpy: SaveGameHelpUseCaseGatewaySpy!
    
    override func setUp() {
        self.saveGameHelpGatewaySpy = SaveGameHelpUseCaseGatewaySpy()
        self.sut = SaveGameHelpUseCaseImpl(saveGameHelpGateway: saveGameHelpGatewaySpy)
    }
    
    override func tearDown() {
        sut = nil
        saveGameHelpGatewaySpy = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_save_success() async {
        var expectedResult = false
        
        saveGameHelpGatewaySpy.result = .success(nil)
        
        do {
            _ = try await sut.save(userID, gameHelp: GameHelpModelFactory.make())
            expectedResult = true
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_save_failure() async {
        saveGameHelpGatewaySpy.result = .failure(MockError.throwError)
        
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
            
            XCTAssertEqual(saveGameHelpGatewaySpy.userID, userID)
            XCTAssertEqual(saveGameHelpGatewaySpy.gameHelp, GameHelpModelFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}
