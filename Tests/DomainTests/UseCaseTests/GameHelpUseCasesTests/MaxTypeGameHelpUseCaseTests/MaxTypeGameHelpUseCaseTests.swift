//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation

import XCTest
import Handler
import Domain

final class MaxGameHelpUseCaseTests: XCTestCase {
    var userID = "123"
    var sut: MaxGameHelpUseCaseImpl!
    
    override func setUp() {
        self.sut = MaxGameHelpUseCaseImpl()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    
//  MARK: - TEST AREA
    func test_max_hints_success() async {
        let expectedResult = 10
        
        let result = sut.max(typeGameHelp: .hints)
        
        XCTAssertEqual(result, expectedResult)
    }

    func test_max_lives_success() async {
        let expectedResult = 5
        
        let result = sut.max(typeGameHelp: .lives)
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_max_revelations_success() async {
        let expectedResult = 5
        
        let result = sut.max(typeGameHelp: .revelations)
        
        XCTAssertEqual(result, expectedResult)
    }
}
