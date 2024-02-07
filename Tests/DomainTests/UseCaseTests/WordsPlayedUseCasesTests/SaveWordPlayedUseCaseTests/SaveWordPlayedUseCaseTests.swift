//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class SaveWordPlayedUseCaseTests: XCTestCase {
    var userID = "123"
    
    var saveWordPlayedGateway: SaveWordPlayedUseCaseGatewaySpy!
    var sut: SaveWordPlayedUseCaseImpl!
    
    override func setUp() {
        self.saveWordPlayedGateway = SaveWordPlayedUseCaseGatewaySpy()
        self.sut = SaveWordPlayedUseCaseImpl(saveWordPlayedGateway: saveWordPlayedGateway)
    }
    
    override func tearDown() {
        sut = nil
        saveWordPlayedGateway = nil
    }
    
    
    //  MARK: - TEST AREA
    
    func test_save_success() async {
        var expectedResult = false
        
        saveWordPlayedGateway.result = .success(nil)
        
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make())
            expectedResult = true
            
            XCTAssertTrue(expectedResult)
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func test_save_failure() async {
        saveWordPlayedGateway.result = .failure(MockError.throwError)
        
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make())
            
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertTrue(error is MockError)
        }
    }
    
    func test_save_correct_values() async {
        do {
            _ = try await sut.save(userID: userID, WordPlayedUseCaseDTOFactory.make())
            
            XCTAssertEqual(saveWordPlayedGateway.userID, userID)
            XCTAssertEqual(saveWordPlayedGateway.wordPlayed, WordPlayedUseCaseDTOFactory.make())
        } catch let error {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
}
