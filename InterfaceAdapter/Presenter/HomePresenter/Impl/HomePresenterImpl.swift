//  Created by Alessandro Comparini on 15/11/23.
//

import Foundation
import Domain

public class HomePresenterImpl: HomePresenter {
    
    private var nextWords: [GetNextWordsUseCaseDTO]?
    
    private let getNextWordsUseCase: GetNextWordsUseCase
    
    public init(getNextWordsUseCase: GetNextWordsUseCase) {
        self.getNextWordsUseCase = getNextWordsUseCase
    }
    
    public func fetchNextWords(_ lastPlayedWord: String, quantityWords: Int = 20) {
        
        Task {
            do {
                nextWords = try await getNextWordsUseCase.nextWords(at: 0, limit: quantityWords)
                nextWords?.forEach( { word in
                    print("id:", word.id ?? "")
                    print("word:", word.word ?? "")
                    print("category:", word.category ?? "")
                    print("syllables:", word.syllables ?? "")
                    print("initalTip:", word.initialTip ?? "")
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
