//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain
import Handler




public class HomePresenterImpl: HomePresenter {
    weak public var delegateOutput: HomePresenterOutput?
    
    private var randomDoll: DollUseCaseDTO?
    private var dolls: [DollUseCaseDTO]?
    private var countDolls = 1
    private var _isEndGame = false
    private var joinedWordPlaying: String?
    private var successLetterIndex: Set<Int> = []
    private var errorLetters: Set<String> = []
    
    private var userID: String?
    private var wordPlaying: NextWordsUseCaseDTO?
    private var nextWords: [NextWordsUseCaseDTO]?
    
    
//  MARK: - INITIALIZERS
    
    private let signInAnonymousUseCase: SignInAnonymousUseCase
    private let getNextWordsUseCase: GetNextWordsUseCase
    private let countWordsPlayedUseCase: CountWordsPlayedUseCase
    private let saveWordPlayedUseCase: SaveWordPlayedUseCase
    private let getDollsRandomUseCase: GetDollsRandomUseCase
    
    public init(signInAnonymousUseCase: SignInAnonymousUseCase, getNextWordsUseCase: GetNextWordsUseCase, countWordsPlayedUseCase: CountWordsPlayedUseCase, saveWordPlayedUseCase: SaveWordPlayedUseCase, getDollsRandomUseCase: GetDollsRandomUseCase) {
        self.signInAnonymousUseCase = signInAnonymousUseCase
        self.getNextWordsUseCase = getNextWordsUseCase
        self.countWordsPlayedUseCase = countWordsPlayedUseCase
        self.saveWordPlayedUseCase = saveWordPlayedUseCase
        self.getDollsRandomUseCase = getDollsRandomUseCase
    }
    
    
//  MARK: - GET PROPERTIES
    
    public var isEndGame: Bool { _isEndGame  }
    
    public var dataTransfer: DataTransferDTO? {
        get {
            guard let userID, let wordPlaying else { return nil }
            return DataTransferDTO(userID: userID,
                                   wordPlaying: wordPlaying,
                                   nextWords: nextWords,
                                   dolls: dolls)
        }
        set {
            self.userID = newValue?.userID
            self.wordPlaying = newValue?.wordPlaying
            self.nextWords = newValue?.nextWords
            self.dolls = newValue?.dolls
        }
    }
    
    
//  MARK: - PUBLIC AREA
    
    public func startGame() {
        startGameAsync()
    }
    
    public func verifyMatchInWord(_ letter: String?) {
        if isEndGame { return }
        
        guard let letter else { return }
        
        let indexMatchInWordFromChosenLetter: [Int] = checkMatchInWordFromChosenLetter(letter)
        
        if !isLetterKeyboardInteractionValid(letter, indexMatchInWordFromChosenLetter) { return }
        
        addSuccessLetter(indexMatchInWordFromChosenLetter)
        
        addErrorLetter(indexMatchInWordFromChosenLetter, letter)
        
        revealCorrectLetter(indexMatchInWordFromChosenLetter)
        
        revealChosenKeyboardLetter(indexMatchInWordFromChosenLetter, letter)
        
        updateCountCorrectLetters()
        
        checkEndGame()
    }
    
    public func getNextWord() {
        getRandomDoll()
        Task {
            if nextWord() != nil {
                successFetchNextWord()
                return
            }
            await fetchNextWord()
        }
    }
    
    public func getCurrentWord() -> WordPresenterDTO? {
        guard let wordPlaying else { return nil }
        return WordPresenterDTO(id: wordPlaying.id,
                                    word: wordPlaying.word,
                                    syllables: wordPlaying.syllables,
                                    category: wordPlaying.category,
                                    initialQuestion: wordPlaying.initialQuestion,
                                    level: convertLevel(wordPlaying.level),
                                    tips: wordPlaying.tips)
    }
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z",""]
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func startGameAsync() {
        Task {
            await fetchRandomDolls()
            await signInAnonymously()
            await fetchNextWord()
        }
    }
    
