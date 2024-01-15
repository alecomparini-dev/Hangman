//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain
import Handler


public class HomePresenterImpl: HomePresenter {
    
    weak public var delegateOutput: HomePresenterOutput?
    
    private var revealLetterGame: Set<String> = []
        
    private var gameHelpPresenterDTO: GameHelpPresenterDTO?
    private var randomDoll: DollUseCaseDTO?
    private var dolls: [DollUseCaseDTO]?
    private var _isEndGame = false
    private var joinedWordPlaying: String?
    private var successLetterIndex: Set<Int> = []
    private var errorLetters: Set<String> = []
    
    private var userID: String?
    private var currentWord: NextWordsUseCaseDTO?
    private var nextWords: [NextWordsUseCaseDTO]?
    
    
//  MARK: - INITIALIZERS
    
    private let signInAnonymousUseCase: SignInAnonymousUseCase
    private let getNextWordsUseCase: GetNextWordsUseCase
    private let countWordsPlayedUseCase: CountWordsPlayedUseCase
    private let saveWordPlayedUseCase: SaveWordPlayedUseCase
    private let getDollsRandomUseCase: GetDollsRandomUseCase
    private let fetchGameHelpUseCase: FetchGameHelpUseCase
    
    public init(signInAnonymousUseCase: SignInAnonymousUseCase, getNextWordsUseCase: GetNextWordsUseCase, countWordsPlayedUseCase: CountWordsPlayedUseCase, saveWordPlayedUseCase: SaveWordPlayedUseCase, getDollsRandomUseCase: GetDollsRandomUseCase, fetchGameHelpUseCase: FetchGameHelpUseCase) {
        self.signInAnonymousUseCase = signInAnonymousUseCase
        self.getNextWordsUseCase = getNextWordsUseCase
        self.countWordsPlayedUseCase = countWordsPlayedUseCase
        self.saveWordPlayedUseCase = saveWordPlayedUseCase
        self.getDollsRandomUseCase = getDollsRandomUseCase
        self.fetchGameHelpUseCase = fetchGameHelpUseCase
    }
    
    
//  MARK: - GET PROPERTIES
    
    public var isEndGame: Bool {
        _isEndGame || (gameHelpPresenter?.livesCount == 0)
    }
    
    public var dataTransfer: DataTransferHomeVC? {
        get {
            guard let userID, let currentWord else { return nil }
            return DataTransferHomeVC(userID: userID,
                                      wordPlaying: currentWord,
                                      nextWords: nextWords,
                                      dolls: dolls,
                                      gameHelpPresenterDTO: gameHelpPresenterDTO)
        }
        set {
            self.userID = newValue?.userID
            self.currentWord = newValue?.wordPlaying
            self.nextWords = newValue?.nextWords
            self.dolls = newValue?.dolls
            self.gameHelpPresenterDTO = newValue?.gameHelpPresenterDTO
        }
    }
    
    public var gameHelpPresenter: GameHelpPresenterDTO? { gameHelpPresenterDTO }
    
    
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
            await fetchGameHelp()
            
            if nextWord() != nil {
                successFetchNextWord()
                return
            }
            
            await fetchNextWord()
        }
    }
    
    public func getCurrentWord() -> WordPresenterDTO? {
        guard let currentWord else { return nil }
        
        return WordPresenterDTO(id: currentWord.id,
                                    word: currentWord.word,
                                    syllables: currentWord.syllables,
                                    category: currentWord.category,
                                    initialQuestion: currentWord.initialQuestion,
                                    level: convertLevel(currentWord.level),
                                    hints: currentWord.hints)
    }
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z",""]
    }
    
    private func convertSuccessLetterIndexToLetterString() -> Set<String>{
        guard let joinedWordPlaying else { return [] }
        return Set( successLetterIndex.map { index in
           let index = joinedWordPlaying.index(joinedWordPlaying.startIndex, offsetBy: index)
           let letter = joinedWordPlaying[index]
           return String(letter)
       })
    }
    
    public func revealLetterGameRandom(_ duration: CGFloat = 1) {
        if isEndGame { return }
        
        if gameHelpPresenterDTO?.revelationsCount == 0 { return }
        
        let letterSuccess: Set<String> = convertSuccessLetterIndexToLetterString()

        guard let word = currentWord?.word else { return }
        
        let currentWord: Set<String> = Set( word.map({ String($0) }) )
        
        if let revelationsCount = gameHelpPresenterDTO?.revelationsCount {
            gameHelpPresenterDTO?.revelationsCount = revelationsCount - 1
        }
        
        updateRevelationsCount()
        
        let letterRandom = currentWord.subtracting(letterSuccess).randomElement()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
            self.verifyMatchInWord(letterRandom)
        })   
    }
    
    
