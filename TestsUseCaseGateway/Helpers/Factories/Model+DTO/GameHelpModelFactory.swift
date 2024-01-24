//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import Domain
import Handler

struct GameHelpModelFactory {
    
    static func make() -> GameHelpModel {
        return GameHelpModel(dateRenewFree: DateHandler.convertDate("2024-1-12"),
                             typeGameHelp: TypeGameHelpModel(lives: 5,
                                                             hints: 10,
                                                             revelations: 5)
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


