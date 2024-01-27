//  Created by Alessandro Comparini on 27/01/24.
//

import Foundation

import XCTest
import Handler
import Domain
import Presenter

final class HomePresenterTests: XCTestCase {
    
    
//  MARK: - ISENDGAME
    
    func test_isEndGame_true() {
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 0)))
        
        let result = sut.isEndGame
        
        XCTAssertTrue(result)
    }
    
    func test_isEndGame_false() {
        let sut = makeSut()
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(livesCount: 5)))
        
        let result = sut.isEndGame
        
        XCTAssertFalse(result)
    }
    
    
//  MARK: - DATATRANSFER
    
    func test_dataTransfer_set() {
        let sut = makeSut()
        
        let expectDataTranfer = DataTransferHomeVCFactory().make(
            userID: "123",
            wordPlaying: NextWordsUseCaseDTO(), 
            nextWords: [NextWordsUseCaseDTOFactory.make()],
            dolls: [DollUseCaseDTOFactory.make()],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make())
        
        setDataTransfer(sut: sut, dataTransfer: expectDataTranfer)
        
        XCTAssertEqual(sut.dataTransfer, expectDataTranfer)
    }
    
    func test_dataTransfer_not_set() {
        let sut = makeSut()
        
        let dataTranfer = DataTransferHomeVCFactory().make(
            userID: "123",
            wordPlaying: nil,
            nextWords: [NextWordsUseCaseDTOFactory.make()],
            dolls: [DollUseCaseDTOFactory.make()],
            gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make())
        
        setDataTransfer(sut: sut, dataTransfer: dataTranfer)
        
        XCTAssertEqual(sut.dataTransfer, nil)
    }
    
    
//  MARK: - SETLASTHINTSOPEN
    
    func test_setLastHintsOpen_set() {
        let sut = makeSut()
        let expectedLastHints = [1,2,3]
        
        sut.setLastHintsOpen(expectedLastHints)
        
        let lastHintsOpen = sut.lastHintsOpen
        
        XCTAssertEqual(lastHintsOpen, expectedLastHints)
    }
    
    func test_lastHintsOpen_empty() {
        let sut = makeSut()
        let expectedLastHints = [Int]()
        
        let lastHintsOpen = sut.lastHintsOpen
        
        XCTAssertEqual(lastHintsOpen, expectedLastHints)
    }


//  MARK: - SETHINTSCOUNT
    
    func test_setHintsCount_set() {
        let sut = makeSut()
        let expectedHintsCount = 10
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(gameHelpPresenterDTO: GameHelpPresenterDTOFactory.make(hintsCount: expectedHintsCount)))
        
        sut.setHintsCount(expectedHintsCount)
        let resultHintsCount = sut.gameHelpPresenterDTO?.hintsCount
        
        XCTAssertEqual(resultHintsCount, expectedHintsCount)
    }
    
    
    
//  MARK: - GETLETTERSKEYBOARD
    
    func test_getLettersKeyboard() {
        let sut = makeSut()
        let expectedLastHints = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P", "Q","R","S","T","U","V","W","X","Y","Z",""]
        
        XCTAssertEqual(sut.getLettersKeyboard(), expectedLastHints)
    }
    
    
//  MARK: - MAXHELP
    func test_maxHelp_lives() {
        test_maxHelp(5, .lives)
    }
    
    func test_maxHelp_hints() {
        test_maxHelp(10, .hints)
    }
    
    func test_maxHelp_revelations() {
        test_maxHelp(5, .revelations)
    }
    
    private func test_maxHelp(_ expectedMax: Int, _ typeGameHelp: TypeGameHelp, file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        XCTAssertEqual(sut.maxHelp(typeGameHelp), expectedMax, file: file, line: line)
    }

    
    
