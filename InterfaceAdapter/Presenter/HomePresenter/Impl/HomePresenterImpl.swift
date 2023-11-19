//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func successSignInAnonymous()
    func successFetchNextWords()
    func errorFetchNextWords(title: String, message: String)
}


public class HomePresenterImpl: HomePresenter {
    weak public var delegateOutput: ProfileSummaryPresenterOutput?
    
    private let quantityWords: Int = 2
    private var lastIDPlayedWord: Int = 5
    private var nextWords: [GetNextWordsUseCaseDTO]?
    
    
//  MARK: - INITIALIZERS
    
    private let signInAnonymousUseCase: SignInAnonymousUseCase
    private let getNextWordsUseCase: GetNextWordsUseCase
    
    public init(signInAnonymousUseCase: SignInAnonymousUseCase, getNextWordsUseCase: GetNextWordsUseCase) {
        self.signInAnonymousUseCase = signInAnonymousUseCase
        self.getNextWordsUseCase = getNextWordsUseCase
    }
    
    
//  MARK: - PUBLIC AREA
    public func fetchNextWords() {
        
        Task {
            do {
                nextWords = try await getNextWordsUseCase.nextWords(atID: lastIDPlayedWord + 1, limit: quantityWords)
                nextWords?.forEach( { word in
                    print("id:", word.id ?? "")
                    print("word:", word.word ?? "")
                    print("category:", word.category ?? "")
                    print("syllables:", word.syllables ?? "")
                    print("initalTip:", word.initialTip ?? "")
                    print("level:", word.level ?? "")
                    print("tips:", word.tips ?? "")
                    
                    print("\n---------------------------------\n")
                })
                                    
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
        
    }
    
    public func signInAnonymously() {
        
        Task {
            do {
                let userID = try await signInAnonymousUseCase.signInAnonymosly()
                print("\nuserID: ", userID ?? "", "\n")
                successSignInAnonymous()
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
    
    
//  MARK: - PRIVATE AREA
    private func successSignInAnonymous() {
        DispatchQueue.main.async { [weak self] in
            self?.delegateOutput?.successSignInAnonymous()
        }
    }
    
}
