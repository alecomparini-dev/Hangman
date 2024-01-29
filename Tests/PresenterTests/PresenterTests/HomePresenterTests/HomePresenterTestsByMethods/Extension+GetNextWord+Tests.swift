
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
    //  MARK: - GETNEXTWORD
    
    func test_getNextWord_with_nextWords_empty() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let homePresenterOutputMock = HomePresenterOutputSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        sut.delegateOutput = homePresenterOutputMock
        
        let expectedFetchGameHelpSuccess = GameHelpPresenterDTOFactory.make()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
            gameHelpPresenterDTO: expectedFetchGameHelpSuccess
        ))
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .success([])
        
        let exp = expectation(description: "waiting")
        homePresenterOutputMock.observer { receivedOutput in
            if let receivedFetchGameHelpSuccess = receivedOutput as? GameHelpPresenterDTO {
                XCTAssertEqual(receivedFetchGameHelpSuccess, expectedFetchGameHelpSuccess)
                XCTAssertTrue(homePresenterOutputMock.isMainThread)
            }
            
            if let receivedFetchNextWordSuccess = receivedOutput as? WordPresenterDTO {
                XCTAssertEqual(receivedFetchNextWordSuccess, sut.getCurrentWord())
                XCTAssertTrue(homePresenterOutputMock.isMainThread)
                exp.fulfill()
            }
        }
        
        DispatchQueue.global().async {
            sut.getNextWord()
        }
        
        wait(for: [exp], timeout: 1)
        
    }
    
    
    func test_getNextWord_with_nextWords() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let homePresenterOutputMock = HomePresenterOutputSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        sut.delegateOutput = homePresenterOutputMock
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
            wordPlaying: NextWordsUseCaseDTOFactory.make(),
            nextWords: [NextWordsUseCaseDTOFactory.make(),NextWordsUseCaseDTOFactory.make(id: 2)],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make()
        ))
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .success([])
        
        let exp = expectation(description: "waiting")
        homePresenterOutputMock.observer { receivedOutput in
            if let receivedFetchNextWordSuccess = receivedOutput as? WordPresenterDTO {
                XCTAssertEqual(receivedFetchNextWordSuccess, sut.getCurrentWord())
                XCTAssertTrue(homePresenterOutputMock.isMainThread)
                exp.fulfill()
            }
        }
        
        DispatchQueue.global().async {
            sut.getNextWord()
        }
        
        wait(for: [exp], timeout: 1)
        
    }
    
    func test_getNextWord_nexWordIsOver() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let homePresenterOutputMock = HomePresenterOutputSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        sut.delegateOutput = homePresenterOutputMock
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
            wordPlaying: NextWordsUseCaseDTOFactory.make(),
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make()
        ))
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .success([])
        getNextWordsUseCaseSpy.setResult = .success([])
        
        let expGetNextWordsUseCaseSpy = expectation(description: "expGetNextWordsUseCaseSpy")
        getNextWordsUseCaseSpy.observer { receivedResult in
            XCTAssertTrue((receivedResult as! [NextWordsUseCaseDTO]).isEmpty)
            expGetNextWordsUseCaseSpy.fulfill()
        }
        
        let exp = expectation(description: "homePresenterOutputMock")
        homePresenterOutputMock.observer { receivedOutput in
            if let receivedOutput = receivedOutput as? [String] {
                XCTAssertEqual(receivedOutput[0], "Aviso")
                XCTAssertEqual(receivedOutput[1], "Banco de palavras chegou ao fim.\nEstamos trabalhando para incluir novas palavras. Muito obrigado pela compreensão")
                XCTAssertTrue(homePresenterOutputMock.isMainThread)
                exp.fulfill()
            }
        }
        
        DispatchQueue.global().async {
            sut.getNextWord()
        }
        
        wait(for: [exp,expGetNextWordsUseCaseSpy], timeout: 1)
        
    }
    
    
    
}


