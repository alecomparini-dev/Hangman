
import Foundation

import XCTest
import Domain

extension HomePresenterTests {

//  MARK: - MAXHELP
    func test_maxHelp_lives() {
        test_maxHelp(5, .lives)
    }
    
    func test_maxHelp_hints() {
        test_maxHelp(10, .hints)
    }
    
    func test_maxHelp_revelations() {
        test_maxHelp(5, .revelations)
    }
    
    private func test_maxHelp(_ expectedMax: Int, _ typeGameHelp: TypeGameHelp, file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        XCTAssertEqual(sut.maxHelp(typeGameHelp), expectedMax, file: file, line: line)
    }
}


