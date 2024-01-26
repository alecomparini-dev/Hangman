//
//  HintsPresenterTests.swift
//  Handler
//
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
        
        self.sut = HintsPresenterImpl(updateGameHelpUseCase: updateGameHelpUseCaseSpy,
                                      saveLastOpenHintsUseCase: saveLastOpenHintsUseCaseSpy,
                                      dataTransfer: nil)
    }
    
    override func tearDown() {
        sut = nil
        updateGameHelpUseCaseSpy = nil
        saveLastOpenHintsUseCaseSpy = nil
    }
 
    
//  MARK: - TEST AREA
    
    
    
}




struct DataTransferHintsFactory {
    
    func make(userID: String? = "123", lastHintsOpen: [Int]?,
              wordPresenterDTO: WordPresenterDTO? = WordPresenterDTOFactory.make(),
              gameHelpPresenterDTO: GameHelpPresenterDTO? = GameHelpPresenterDTOFactory.make(),
              delegate: HintsPresenterOutput? = nil) -> DataTransferHints? {
        
        return DataTransferHints(userID: userID,
                                 lastHintsOpen: lastHintsOpen,
                                 wordPresenterDTO: wordPresenterDTO,
                                 gameHelpPresenterDTO: gameHelpPresenterDTO,
                                 delegate: delegate)
    }
    
}




