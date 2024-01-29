
import Foundation

import XCTest

extension HomePresenterTests {

//  MARK: - SETHINTSCOUNT
    
    func test_setHintsCount_set() {
        let sut = makeSut()
        let expectedHintsCount = 10
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: expectedHintsCount)))
        
        sut.setHintsCount(expectedHintsCount)
        let resultHintsCount = sut.gameHelpPresenterDTO?.hintsCount
        
        XCTAssertEqual(resultHintsCount, expectedHintsCount)
    }
        
    
}


