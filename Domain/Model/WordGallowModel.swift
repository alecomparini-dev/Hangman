//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public struct WordGallowModel {
    public var id: Int
    public var word: String
    public var syllables: [String]
    public var category: String?
    public var initalTip: String?
    public var tips: [String]?
    public var resultWordGame: ResultWordGame?
    
    public init(id: Int, word: String, syllables: [String], category: String? = nil, initalTip: String? = nil, tips: [String]? = nil, resultWordGame: ResultWordGame? = nil) {
        self.id = id
        self.word = word
        self.syllables = syllables
        self.category = category
        self.initalTip = initalTip
        self.tips = tips
        self.resultWordGame = resultWordGame
    }
    
    
}


