
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
//  MARK: - VERIFYMATCHINWORD
    
    func test_verifyMatchInWord_isNotEndGame() {
        let (sut, homePresenterOutputMock) = configInitial()
        sut.delegateOutput = homePresenterOutputMock
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
            wordPlaying: NextWordsUseCaseDTOFactory.make(),
            nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10)
        ))
        
        let expectedLetter = "A"
        startGame(sut,homePresenterOutputMock) { [weak self] in
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
            
            sut.verifyMatchInWord(expectedLetter)
            
            wait(for: [expRevealCorrectLetters, expMarkChosenKeyboardLetter,expUpdateCountCorrectLetters], timeout: 1)
        }
        
        
        
        
    }
    

//  MARK: - SETUP
    private func configInitial() -> (sut:HomePresenterImpl, homePresenterOutputMock: HomePresenterOutputMock) {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy()
        let fetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy()
        let getLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy()
        let homePresenterOutputMock = HomePresenterOutputMock()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy,
                          fetchGameHelpUseCase: fetchGameHelpUseCaseSpy,
                          getLastOpenHintsUseCase: getLastOpenHintsUseCaseSpy )
        
        sut.delegateOutput = homePresenterOutputMock
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .success([NextWordsUseCaseDTOFactory.make()])
        fetchGameHelpUseCaseSpy.setResult = .success(FetchGameHelpUseCaseDTOFactory.make())
        getLastOpenHintsUseCaseSpy.setResult = .success([])
        
        return (sut, homePresenterOutputMock)
    }
    
    private func startGame(_ sut: HomePresenterImpl, _ homePresenterOutputMock: HomePresenterOutputMock, completion: @escaping () -> Void) {
        let expStartGame = expectation(description: "StartGame")
        sut.startGame()
        homePresenterOutputMock.observer { _ in
            expStartGame.fulfill()
            completion()
        }
        wait(for: [expStartGame], timeout: 1)
    }
    
    
}


