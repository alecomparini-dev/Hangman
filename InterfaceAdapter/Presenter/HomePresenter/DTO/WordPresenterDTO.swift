//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public enum LevelPresenter: String {
    case easy = "Fácil"
    case normal = "Médio"
    case hard = "Difícil"
}

public struct WordPresenterDTO: Equatable {
    public var id: Int
    public var word: String?
    public var syllables: [String]?
    public var category: String?
    public var initialQuestion: String?
    public var level: LevelPresenter?
    public var hints: [String]?
    
    
    public init(id: Int, word: String? = nil, syllables: [String]? = nil, category: String? = nil, initialQuestion: String? = nil, level: LevelPresenter? = nil, hints: [String]? = nil) {
        self.id = id
        self.word = word
        self.syllables = syllables
        self.category = category
        self.initialQuestion = initialQuestion
        self.level = level
        self.hints = hints
    }
    
}

