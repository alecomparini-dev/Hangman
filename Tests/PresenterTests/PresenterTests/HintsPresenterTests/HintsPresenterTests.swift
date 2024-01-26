//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class HintsPresenterTests: XCTestCase {
    
    var updateGameHelpUseCaseSpy: UpdateGameHelpUseCaseSpy!
    var saveLastOpenHintsUseCaseSpy: SaveLastOpenHintsUseCaseSpy!
    var dataTransferHintMock = DataTransferHintsFactory()
    var sut: HintsPresenterImpl!
    
    override func setUp() {
        self.updateGameHelpUseCaseSpy = UpdateGameHelpUseCaseSpy()
        self.saveLastOpenHintsUseCaseSpy = SaveLastOpenHintsUseCaseSpy()
        
    }
    
    override func tearDown() {
        sut = nil
        updateGameHelpUseCaseSpy = nil
        saveLastOpenHintsUseCaseSpy = nil
    }
 
    
//  MARK: - TEST AREA
    
    func test_getLastHintsOpen_with_values() async {
        let expectResult = [1,2,3]
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(lastHintsOpen: expectResult)
        
        makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        let result = sut.getLastHintsOpen()
        
        XCTAssertEqual(expectResult, result)
    }
    
    func test_getLastHintsOpen_withOut_values() async {
        let expectResult = [Int]()
        let dataTransferNil = DataTransferHintsFactory().make()
        
        makeSut(dataTransfer: dataTransferNil)
        
        let result = sut.getLastHintsOpen()
        
        XCTAssertEqual(expectResult, result)
    }
    
    
    
}


//  MARK: - EXTENSION MAKE SUT
extension HintsPresenterTests {
    func makeSut(dataTransfer: DataTransferHints? = nil) {
        self.sut = HintsPresenterImpl(updateGameHelpUseCase: updateGameHelpUseCaseSpy,
                                      saveLastOpenHintsUseCase: saveLastOpenHintsUseCaseSpy,
                                      dataTransfer: dataTransfer)
    }
}
