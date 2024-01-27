//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class HomePresenterTests: XCTestCase {
    
    
    //  MARK: - ISENDGAME
    func test_isEndGame_true() async {
        
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 0)))
        
        let result = sut.isEndGame
        
        XCTAssertTrue(result)
    }
    
    func test_isEndGame_false() async {
        
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 5)))
        
        let result = sut.isEndGame
        
        XCTAssertFalse(result)
    }
    
    
}


//  MARK: - EXTENSION MAKE SUT
extension HomePresenterTests {
    func makeSut(signInAnonymousUseCase: SignInAnonymousUseCaseMock = SignInAnonymousUseCaseMock(),
                 getNextWordsUseCase: GetNextWordsUseCaseSpy = GetNextWordsUseCaseSpy(),
                 countWordsPlayedUseCase: CountWordsPlayedUseCaseSpy = CountWordsPlayedUseCaseSpy(),
                 saveWordPlayedUseCase: SaveWordPlayedUseCaseSpy = SaveWordPlayedUseCaseSpy(),
                 getDollsRandomUseCase: GetDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy(),
                 fetchGameHelpUseCase: FetchGameHelpUseCaseSpy = FetchGameHelpUseCaseSpy(),
                 maxGameHelpUseCase: MaxGameHelpUseCaseSpy = MaxGameHelpUseCaseSpy(),
                 updateGameHelpUseCase: UpdateGameHelpUseCaseSpy = UpdateGameHelpUseCaseSpy(),
                 getLastOpenHintsUseCase: GetLastOpenHintsUseCaseSpy = GetLastOpenHintsUseCaseSpy(),
                 delLastOpenHintsUseCase: DeleteLastOpenHintsUseCaseSpy = DeleteLastOpenHintsUseCaseSpy()) -> HomePresenterImpl {
        
        
        let sut = HomePresenterImpl(signInAnonymousUseCase: signInAnonymousUseCase,
                                    getNextWordsUseCase: getNextWordsUseCase,
                                    countWordsPlayedUseCase: countWordsPlayedUseCase,
                                    saveWordPlayedUseCase: saveWordPlayedUseCase,
                                    getDollsRandomUseCase: getDollsRandomUseCase,
                                    fetchGameHelpUseCase: fetchGameHelpUseCase,
                                    maxGameHelpUseCase: maxGameHelpUseCase,
                                    updateGameHelpUseCase: updateGameHelpUseCase,
                                    getLastOpenHintsUseCase: getLastOpenHintsUseCase,
                                    delLastOpenHintsUseCase: delLastOpenHintsUseCase)
        

        return sut
    }
}


//  MARK: - SET DATATRANSFER

extension HomePresenterTests {
    
    func setDataTransfer(sut: HomePresenterImpl, dataTransfer: DataTransferHomeVC?) {
        sut.dataTransfer = dataTransfer
    }
    
}
