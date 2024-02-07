//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

struct NextWordsUseCaseDTOFactory {
    
    static func make(id: Int = 1, _ level: Level? = .easy) -> NextWordsUseCaseDTO {
        return NextWordsUseCaseDTO(id: id,
                                   word: "anyword",
                                   syllables: ["any","word"],
                                   category: "anycategory",
                                   initialQuestion: "anyinitialQuestion",
                                   level: level,
                                   hints: ["any_hints1", "any_hints2"])
        
    }
    
    static func toJSON(_ level: Int? = 0) -> [String: Any] {
        return [
            "id": 1,
            "word": "anyword",
            "syllables": ["any","word"],
            "category": "anycategory",
            "initialQuestion": "anyinitialQuestion",
            "level": 0,
            "tips": ["any_hints1", "any_hints2"]
        ]
    }
    
}
