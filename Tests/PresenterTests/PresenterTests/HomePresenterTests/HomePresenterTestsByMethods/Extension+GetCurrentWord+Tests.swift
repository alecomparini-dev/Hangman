
import Foundation

import XCTest
import Domain
import Presenter

extension HomePresenterTests {

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
        
}


