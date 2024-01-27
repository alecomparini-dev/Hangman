//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

struct NextWordsUseCaseDTOFactory {
    
    static func make(_ level: Level? = .easy) -> NextWordsUseCaseDTO {
        return NextWordsUseCaseDTO(id: 1,
                                   word: "any_word",
                                   syllables: ["a","b","c"],
                                   category: "any_category",
                                   initialQuestion: "any_initialQuestion",
                                   level: level,
                                   hints: ["any_hints1", "any_hints2"])
        
    }
    
    static func toJSON(_ level: Int? = 0) -> [String: Any] {
        return [
            "id": 1,
            "word": "any_word",
            "syllables": ["a","b","c"],
            "category": "any_category",
            "initialQuestion": "any_initialQuestion",
            "level": 0,
            "tips": ["any_hints1", "any_hints2"]
        ]
    }
    
}
