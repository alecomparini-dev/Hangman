
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
    
//  MARK: - STARTGAME - signInAnonymously
    
    func test_startGame_signInAnonymously_and_fetchRandomDolls_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        let expectedUser = "123"
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success(expectedUser)
        
        let exp = expectation(description: "waiting")
        signInAnonymousUseCaseMock.observer { receivedUser in
            guard let receivedUser = receivedUser as? String else { return }
            XCTAssertEqual(receivedUser, expectedUser)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
        
    }
    
    func test_startGame_signInAnonymously_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        signInAnonymousUseCaseMock.observer { receivedUser in
            XCTAssertTrue(receivedUser is MockError)
            exp.fulfill()
        }
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }

    
//  MARK: - STARTGAME - fetchRandomDolls
    
    func test_startGame_fetchRandomDolls_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        signInAnonymousUseCaseMock.setResult = .success("123")
        getDollsRandomUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        getDollsRandomUseCaseSpy.observer { dolls in
            XCTAssertTrue(dolls is MockError)
            exp.fulfill()
        }
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    
    
//  MARK: - STARTGAME - fetchNextWord
    
    func test_startGame_fetchNextWord_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        
        let expectedResult = [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make()]
        getNextWordsUseCaseSpy.setResult = .success(expectedResult)
        
        let exp = expectation(description: "waiting")
        getNextWordsUseCaseSpy.observer { receivedResult in
            XCTAssertEqual(expectedResult, receivedResult as! [NextWordsUseCaseDTO])
            XCTAssertEqual(getNextWordsUseCaseSpy.atID, 1)
            XCTAssertEqual(getNextWordsUseCaseSpy.limit, K.quantityWordsToFetch)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_startGame_fetchNextWord_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        getNextWordsUseCaseSpy.observer { receivedResult in
            XCTAssertTrue(receivedResult is MockError)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    
    
//  MARK: - STARTGAME - fetchGameHelp
    
    func test_startGame_fetchGameHelp_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        
        let expectedResult = FetchGameHelpUseCaseDTOFactory.make()
        fetchGameHelpUseCaseSpy.setResult = .success(expectedResult)
        
        let exp = expectation(description: "waiting")
        fetchGameHelpUseCaseSpy.observer { receivedResult in
            XCTAssertEqual(expectedResult, receivedResult as! FetchGameHelpUseCaseDTO)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_startGame_fetchGameHelp_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        
        fetchGameHelpUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        fetchGameHelpUseCaseSpy.observer { receivedResult in
            XCTAssertTrue(receivedResult is MockError)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    
    
//  MARK: - STARTGAME - fetchLastHintsOpen
    
    func test_startGame_fetchLastHintsOpen_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        let expectedResult = [1]
        getLastOpenHintsUseCaseSpy.setResult = .success(expectedResult)
        
        let exp = expectation(description: "waiting")
        getLastOpenHintsUseCaseSpy.observer { receivedResult in
            XCTAssertEqual(expectedResult, receivedResult as! [Int])
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_startGame_fetchLastHintsOpen_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        getLastOpenHintsUseCaseSpy.observer { receivedResult in
            XCTAssertTrue(receivedResult is MockError)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    
}


