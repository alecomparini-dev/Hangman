
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
    //  MARK: - VERIFYMATCHINWORD
    
    func test_verifyMatchInWord_isNotEndGame() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputMock()
        
        let expectedLetter = "A"
        
        startGame(sut, getLastOpenHintsUseCaseSpy) { [weak self] in
            guard let self else { return }
            
            let expRevealCorrectLetters = expectation(description: "revealCorrectLetters")
            let expMarkChosenKeyboardLetter = expectation(description: "markChosenKeyboardLetter")
            let expUpdateCountCorrectLetters = expectation(description: "updateCountCorrectLetters")
            
            homePresenterOutputMock.observer { receivedOutput in
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let revealCorrectOutput = receivedOutput["revealCorrectLetters"] as? [Int] {
                    XCTAssertEqual(revealCorrectOutput, [0])
                    expRevealCorrectLetters.fulfill()
                }
                
                if let markChosenOutput = receivedOutput["markChosenKeyboardLetter"] as? [Any] {
                    XCTAssertEqual(markChosenOutput[0] as! Bool, true)
                    XCTAssertEqual(markChosenOutput[1] as! String, expectedLetter)
                    expMarkChosenKeyboardLetter.fulfill()
                }
                
                if let updateCountCorrectOutput = receivedOutput["updateCountCorrectLetters"] as? String {
                    XCTAssertEqual(updateCountCorrectOutput, "1/\(sut.getCurrentWord()!.word!.count)")
                    expUpdateCountCorrectLetters.fulfill()
                }
            }
            
            sut.delegateOutput = homePresenterOutputMock
            setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
            ))
            
            sut.verifyMatchInWord(expectedLetter)
            
            wait(for: [expRevealCorrectLetters, expMarkChosenKeyboardLetter,expUpdateCountCorrectLetters], timeout: 1)
        }
        
    }
    
    //  MARK: - verifyMatchInWord_letter_error
    func test_verifyMatchInWord_one_letter_error() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputMock()
        
        let expectedLetter = "X"
        
        startGame(sut,getLastOpenHintsUseCaseSpy) { [weak self] in
            
            homePresenterOutputMock.observer { receivedOutput in
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let revealHeadDoll = receivedOutput["revealHeadDoll"] as? String {
                    XCTAssertNotNil(revealHeadDoll )
                }
                
                if let markChosenOutput = receivedOutput["markChosenKeyboardLetter"] as? [Any] {
                    XCTAssertEqual(markChosenOutput[0] as! Bool, false)
                    XCTAssertEqual(markChosenOutput[1] as! String, expectedLetter)
                }
                                
            }
            
            sut.delegateOutput = homePresenterOutputMock
            self?.setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
            ))
            
            sut.verifyMatchInWord(expectedLetter)

        }
        
    }
    
    
//  MARK: - test_verifyMatchInWord_two_or_more_letter_error
    
    func test_verifyMatchInWord_two_or_more_letter_error() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputMock()
        
        
        let expectedLetter = "X"
        startGame(sut,getLastOpenHintsUseCaseSpy, completion: ({ [weak self] in
            
            homePresenterOutputMock.observer { receivedOutput in
                
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let markChosenOutput = receivedOutput["markChosenKeyboardLetter"] as? [Any] {
                    XCTAssertEqual(markChosenOutput[0] as! Bool, false)
                    XCTAssertEqual(markChosenOutput[1] as! String, expectedLetter)
                }
                
                if let revealBodyDoll = receivedOutput["revealBodyDoll"] as? String {
                    XCTAssertNotNil(revealBodyDoll)
                }
                
            }
            
            sut.verifyMatchInWord("Z")
            sut.verifyMatchInWord("B")
            
            sut.delegateOutput = homePresenterOutputMock
            self?.setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
            ))
            
            sut.verifyMatchInWord(expectedLetter)

        }), calledOutputTest: {
            XCTAssertTrue(homePresenterOutputMock.called.markChosenKeyboardLetter)
            XCTAssertTrue(homePresenterOutputMock.called.revealBodyDoll)
        })
        
    }
    
    

