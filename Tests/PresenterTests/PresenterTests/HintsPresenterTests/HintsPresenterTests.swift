//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class HintsPresenterTests: XCTestCase {
    
    
//  MARK: - GETLASTHINTSOPEN
    func test_getLastHintsOpen_with_values() async {
        let expectResult = [1,2,3]
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(lastHintsOpen: expectResult)
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        let result = test.sut.getLastHintsOpen()
        
        XCTAssertEqual(expectResult, result)
    }
    
    func test_getLastHintsOpen_without_values() async {
        let expectResult = [Int]()
        let dataTransferNil = DataTransferHintsFactory().make()
        
        let test = makeSut(dataTransfer: dataTransferNil)
        
        let result = test.sut.getLastHintsOpen()
        
        XCTAssertEqual(expectResult, result)
    }
    
    
//  MARK: - NUMBEROFITEMSCALLBACK
    func test_numberOfItemsCallback_with_values() async {
        let expectResult = 3
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make( wordPresenterDTO:
            WordPresenterDTOFactory.make(hints: ["any_hint1","any_hint2","any_hint3"] ))
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        let result = test.sut.numberOfItemsCallback()
        
        XCTAssertEqual(expectResult, result)
    }
    
    func test_numberOfItemsCallback_without_values() async {
        let expectResult = 0
        let dataTransferNil = DataTransferHintsFactory().make()
        
        let test = makeSut(dataTransfer: dataTransferNil)
        
        let result = test.sut.numberOfItemsCallback()
        
        XCTAssertEqual(expectResult, result)
    }
    
    
//  MARK: - GETHINTBYINDEX
    func test_getHintByIndex_with_values() {
        let expectResult = "any_hint2"
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make( wordPresenterDTO:
            WordPresenterDTOFactory.make(hints: ["any_hint1","any_hint2","any_hint3"] ))
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        let result = test.sut.getHintByIndex(1)
        
        XCTAssertEqual(expectResult, result)
    }
    
    func test_getHintByIndex_without_values() {
        let expectResult = ""
        let dataTransferNil = DataTransferHintsFactory().make()
        
        let test = makeSut(dataTransfer: dataTransferNil)
        
        let result = test.sut.getHintByIndex(1)
        
        XCTAssertEqual(expectResult, result)
    }
    
    
//  MARK: - VERIFYHINTISOVER
    func test_verifyHintIsOver_hintsCount_nil() {
        var called = (hintIsOver: false, revealHintsCompleted: false, saveLastHintsOpen: false)
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        hintsPresenterOutputMock.completionHintsIsOver {
            called.hintIsOver = true
        }
        hintsPresenterOutputMock.completionRevealHintsCompleted({ _ in
            called.revealHintsCompleted = true
        })
        hintsPresenterOutputMock.completionSaveLastHintsOpen { _ in
            called.saveLastHintsOpen = true
        }
        
        test.sut.verifyHintIsOver()
        
        XCTAssertFalse(called.hintIsOver)
        XCTAssertFalse(called.revealHintsCompleted)
        XCTAssertFalse(called.saveLastHintsOpen)
    }
    
    func test_verifyHintIsOver_is_not_over() {
        var called = (hintIsOver: false, revealHintsCompleted: false, saveLastHintsOpen: false)
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 5),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        hintsPresenterOutputMock.completionHintsIsOver {
            called.hintIsOver = true
        }
        hintsPresenterOutputMock.completionRevealHintsCompleted({ _ in
            called.revealHintsCompleted = true
        })
        hintsPresenterOutputMock.completionSaveLastHintsOpen { _ in
            called.saveLastHintsOpen = true
        }
        
        test.sut.verifyHintIsOver()
        
        XCTAssertFalse(called.hintIsOver)
        XCTAssertFalse(called.revealHintsCompleted)
        XCTAssertFalse(called.saveLastHintsOpen)
    }
    
    func test_verifyHintIsOver_is_over() {
        var hintIsOverCalled = false
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 0),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
        hintsPresenterOutputMock.completionHintsIsOver {
            hintIsOverCalled = true
        }
        
        test.sut.verifyHintIsOver()
        
        XCTAssertTrue(hintIsOverCalled)
        XCTAssertTrue(hintsPresenterOutputMock.isMainThread)
        
    }
    
    
