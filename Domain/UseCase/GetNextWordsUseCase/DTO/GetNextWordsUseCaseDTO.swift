//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public struct GetNextWordsUseCaseDTO {
    public var id: Int?
    public var word: String?
    public var syllables: [String]?
    public var category: String?
    public var initialTip: String?
    public var level: Int?
    public var tips: [String]?
    
    public init(id: Int? = nil, word: String? = nil, syllables: [String]? = nil, category: String? = nil, initialTip: String? = nil, level: Int? = nil, tips: [String]? = nil) {
        self.id = id
        self.word = word
        self.syllables = syllables
        self.category = category
        self.initialTip = initialTip
        self.level = level
        self.tips = tips
    }
    
}
