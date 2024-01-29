
import Foundation

import XCTest

extension HomePresenterTests {
    
    
//  MARK: - SETLASTHINTSOPEN
    
    func test_setLastHintsOpen_set() {
        let sut = makeSut()
        let expectedLastHints = [1,2,3]
        
        sut.setLastHintsOpen(expectedLastHints)
        
        let lastHintsOpen = sut.lastHintsOpen
        
        XCTAssertEqual(lastHintsOpen, expectedLastHints)
    }
    
    func test_lastHintsOpen_empty() {
        let sut = makeSut()
        let expectedLastHints = [Int]()
        
        let lastHintsOpen = sut.lastHintsOpen
        
        XCTAssertEqual(lastHintsOpen, expectedLastHints)
    }
    
}


