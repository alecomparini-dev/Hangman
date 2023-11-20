//
//  WordPlayedUseCaseDTOToCodable.swift
//  Domain
//
//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation
import Domain

struct WordPlayedUseCaseDTOToSaveWordPlayedCodableMapper {
    
    static func mapper(wordPlayedDTO: WordPlayedUseCaseDTO ) -> SaveWordPlayedCodable {
        return SaveWordPlayedCodable(
            wordID: wordPlayedDTO.wordID,
            success: wordPlayedDTO.success,
            quantityCorrectLetters: wordPlayedDTO.quantityCorrectLetters,
            quantityErrorLetters: wordPlayedDTO.quantityErrorLetters,
            timeConclusion: wordPlayedDTO.timeConclusion)
    }
}
