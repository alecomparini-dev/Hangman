//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public enum Level: Int {
    case easy = 0
    case normal = 1
    case hard = 2
}

public struct NextWordsUseCaseDTO {
    public var id: Int
    public var word: String?
    public var syllables: [String]?
    public var category: String?
    public var initialQuestion: String?
    public var level: Level?
    public var hints: [String]?
    
    public init(id: Int, word: String? = nil, syllables: [String]? = nil, category: String? = nil, initialQuestion: String? = nil, level: Level? = nil, hints: [String]? = nil) {
        self.id = id
        self.word = word
        self.syllables = syllables
        self.category = category
        self.initialQuestion = initialQuestion
        self.level = level
        self.hints = hints
    }
    
}
