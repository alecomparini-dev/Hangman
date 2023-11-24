//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain
import Handler

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func successFetchNextWord(nextWord: NextWordPresenterDTO?)
    func nextWordIsOver(title: String, message: String)
    func errorFetchNextWords(title: String, message: String)
    
    func updateCountCorrectLetters(_ count: String)
    func statusChosenLetter(isCorrect: Bool, _ keyboardLetter: String)
    func revealCorrectLetter(_ indexes: [Int])
    func revealLetterEndGame(_ indexes: [Int])
}


public class HomePresenterImpl: HomePresenter {
    weak public var delegateOutput: ProfileSummaryPresenterOutput?
    
    private struct Control {
        static public var isEndGame = false
    }
    
    private var wordPlaying: NextWordsUseCaseDTO?
    private var joinedWordPlaying: String?
    private var successLetterIndex: Set<Int> = []
    private var errorLetters: Set<String> = []
    
    private var userID: String?
    private var nextWords: [NextWordsUseCaseDTO]?
    
    
//  MARK: - INITIALIZERS
    
    private let signInAnonymousUseCase: SignInAnonymousUseCase
    private let getNextWordsUseCase: GetNextWordsUseCase
    private let countWordsPlayedUseCase: CountWordsPlayedUseCase
    private let saveWordPlayedUseCase: SaveWordPlayedUseCase
    
    public init(signInAnonymousUseCase: SignInAnonymousUseCase, getNextWordsUseCase: GetNextWordsUseCase, countWordsPlayedUseCase: CountWordsPlayedUseCase, saveWordPlayedUseCase: SaveWordPlayedUseCase) {
        self.signInAnonymousUseCase = signInAnonymousUseCase
        self.getNextWordsUseCase = getNextWordsUseCase
        self.countWordsPlayedUseCase = countWordsPlayedUseCase
        self.saveWordPlayedUseCase = saveWordPlayedUseCase
    }
    
    
    
//  MARK: - GET PROPERTIES
    public var isEndGame: Bool { Control.isEndGame  }
    
    
//  MARK: - PUBLIC AREA
    
    public func startGame() {
        startGameAsync()
    }
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z",""]
    }
    
    public func getNextWord() {
        resetGame()
        Task {
            if nextWord() != nil {
                successFetchNextWord()
                return
            }
            await fetchNextWord()
        }
    }
    
    public func getCurrentWord() -> NextWordPresenterDTO? {
        guard let wordPlaying else { return nil }
        return NextWordPresenterDTO(id: wordPlaying.id,
                                    word: wordPlaying.word,
                                    syllables: wordPlaying.syllables,
                                    category: wordPlaying.category,
                                    initialQuestion: wordPlaying.initialQuestion,
                                    level: convertLevel(wordPlaying.level),
                                    tips: wordPlaying.tips)
    }
    

    private func isLetterKeyboardInteractionValid(_ letter: String, _ indexMatch: [Int]) -> Bool {
        if indexMatch.contains(where: successLetterIndex.contains(_:)) { return false }
        if errorLetters.contains(where: { $0 == letter } ) { return false }
        return true
    }
    
    public func verifyMatchInWord(_ letter: String?) {
        if isEndGame { return }
        guard let letter, let joinedWordPlaying else {return}
        let indexMatchInWordFromChosenLetter = joinedWordPlaying.enumerated().compactMap { index, char in
            return (char == Character(letter.lowercased())) ? index : nil
        }
        if !isLetterKeyboardInteractionValid(letter, indexMatchInWordFromChosenLetter) { return }
        addSuccessLetter(indexMatchInWordFromChosenLetter)
        revealCorrectLetter(indexMatchInWordFromChosenLetter)
        addErrorLetter(indexMatchInWordFromChosenLetter, letter)
        statusChosenLetter(indexMatchInWordFromChosenLetter, letter)
        updateCountCorrectLetters()
        checkEndGame()
    }
    
    public func resetGame() {
        joinedWordPlaying = nil
        Control.isEndGame = false
        errorLetters.removeAll()
        successLetterIndex.removeAll()
    }


