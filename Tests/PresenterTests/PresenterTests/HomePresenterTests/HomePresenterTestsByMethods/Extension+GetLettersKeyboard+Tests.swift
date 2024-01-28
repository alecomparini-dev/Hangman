
import Foundation

import XCTest

extension HomePresenterTests {

//  MARK: - GETLETTERSKEYBOARD
    
    func test_getLettersKeyboard() {
        let sut = makeSut()
        let expectedLastHints = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P", "Q","R","S","T","U","V","W","X","Y","Z",""]
        
        XCTAssertEqual(sut.getLettersKeyboard(), expectedLastHints)
    }
            
}


