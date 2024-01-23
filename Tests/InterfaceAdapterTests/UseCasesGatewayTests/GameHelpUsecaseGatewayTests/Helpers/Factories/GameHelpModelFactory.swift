//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import Domain
import Handler

struct GameHelpModelFactory {
    
    static func make() -> GameHelpModel {
        return GameHelpModel(dateRenewFree: DateHandler.convertDate("2024-01-12"),
                             typeGameHelp: TypeGameHelpModel(lives: 1,
                                                             hints: 2,
                                                             revelations: 3)
        )
    }
    
    static func makeJSON() -> [String: Any] {
        return [
            "dateRenewFree": "2024-01-12",
            "lives": 1,
            "hints": 2,
            "revelations": 3
        ]
    }
}