//  MARK: - OPENHINT
    func test_openHint_hints_nil_saveLastHints_not_be_called() {
        var saveLastHintsOpenCalled = false
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransfer = DataTransferHintsFactory().make(delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransfer)
        
        hintsPresenterOutputMock.completionHintsIsOver {
            saveLastHintsOpenCalled = true
        }
        
        test.sut.openHint(indexHint: 1)
        
        XCTAssertFalse(saveLastHintsOpenCalled)
        
    }

    
    func test_openHint_zero_hints_hintsIsOver_must_be_called()  {
        var saveLastHintsOpenCalled = false
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransfer = DataTransferHintsFactory().make(
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 0),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransfer)
        
        hintsPresenterOutputMock.completionHintsIsOver {
            saveLastHintsOpenCalled = true
        }
        
        test.sut.openHint(indexHint: 1)
        
        XCTAssertTrue(saveLastHintsOpenCalled)

    }
    
    func test_openHint_saveLastOpenHints_lastHintsOpen_empty() {
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransfer = DataTransferHintsFactory().make(
            lastHintsOpen: [],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 5),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransfer)
        
        let expectedIndexes = [1]
        let exp = expectation(description: "waiting")
        hintsPresenterOutputMock.completionSaveLastHintsOpen({ receivedIndexes in
            XCTAssertEqual(expectedIndexes, receivedIndexes)
            XCTAssertTrue(hintsPresenterOutputMock.isMainThread)
            exp.fulfill()
        })

        test.sut.openHint(indexHint: 1)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_openHint_saveLastOpenHints_lastHintsOpen_isNotEmpy() {
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransfer = DataTransferHintsFactory().make(
            lastHintsOpen: [1,4],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 5),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransfer)
        
        let exp = expectation(description: "waiting")
        
        let expectedIndexes = [1,4,3]
        hintsPresenterOutputMock.completionSaveLastHintsOpen { receivedIndexes in
            XCTAssertEqual(expectedIndexes, receivedIndexes)
            XCTAssertTrue(hintsPresenterOutputMock.isMainThread)
            exp.fulfill()
        }

        test.sut.openHint(indexHint: 3)
        
        wait(for: [exp], timeout: 1)
        
    }
    
    func test_openHint_updateGameHelp_correct_values()  {
        let hintsPresenterOutputMock = HintsPresenterOutputMock()
        let dataTransfer = DataTransferHintsFactory().make(
            lastHintsOpen: [1,4],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: 4),
            delegate: hintsPresenterOutputMock)
        
        let test = makeSut(dataTransfer: dataTransfer)
        
        let exp = expectation(description: "waiting")
        
        let expectedCount = 3
        hintsPresenterOutputMock.completionRevealHintsCompleted { receivedCount in
            XCTAssertEqual(expectedCount, receivedCount)
            XCTAssertEqual(test.updateGameHelpUseCaseSpy.gameHelp, GameHelpModelFactory.make(dateRenewFree: nil, lives: nil, hints: receivedCount, revelations: nil))
            exp.fulfill()
        }

        test.sut.openHint(indexHint: 2)
        
        wait(for: [exp], timeout: 1)
        
    }
    
    
}


//  MARK: - EXTENSION MAKE SUT
extension HintsPresenterTests {
    func makeSut(dataTransfer: DataTransferHints? = nil) -> (sut: HintsPresenterImpl,
                                                             updateGameHelpUseCaseSpy: UpdateGameHelpUseCaseSpy,
                                                             saveLastOpenHintsUseCaseSpy: SaveLastOpenHintsUseCaseSpy) {
        
        let updateGameHelpUseCaseSpy = UpdateGameHelpUseCaseSpy()
        let saveLastOpenHintsUseCaseSpy = SaveLastOpenHintsUseCaseSpy()
        
        let sut = HintsPresenterImpl(updateGameHelpUseCase: updateGameHelpUseCaseSpy,
                                     saveLastOpenHintsUseCase: saveLastOpenHintsUseCaseSpy,
                                     dataTransfer: dataTransfer)
        
        return (sut, updateGameHelpUseCaseSpy, saveLastOpenHintsUseCaseSpy)
    }
}


