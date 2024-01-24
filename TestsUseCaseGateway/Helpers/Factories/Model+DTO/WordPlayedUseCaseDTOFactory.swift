//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain


struct WordPlayedUseCaseDTOFactory {
    
    static func make() -> WordPlayedUseCaseDTO {
        return WordPlayedUseCaseDTO(id: 1,
                                    success: true,
                                    correctLettersCount: 1,
                                    wrongLettersCount: 2,
                                    timeConclusion: 1000000,
                                    level: 0
        )
    }
    
    static func toJSON() -> [String: Any] {
        return [
            "id": 1,
            "success": true,
            "correctLettersCount": 1,
            "wrongLettersCount": 2,
            "timeConclusion": 1000000,
            "level": 0
        ]
    }
}