//  MARK: - test_verifyMatchInWord_endGame_failure
    
    func test_verifyMatchInWord_endGame_failure() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputMock()
        
        let expectedLetter = "X"
        startGame(sut,getLastOpenHintsUseCaseSpy, completion: ({ [weak self] in
            guard let self else {return}
            
            homePresenterOutputMock.observer { receivedOutput in
                
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let markChosenOutput = receivedOutput["markChosenKeyboardLetter"] as? [Any] {
                    XCTAssertEqual(markChosenOutput[0] as! Bool, false)
                    XCTAssertEqual(markChosenOutput[1] as! String, expectedLetter)
                }
                
                if let updateLivesCount = receivedOutput["updateLivesCount"] as? String {
                    XCTAssertEqual(updateLivesCount, "9")
                    XCTAssertEqual(sut.gameHelpPresenterDTO?.livesCount.description, "9")
                }
                
                if let revealDollEndGameFailure = receivedOutput["revealDollEndGameFailure"] as? String {
                    XCTAssertNotNil(revealDollEndGameFailure)
                }
                
            }

            sut.verifyMatchInWord("Z")
            sut.verifyMatchInWord("B")
            sut.verifyMatchInWord("L")
            sut.verifyMatchInWord("T")
            sut.verifyMatchInWord("M")
            
            sut.delegateOutput = homePresenterOutputMock
            self.setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
            ))
            sut.verifyMatchInWord(expectedLetter)
                        
        }), calledOutputTest: {
            XCTAssertTrue(homePresenterOutputMock.called.markChosenKeyboardLetter)
            XCTAssertTrue(homePresenterOutputMock.called.updateLivesCount)
            XCTAssertTrue(homePresenterOutputMock.called.updateLivesCount)
            XCTAssertTrue(homePresenterOutputMock.called.revealDollEndGameFailure)
            XCTAssertFalse(homePresenterOutputMock.called.revealBodyDoll)
            XCTAssertFalse(homePresenterOutputMock.called.revealDollEndGameSuccess)
        })
                
    }


//  MARK: - test_verifyMatchInWord_endGame_success
    
    func test_verifyMatchInWord_endGame_success() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputMock()
        
        let expectedLetter = "D"
        
        startGame(sut,getLastOpenHintsUseCaseSpy, completion: ({ [weak self] in
            guard let self else {return}
            
            homePresenterOutputMock.observer { receivedOutput in
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let markChosenOutput = receivedOutput["markChosenKeyboardLetter"] as? [Any] {
                    XCTAssertEqual(markChosenOutput[0] as! Bool, true)
                    XCTAssertEqual(markChosenOutput[1] as! String, expectedLetter)
                }
                
                if let revealDollEndGameSuccess = receivedOutput["revealDollEndGameSuccess"] as? String {
                    XCTAssertNotNil(revealDollEndGameSuccess)
                }
                
            }
            
            sut.setLastHintsOpen([1,3])
            sut.verifyMatchInWord("A")
            sut.verifyMatchInWord("N")
            sut.verifyMatchInWord("Y")
            sut.verifyMatchInWord("W")
            sut.verifyMatchInWord("O")
            sut.verifyMatchInWord("R")
            
            sut.delegateOutput = homePresenterOutputMock
            
            setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
            ))
            
            sut.verifyMatchInWord(expectedLetter)
            
        }), calledOutputTest: {
            XCTAssertTrue(homePresenterOutputMock.called.markChosenKeyboardLetter)
            XCTAssertTrue(homePresenterOutputMock.called.updateCountCorrectLetters)
            XCTAssertTrue(homePresenterOutputMock.called.revealCorrectLetters)
            XCTAssertTrue(homePresenterOutputMock.called.revealDollEndGameSuccess)
        })
          
    }
    
    
    
    //  MARK: - SETUP
    private func configInitial() -> (sut:HomePresenterImpl, getLastOpenHintsUseCaseSpy: GetLastOpenHintsUseCaseSpy) {
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
        

        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .success([])
        
        return (sut, getLastOpenHintsUseCaseSpy)
    }
    
    private func startGame(_ sut: HomePresenterImpl, _ getLastOpenHintsUseCaseSpy: GetLastOpenHintsUseCaseSpy, completion: @escaping () -> Void, calledOutputTest: (() -> Void)? = nil) {
        
        let expStartGame = expectation(description: "StartGame")
        getLastOpenHintsUseCaseSpy.observer { _ in
            completion()
            expStartGame.fulfill()
            calledOutputTest?()
        }
        
        sut.startGame()
        
        wait(for: [expStartGame], timeout: 5)
    }
    
    
}


