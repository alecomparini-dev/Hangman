//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

struct FetchGameHelpUseCaseDTOFactory {
    
    static func make(lives: Int = 5, hints: Int = 10, revelations: Int = 5) -> FetchGameHelpUseCaseDTO {
        return FetchGameHelpUseCaseDTO(
            livesCount: lives,
            hintsCount: hints,
            revelationsCount: revelations)
    }
    
}
