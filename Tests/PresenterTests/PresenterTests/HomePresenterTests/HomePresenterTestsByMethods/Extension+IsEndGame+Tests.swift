
import Foundation

import XCTest

extension HomePresenterTests {    
    
//  MARK: - ISENDGAME
    
    func test_isEndGame_true() {
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 0)))
        
        let result = sut.isEndGame
        
        XCTAssertTrue(result)
    }
    
    func test_isEndGame_false() {
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 5)))
        
        let result = sut.isEndGame
        
        XCTAssertFalse(result)
    }
    
}


