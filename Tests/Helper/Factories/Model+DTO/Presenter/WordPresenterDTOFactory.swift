//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Presenter

struct WordPresenterDTOFactory {
    static func make(id: Int = 1, word: String? = nil, syllables: [String]? =  nil,
                     category: String? =  nil, initialQuestion: String? =  nil,
                     level: LevelPresenter? = nil, hints: [String]? = nil) -> WordPresenterDTO {
        
        return WordPresenterDTO(id: id,
                                word: word,
                                syllables: syllables,
                                category: category,
                                initialQuestion: initialQuestion,
                                level: level,
                                hints: hints)
    }
    
}
