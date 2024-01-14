//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Domain
import Handler


struct FetchGameHelpCodable: Codable {
    var dateRenewFree: Date?
    var lives: FetchLivesGameHelpCodable?
    var hints: FetchHintsGameHelpCodable?
    var revelations: FetchRevelationsGameHelpCodable?
    
    
    func mapperToGameHelp() -> GameHelpModel {
        return GameHelpModel(
            dateRenewFree: self.dateRenewFree,
            lives: LivesGameHelpModel(freeLives: self.lives?.freeLives ?? 0,
                                      buyLives: self.lives?.buyLives ?? 0,
                                      adLives: self.lives?.adLives ?? 0),
            hints: HintsGameHelpModel(freeHints: self.hints?.freeHints ?? 0,
                                      adHints: self.hints?.adHints ?? 0),
            revelations: RevelationsGameHelpModel(freeRevelations: self.revelations?.freeRevelations ?? 0,
                                                  buyRevelations: self.revelations?.buyRevelations ?? 0,
                                                  adRevelations: self.revelations?.adRevelations ?? 0)
        )
    }
    
}

