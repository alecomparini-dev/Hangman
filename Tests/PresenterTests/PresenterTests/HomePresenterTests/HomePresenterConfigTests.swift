//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

class HomePresenterTests: XCTestCase {
    
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
    
    func setDataTransfer(sut: HomePresenterImpl, dataTransfer: DataTransferHomeVC?) {
        sut.dataTransfer = dataTransfer
    }
    
    
    
}

