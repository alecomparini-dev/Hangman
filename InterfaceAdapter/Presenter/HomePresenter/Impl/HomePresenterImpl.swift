//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func successFetchNextWord(_ nextWord: NextWordPresenterDTO)
    func nextWordIsOver(title: String, message: String)
    func successCountWordsPlayed(_ count: Int)
    func errorFetchNextWords(title: String, message: String)
    func successSignInAnonymous()
}


public class HomePresenterImpl: HomePresenter {
    weak public var delegateOutput: ProfileSummaryPresenterOutput?
    
    private var userID: String?
    private var lastIDPlayedWord: Int = 0
    private let quantityWords: Int = 3
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
    public func fetchNextWord() {

        if let word = getNextWord() {
            successFetchNextWord(word)
            return
        }
        
        Task {
            
            countWordsPlayed()
            
            do {
                nextWords = try await getNextWordsUseCase.nextWords(atID: lastIDPlayedWord + 1, limit: quantityWords)
                nextWords?.forEach( { word in
                    print("id:", word.id )
//                    print("word:", word.word ?? "")
//                    print("category:", word.category ?? "")
//                    print("syllables:", word.syllables ?? "")
//                    print("initalTip:", word.initialTip ?? "")
//                    print("level:", word.level ?? "")
//                    print("tips:", word.tips ?? "")
//                    
//                    print("\n---------------------------------\n")
                })
                
                if let nextWords {
                    if nextWords.isEmpty { return nextWordIsOver() }
                    let word = nextWords[0]
                    setLastIDPlayedWord(word.id)
                    successFetchNextWord(word)
                }
                
            } catch let error {
                debugPrint(error.localizedDescription)
                errorFetchNextWords("Aviso", "Não foi possível carregar as próximas palavras. Favor tentar novamente mais tarde")
            }
        }
    }
    
    public func signInAnonymously() {
        Task {
            do {
                userID = try await signInAnonymousUseCase.signInAnonymosly()
                print("\nuserID: ", userID ?? "", "\n")
                successSignInAnonymous()
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func saveWordPlayed() {
        guard let userID else { return }
        Task {
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
    }
    
    public func countWordsPlayed() {
        guard let userID else { return }
        Task {
            do {
                let count = try await countWordsPlayedUseCase.count(userID: userID)
                return successCountWordsPlayed(count)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H",
                "I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X",
                "Y","Z",""]
    }
    
    
//  MARK: - PRIVATE OUTPUT AREA
    private func successSignInAnonymous() {
        DispatchQueue.main.async { [weak self] in
            self?.delegateOutput?.successSignInAnonymous()
        }
    }
    
    private func successFetchNextWord(_ word: NextWordsUseCaseDTO) {
        DispatchQueue.main.async { [weak self] in
            guard let self else {return}
            let nextWordPresenterDTO = NextWordPresenterDTO(id: word.id,
                                                            word: word.word,
                                                            syllables: word.syllables,
                                                            category: word.category,
                                                            initialTip: word.initialTip,
                                                            level: convertLevel(word.level),
                                                            tips: word.tips)
            delegateOutput?.successFetchNextWord(nextWordPresenterDTO)
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

    private func successCountWordsPlayed(_ count: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.delegateOutput?.successCountWordsPlayed(count)
        }
    }
    

//  MARK: - PRIVATE AREA

    private func getIndexLastIDPlayedWord() -> Int? {
        return nextWords?.firstIndex(where: { $0.id == lastIDPlayedWord })
    }
    
    
    private func getCurrentWord() -> NextWordsUseCaseDTO? {
        if let indexLastIDPlayed = getIndexLastIDPlayedWord() {
            return nextWords?[indexLastIDPlayed]
        }
        return nil
    }
    
    
    private func getNextWord() -> NextWordsUseCaseDTO? {
        if let nextWords {
            if let indexLastIDPlayed = getIndexLastIDPlayedWord() {
                if indexLastIDPlayed < nextWords.endIndex - 1 {
                    let word = nextWords[indexLastIDPlayed + 1]
                    setLastIDPlayedWord(word.id)
                    return word
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
    
    private func setLastIDPlayedWord(_ id: Int) {
        lastIDPlayedWord = id
    }
    
    
}
