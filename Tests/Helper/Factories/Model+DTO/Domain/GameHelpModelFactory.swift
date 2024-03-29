//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import Domain
import Handler

struct GameHelpModelFactory {
    
    static func make(dateRenewFree: Date? = DateHandler.convertDate("2024-1-12"), lives: Int? = 5, hints: Int? = 10, revelations: Int? = 5) -> GameHelpModel {
        return GameHelpModel(dateRenewFree: dateRenewFree,
                             typeGameHelp: TypeGameHelpModel(lives: lives,
                                                             hints: hints,
                                                             revelations: revelations)
        )
    }
    
    static func toJSON() -> [String: Any] {
        return [
            "dateRenewFree": "2024-1-12",
            "lives": 5,
            "hints": 10,
            "revelations": 5
        ]
    }
}