//  MARK: - PRIVATE AREA
    
    private func startGameAsync() {
        Task {
            await fetchRandomDolls()
            await signInAnonymously()
            await fetchNextWord()
            await fetchGameHelp()
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
    
    private func signInAnonymously() async {
        do {
            userID = try await signInAnonymousUseCase.signInAnonymosly()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func fetchNextWord() async {
        nextWords = nil
        
        let countWordPlayed = await countWordsPlayed()
        
        do {
            nextWords = try await getNextWordsUseCase.nextWords(atID: countWordPlayed + 1, limit: K.quantityWordsToFetch)

            if let nextWords {
                if nextWords.isEmpty { return nextWordIsOver() }
                currentWord = nextWords[0]
                successFetchNextWord()
            }
            
        } catch let error {
            debugPrint(error.localizedDescription)
            errorFetchNextWords("Aviso", "Não foi possível carregar as próximas palavras. Favor tentar novamente mais tarde")
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
    
    private func checkEndGame() {
        checkEndGameFailure()
        checkEndGameSuccess()
        endGameActions()
    }
    
    private func checkEndGameFailure() {
        if !isEndGameFailure() { return }
        configureEndGameFailure()
    }
    
    private func configureEndGameFailure() {
        revealLetterEndGame(indexesEndGameToReveal())
        revealDollEndGameFailure()
        decreaseLife()
    }
    
    private func decreaseLife() {
//        _gameHelp?.typeGameHelp?.lives?.channel.free! -= 1
        updateCountLife()
    }
    
    private func checkEndGameSuccess() {
        if !isEndGameSuccess() { return }
        revealDollEndGameSuccess()
    }
    
    private func endGameActions() {
        if !isEndGame { return  }
        Task {
            await saveWordPlayed()
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
        guard let word = currentWord?.word else { return true}
        if successLetterIndex.count == word.count {
            _isEndGame = true
            return true
        }
        return false
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
    
    private func fetchGameHelp() async {
        guard let userID else { return }
        
        do {
            let fetchGameHelpDTO = try await fetchGameHelpUseCase.fetch(userID)
            gameHelpPresenterDTO = GameHelpPresenterDTO(livesCount: fetchGameHelpDTO?.livesCount ?? 0,
                                                        hintsCount: fetchGameHelpDTO?.hintsCount ?? 0,
                                                        revelationsCount: fetchGameHelpDTO?.revelationsCount ?? 0)
            updateGameHelp()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func saveWordPlayed() async {
        guard let userID else { return }
        do {
            try await saveWordPlayedUseCase.save(
                userID: userID,
                WordPlayedUseCaseDTO(
                    id: getCurrentWord()?.id ?? 0,
                    success: true,
                    correctLettersCount: 10,
                    wrongLettersCount: 3,
                    timeConclusion: nil)
            )
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func getIndexLastIDPlayedWord() -> Int? {
        return nextWords?.firstIndex(where: { $0.id == currentWord?.id })
    }
        
    private func nextWord() -> NextWordsUseCaseDTO? {
        if let nextWords {
            if let indexLastIDPlayed = getIndexLastIDPlayedWord() {
                if indexLastIDPlayed < nextWords.endIndex - 1 {
                    currentWord = nextWords[indexLastIDPlayed + 1]
                    return currentWord
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
        joinedWordPlaying = currentWord?.syllables?.joined().lowercased().folding(options: .diacriticInsensitive, locale: nil)
        
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.successFetchNextWord(word: getCurrentWord())
        }
    }

    private func nextWordIsOver() {
        _isEndGame = true
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
            delegateOutput?.updateCountCorrectLetters("\(successLetterIndex.count)/\(currentWord?.word?.count ?? 0)")
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
    
    private func updateGameHelp() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            if let gameHelpPresenterDTO {
                delegateOutput?.updateGameHelp(gameHelpPresenterDTO)
            }
        }
    }
    
    private func updateCountLife() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateLivesCount(gameHelpPresenterDTO?.livesCount.description ?? "0")
        }
    }
    
    private func updateHintsCount() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateHintsCount(gameHelpPresenterDTO?.hintsCount.description ?? "0")
        }
    }
    
    private func updateRevelationsCount() {
        MainThread.exec { [weak self] in
            guard let self else {return}
            delegateOutput?.updateRevelationsCount(gameHelpPresenterDTO?.revelationsCount.description ?? "0")
        }
    }
    
    
}
