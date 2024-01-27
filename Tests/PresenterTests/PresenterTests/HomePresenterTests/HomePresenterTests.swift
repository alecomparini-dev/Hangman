//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class HomePresenterTests: XCTestCase {
    
    
    //  MARK: - GETLASTHINTSOPEN
    func test_getLastHintsOpen_with_values() async {
        let expectResult = [1,2,3]
        let dataTransferLastHintsOpen = DataTransferHintsFactory().make(lastHintsOpen: expectResult)
        
//        let test = makeSut(dataTransfer: dataTransferLastHintsOpen)
        
//        let result = test.sut.getLastHintsOpen()
//        
//        XCTAssertEqual(expectResult, result)
    }
    
    func test_getLastHintsOpen_without_values() async {
        let expectResult = [Int]()
        let dataTransferNil = DataTransferHintsFactory().make()
        
//        let test = makeSut(dataTransfer: dataTransferNil)
        
//        let result = test.sut.getLastHintsOpen()
        
//        XCTAssertEqual(expectResult, result)
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