//  MARK: - PRIVATE AREA

    private func addErrorLetter(_ indexMatch: [Int], _ letter: String) {
        if indexMatch.isEmpty {
            errorLetters.insert(letter)
        }
    }
    
    private func addSuccessLetter(_ indexMatch: [Int]) {
        successLetterIndex.formUnion(indexMatch)
    }
    
    private func startGameAsync() {
        Task {
            await signInAnonymously()
            await fetchNextWord()
        }
    }
    
    private func checkEndGame() {
        if isEndGameFailure() {
            revealLetterEndGame(indexesEndGameToReveal())
        }
        
        if isEndGameSuccess() {
            print("WINS !!!")
        }
    }
    
    private func indexesEndGameToReveal() -> [Int] {
        var indexTotal: Set<Int> = []
        joinedWordPlaying?.enumerated().forEach({ index, char in
            if char.isWhitespace || char.description == K.String.hifen { return }
            indexTotal.insert(index)
        })
        return indexTotal.subtracting(successLetterIndex).sorted()
    }
    
    private func isEndGameFailure() -> Bool {
        if errorLetters.count == K.errorCountToEndGame {
            Control.isEndGame = true
            return true
        }
        return false
    }
    
    public func isEndGameSuccess() -> Bool {
        guard let word = wordPlaying?.word else { return true}
        if successLetterIndex.count == word.count {
            Control.isEndGame = true
            return true
        }
        return false
    }
    
    private func signInAnonymously() async {
        do {
            userID = try await signInAnonymousUseCase.signInAnonymosly()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func countWordsPlayed() async -> Int {
        guard let userID else { return 0}
        do {
            return try await countWordsPlayedUseCase.count(userID: userID)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return 0
    }
    
    private func fetchNextWord() async {
        nextWords = nil
        
        let countWordPlayed = await countWordsPlayed()
        
        do {
            nextWords = try await getNextWordsUseCase.nextWords(atID: countWordPlayed + 1, limit: K.quantityWordsToFetch)

            if let nextWords {
                if nextWords.isEmpty { return nextWordIsOver() }
                wordPlaying = nextWords[0]
                successFetchNextWord()
            }
            
        } catch let error {
            debugPrint(error.localizedDescription)
            errorFetchNextWords("Aviso", "Não foi possível carregar as próximas palavras. Favor tentar novamente mais tarde")
        }
    }
    
    private func saveWordPlayed() async {
        guard let userID else { return }
        do {
            try await saveWordPlayedUseCase.save(
                userID: userID,
                WordPlayedUseCaseDTO(
                    wordID: getCurrentWord()?.id ?? 0,
                    success: true,
                    quantityCorrectLetters: 10,
                    quantityErrorLetters: 3,
                    timeConclusion: nil)
            )
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func getIndexLastIDPlayedWord() -> Int? {
        return nextWords?.firstIndex(where: { $0.id == wordPlaying?.id })
    }
        
    private func nextWord() -> NextWordsUseCaseDTO? {
        if let nextWords {
            if let indexLastIDPlayed = getIndexLastIDPlayedWord() {
                if indexLastIDPlayed < nextWords.endIndex - 1 {
                    wordPlaying = nextWords[indexLastIDPlayed + 1]
                    return wordPlaying
                }
            }
        }
        return nil
    }
    
    private func convertLevel(_ level: Level?) -> LevelPresenter? {
        switch level {
        case .easy:
            return .easy
        case .normal:
            return .normal
        case .hard:
            return .hard
        case .none:
            return .easy
        }
    }
    
    
//  MARK: - PRIVATE OUTPUT AREA
    private func successFetchNextWord() {
        joinedWordPlaying = wordPlaying?.syllables?.joined().lowercased().folding(options: .diacriticInsensitive, locale: nil)
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            delegateOutput?.successFetchNextWord(nextWord: getCurrentWord())
        }
    }

    private func nextWordIsOver() {
        DispatchQueue.main.async { [weak self] in
            self?.delegateOutput?.nextWordIsOver(title: "Aviso", message: "Banco de palavras chegou ao fim.\nEstamos trabalhando para incluir novas palavras. Muito obrigado pela compreensão")
        }
    }
    
    private func errorFetchNextWords(_ title: String, _ message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.delegateOutput?.errorFetchNextWords(title: title, message: message)
        }
    }
    
    private func updateCountCorrectLetters() {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            delegateOutput?.updateCountCorrectLetters("\(successLetterIndex.count)/\(wordPlaying?.word?.count ?? 0)")
        }
    }
    
    private func revealCorrectLetter(_ indexes: [Int]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            delegateOutput?.revealCorrectLetter(indexes)
        }
    }
    
    private func statusChosenLetter(_ indexCorrect: [Int], _ keyboardLetter: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            delegateOutput?.statusChosenLetter(isCorrect: !indexCorrect.isEmpty, keyboardLetter)
        }
    }
    
    private func revealLetterEndGame(_ indexes: [Int]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            delegateOutput?.revealLetterEndGame(indexes)
        }
    }

    
}
