
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
//  MARK: - test_revealLetterGameRandom_with_revelationsCount_zero
    
    func test_revealLetterGameRandom_with_revelationsCount_zero() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputSpy()
        
        startGame(sut, getLastOpenHintsUseCaseSpy, completion: ({ [weak self] in
            guard let self else { return }
            
            sut.delegateOutput = homePresenterOutputMock
            setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 10, revelationsCount: 0)
            ))
            
            sut.revealLetterGameRandom()
            
        }), calledOutputTest: {
            XCTAssertEqual(sut.gameHelpPresenterDTO?.revelationsCount, 0)
            XCTAssertFalse(homePresenterOutputMock.called.updateRevelationsCount)
        })
        
    }

    
//  MARK: - test_revealLetterGameRandom_decreaseRevelation
    
    func test_revealLetterGameRandom_decreaseRevelation() {
        let (sut, getLastOpenHintsUseCaseSpy) = configInitial()
        let homePresenterOutputMock = HomePresenterOutputSpy()
        
        startGame(sut, getLastOpenHintsUseCaseSpy, completion: ({ [weak self] in
            guard let self else { return }
            
            homePresenterOutputMock.observer { receivedOutput in
                guard let receivedOutput = receivedOutput as? [String : Any] else { return }
                
                if let updateRevelationsCount = receivedOutput["updateRevelationsCount"] as? String {
                    XCTAssertEqual(updateRevelationsCount, "4")
                }
            }
            
            sut.verifyMatchInWord("A")
            sut.verifyMatchInWord("N")
            
            sut.delegateOutput = homePresenterOutputMock
            setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(
                wordPlaying: NextWordsUseCaseDTOFactory.make(),
                nextWords: [NextWordsUseCaseDTOFactory.make(), NextWordsUseCaseDTOFactory.make(id:2)],
                gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 5, revelationsCount: 5)
            ))
            
            sut.revealLetterGameRandom()
            
        }), calledOutputTest: {
            XCTAssertEqual(sut.gameHelpPresenterDTO?.livesCount, 5)
            XCTAssertEqual(sut.gameHelpPresenterDTO?.revelationsCount, 4)
            XCTAssertTrue(homePresenterOutputMock.called.updateRevelationsCount)
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


