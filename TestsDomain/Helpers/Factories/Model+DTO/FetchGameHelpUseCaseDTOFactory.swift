//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

struct FetchGameHelpUseCaseDTOFactory {
    
    static func make() -> FetchGameHelpUseCaseDTO {
        return FetchGameHelpUseCaseDTO(
            livesCount: 5,
            hintsCount: 10,
            revelationsCount: 5)
    }
    
}
