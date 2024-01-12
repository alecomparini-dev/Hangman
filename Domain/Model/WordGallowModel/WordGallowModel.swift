//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public struct WordGallowModel {
    public var id: Int
    public var word: String
    public var syllables: [String]
    public var category: String?
    public var initalTip: String?
    public var hints: [String]?
    public var resultWordGame: ResultWordGameModel?
    
    public init(id: Int, word: String, syllables: [String], category: String? = nil, initalTip: String? = nil, hints: [String]? = nil, resultWordGame: ResultWordGameModel? = nil) {
        self.id = id
        self.word = word
        self.syllables = syllables
        self.category = category
        self.initalTip = initalTip
        self.hints = hints
        self.resultWordGame = resultWordGame
    }
    
    
}


