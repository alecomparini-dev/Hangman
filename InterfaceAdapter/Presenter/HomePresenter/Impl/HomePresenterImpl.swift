//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain

public protocol ProfileSummaryPresenterOutput: AnyObject {
    func successFetchNextWords()
    func errorFetchNextWords(title: String, message: String)
}


public class HomePresenterImpl: HomePresenter {
    
    private let quantityWords: Int = 2
    private var lastIDPlayedWord: Int = 5
    private var nextWords: [GetNextWordsUseCaseDTO]?
    
    
//  MARK: - INITIALIZERS
    
    private let getNextWordsUseCase: GetNextWordsUseCase
    
    public init(getNextWordsUseCase: GetNextWordsUseCase) {
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
    
    
    public func getLettersKeyboard() -> [String] {
        return ["A","B","C","D","E","F","G","H",
                "I","J","K","L","M","N","O","P",
                "Q","R","S","T","U","V","W","X",
                "Y","Z",""]
    }
    
    
}