//  MARK: - GETCURRENTWORD
    
    func test_getCurrentWord_level_easy() {
        test_getCurrentWord(.easy, .easy)
        test_getCurrentWord(.hard, .hard)
        test_getCurrentWord(.normal, .normal)
        test_getCurrentWord(nil, .easy)
    }
    
    private func test_getCurrentWord(_ level: Level?, _ levelPresenter: LevelPresenter?, file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        
        let nextWordDTO = NextWordsUseCaseDTOFactory.make(level)
        
        let expectedCurrentWord = WordPresenterDTOFactory.make(id: nextWordDTO.id ?? 0,
                                                               word: nextWordDTO.word,
                                                               syllables: nextWordDTO.syllables,
                                                               category: nextWordDTO.category,
                                                               initialQuestion: nextWordDTO.initialQuestion,
                                                               level: levelPresenter,
                                                               hints: nextWordDTO.hints )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make(wordPlaying: nextWordDTO))
        
        let currentWord = sut.getCurrentWord()
        
        XCTAssertEqual(currentWord, expectedCurrentWord, file: file, line: line)
    }
    
    


//  MARK: - STARTGAME
    
    func test_startGame_signInAnonymously_and_fetchRandomDolls_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock<String>()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy<[DollUseCaseDTO]>()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        let expectedUser = "123"
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success(expectedUser)
        
        let exp = expectation(description: "waiting")
        signInAnonymousUseCaseMock.observer { receivedUser in
            XCTAssertEqual(receivedUser, expectedUser)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)

    }
    
    func test_startGame_signInAnonymously_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock<String>()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy<[DollUseCaseDTO]>()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        signInAnonymousUseCaseMock.observer { receivedUser in
            XCTAssertNil(receivedUser)
            exp.fulfill()
        }
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_startGame_fetchRandomDolls_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock<String>()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy<[DollUseCaseDTO]>()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy)
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        signInAnonymousUseCaseMock.setResult = .success("123")
        getDollsRandomUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        getDollsRandomUseCaseSpy.observer { dolls in
            XCTAssertNil(dolls)
            exp.fulfill()
        }
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }


    //  MARK: - STARTGAME_FETCHNEXTWORD
    func test_startGame_fetchNextWord_success() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock<String>()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy<[DollUseCaseDTO]>()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy<[NextWordsUseCaseDTO]>()
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
            XCTAssertEqual(expectedResult, receivedResult)
            XCTAssertEqual(getNextWordsUseCaseSpy.atID, 1)
            XCTAssertEqual(getNextWordsUseCaseSpy.limit, K.quantityWordsToFetch)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_startGame_fetchNextWord_failure() {
        let signInAnonymousUseCaseMock = SignInAnonymousUseCaseMock<String>()
        let getDollsRandomUseCaseSpy = GetDollsRandomUseCaseSpy<[DollUseCaseDTO]>()
        let getNextWordsUseCaseSpy = GetNextWordsUseCaseSpy<[NextWordsUseCaseDTO]>()
        let sut = makeSut(signInAnonymousUseCase: signInAnonymousUseCaseMock,
                          getNextWordsUseCase: getNextWordsUseCaseSpy,
                          getDollsRandomUseCase: getDollsRandomUseCaseSpy )
        
        setDataTransfer(sut: sut, dataTransfer: DataTransferHomeVCFactory().make())
        
        getDollsRandomUseCaseSpy.setResult = .success([DollUseCaseDTOFactory.make()])
        signInAnonymousUseCaseMock.setResult = .success("123")
        getNextWordsUseCaseSpy.setResult = .failure(MockError.throwError)
        
        let exp = expectation(description: "waiting")
        getNextWordsUseCaseSpy.observer { receivedResult in
            XCTAssertNil(receivedResult)
            exp.fulfill()
        }
        
        sut.startGame()
        
        wait(for: [exp], timeout: 1)
    }
    
    
    
    //  MARK: - STARTGAME_FETCHGAMEHELP
    
    
    
    
}


//  MARK: - EXTENSION MAKE SUT
extension HomePresenterTests {
    func makeSut(signInAnonymousUseCase: SignInAnonymousUseCaseMock<String> = SignInAnonymousUseCaseMock(),
                 getNextWordsUseCase: GetNextWordsUseCaseSpy<[NextWordsUseCaseDTO]> = GetNextWordsUseCaseSpy(),
                 countWordsPlayedUseCase: CountWordsPlayedUseCaseSpy = CountWordsPlayedUseCaseSpy(),
                 saveWordPlayedUseCase: SaveWordPlayedUseCaseSpy = SaveWordPlayedUseCaseSpy(),
                 getDollsRandomUseCase: GetDollsRandomUseCaseSpy<[DollUseCaseDTO]> = GetDollsRandomUseCaseSpy(),
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
