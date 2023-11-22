//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func successFetchNextWord(nextWord: NextWordPresenterDTO?)
    func nextWordIsOver(title: String, message: String)
    func errorFetchNextWords(title: String, message: String)
}


public class HomePresenterImpl: HomePresenter {
    weak public var delegateOutput: ProfileSummaryPresenterOutput?
    
    private var wordPlaying: NextWordsUseCaseDTO?
    
    private var countWordPlayed: Int = 0
    private var userID: String?
    private let quantityWords: Int = 1
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
    
    
//  MARK: - PUBLIC AREA
    
    public func getNextWord() {
        Task {
            if nextWord() != nil {
                addCountWordPlayed(wordPlaying?.id)
                successFetchNextWord()
                return
            }
            await fetchNextWord()
        }
    }
    
    private func addCountWordPlayed(_ value: Int?) {
        countWordPlayed = value ?? 0
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
    
    public func startGame() {
        startGameAsync()
    }
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X","Y","Z",""]
    }
    

//  MARK: - PRIVATE AREA

    private func startGameAsync() {
        Task {
            await signInAnonymously()
            await countWordsPlayed()
            await fetchNextWord()
        }
    }
    
    private func signInAnonymously() async {
        do {
            userID = try await signInAnonymousUseCase.signInAnonymosly()
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func countWordsPlayed() async {
        guard let userID else { return }
        do {
            countWordPlayed = try await countWordsPlayedUseCase.count(userID: userID)
        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func fetchNextWord() async {
        nextWords = nil
        do {
            nextWords = try await getNextWordsUseCase.nextWords(atID: countWordPlayed + 1, limit: quantityWords)

            if let nextWords {
                if nextWords.isEmpty { return nextWordIsOver() }
                wordPlaying = nextWords[0]
                addCountWordPlayed(wordPlaying?.id)
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

    
}
