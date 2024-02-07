//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation
import Domain

struct WordPlayedUseCaseDTOToSaveWordPlayedCodableMapper {
    
    static func mapper(wordPlayedDTO: WordPlayedUseCaseDTO ) -> SaveWordPlayedCodable {
        return SaveWordPlayedCodable(
            id: wordPlayedDTO.id,
            success: wordPlayedDTO.success,
            correctLettersCount: wordPlayedDTO.correctLettersCount,
            wrongLettersCount: wordPlayedDTO.wrongLettersCount,
            timeConclusion: wordPlayedDTO.timeConclusion,
            level: wordPlayedDTO.level
        )
    }
}
