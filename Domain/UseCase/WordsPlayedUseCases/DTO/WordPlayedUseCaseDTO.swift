//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public struct WordPlayedUseCaseDTO: Equatable {
    public var id: Int
    public var success: Bool?
    public var correctLettersCount: Int?
    public var wrongLettersCount: Int?
    public var timeConclusion: Int?
    public var level: Int?
    
    public init(id: Int, success: Bool? = nil, correctLettersCount: Int? = nil, wrongLettersCount: Int? = nil, timeConclusion: Int? = nil, level: Int? = nil) {
        self.id = id
        self.success = success
        self.correctLettersCount = correctLettersCount
        self.wrongLettersCount = wrongLettersCount
        self.timeConclusion = timeConclusion
        self.level = level
    }
    
}

