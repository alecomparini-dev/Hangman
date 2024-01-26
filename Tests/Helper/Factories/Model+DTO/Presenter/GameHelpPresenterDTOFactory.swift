//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import Presenter

struct GameHelpPresenterDTOFactory {
    static func make(livesCount: Int = 2 ,
                     hintsCount: Int = 10 ,
                     revelationsCount: Int = 5) -> GameHelpPresenterDTO {
        
        return GameHelpPresenterDTO(livesCount: livesCount,
                                    hintsCount: hintsCount,
                                    revelationsCount: revelationsCount)
    }
}
