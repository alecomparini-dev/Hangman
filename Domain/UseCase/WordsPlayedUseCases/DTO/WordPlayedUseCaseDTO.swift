//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public struct WordPlayedUseCaseDTO {
    public var wordID: Int
    public var success: Bool?
    public var quantityCorrectLetters: Int?
    public var quantityErrorLetters: Int?
    public var timeConclusion: Int?
    
    public init(wordID: Int, success: Bool? = nil, quantityCorrectLetters: Int? = nil, quantityErrorLetters: Int? = nil, timeConclusion: Int? = nil) {
        self.wordID = wordID
        self.success = success
        self.quantityCorrectLetters = quantityCorrectLetters
        self.quantityErrorLetters = quantityErrorLetters
        self.timeConclusion = timeConclusion
    }
    
}

