
import Foundation

import XCTest
import Handler
import Domain
import Presenter

extension HomePresenterTests {
    
//  MARK: - VERIFYMATCHINWORD
    
    func test_verifyMatchInWord() {
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
    
    
    
    
}