    private func checkMatchInWordFromChosenLetter(_ letter: String) -> [Int] {
        guard let joinedWordPlaying else { return [] }
        return joinedWordPlaying.enumerated().compactMap { index, char in
            return (char == Character(letter.lowercased())) ? index : nil
        }
    }
    
    private func addSuccessLetter(_ indexMatch: [Int]) {
        successLetterIndex.formUnion(indexMatch)
    }
    
    private func addErrorLetter(_ indexMatch: [Int], _ letter: String) {
        if indexMatch.isEmpty {
            errorLetters.insert(letter)
            revealPartOfBodyDollIfError()
        }
    }
    
    private func isLetterKeyboardInteractionValid(_ letter: String, _ indexMatch: [Int]) -> Bool {
        if indexMatch.contains(where: successLetterIndex.contains(_:)) { return false }
        if errorLetters.contains(where: { $0 == letter } ) { return false }
        return true
    }
    
    private func revealPartOfBodyDollIfError() {
        revealHeadDoll()
        switch errorLetters.count {
            case 2...5:
                return revealBodyDoll()
            default:
                break
        }
    }
    
    private func fetchRandomDolls() async {
        do {
            dolls = try await getDollsRandomUseCase.getDollsRandom(quantity: 5)
            getRandomDoll()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func getRandomDoll() {
        guard let dolls else { return }
        randomDoll = dolls[(0..<dolls.count).randomElement() ?? 0]
    }
    
    private func checkEndGame() {
        if isEndGameFailure() {
            revealLetterEndGame(indexesEndGameToReveal())
            revealDollEndGameFailure()
        }
        
        if isEndGameSuccess() {
            revealDollEndGameSuccess()
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
            _isEndGame = true
            return true
        }
        return false
    }
    
    private func isEndGameSuccess() -> Bool {
        guard let word = wordPlaying?.word else { return true}
        if successLetterIndex.count == word.count {
            _isEndGame = true
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
        
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.successFetchNextWord(word: getCurrentWord())
        }
    }

    private func nextWordIsOver() {
        MainThread.exec { [weak self] in
            self?.delegateOutput?.nextWordIsOver(title: "Aviso", message: "Banco de palavras chegou ao fim.\nEstamos trabalhando para incluir novas palavras. Muito obrigado pela compreensão")
        }
    }
    
    private func errorFetchNextWords(_ title: String, _ message: String) {
        MainThread.exec { [weak self] in
            self?.delegateOutput?.errorFetchNextWords(title: title, message: message)
        }
    }
    
    private func updateCountCorrectLetters() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateCountCorrectLetters("\(successLetterIndex.count)/\(wordPlaying?.word?.count ?? 0)")
        }
    }
    
    private func revealCorrectLetter(_ indexes: [Int]) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.revealCorrectLetters(indexes)
        }
    }
    
    private func revealChosenKeyboardLetter(_ indexCorrect: [Int], _ keyboardLetter: String) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.revealChosenKeyboardLetter(isCorrect: !indexCorrect.isEmpty, keyboardLetter)
        }
    }
    
    private func revealLetterEndGame(_ indexes: [Int]) {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.revealErrorLetters(indexes)
        }
    }
    
    private func revealHeadDoll() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            if let imgBase64 = randomDoll?.head?.randomElement() {
                delegateOutput?.revealHeadDoll(imgBase64)
            }
        }
    }
    
    private func revealBodyDoll() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            if let imgBase64 = randomDoll?.body?[errorLetters.count - 2] {
                delegateOutput?.revealBodyDoll(imgBase64)
            }
        }
    }
    
    private func revealDollEndGameFailure() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            if let imgBase64 = randomDoll?.fail?.randomElement() {
                delegateOutput?.revealDollEndGameFailure(imgBase64)
            }
        }
    }
    
    private func revealDollEndGameSuccess() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            if let imgBase64 = randomDoll?.success?.randomElement() {
                delegateOutput?.revealDollEndGameSuccess(imgBase64)
            }
        }
    }

    
}
