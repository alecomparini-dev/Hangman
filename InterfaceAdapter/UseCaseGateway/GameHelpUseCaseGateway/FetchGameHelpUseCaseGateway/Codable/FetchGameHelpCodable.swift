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
            
            typeGameHelp: TypeGameHelpModel(
                lives: LivesGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.lives?.freeLives,
                    advertising: self.lives?.adLives,
                    buy: self.lives?.buyLives)),
                
                hints: HintsGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.hints?.freeHints,
                    advertising: self.hints?.adHints)),
                
                revelations: RevelationsGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.revelations?.freeRevelations,
                    advertising: self.revelations?.adRevelations,
                    buy: self.revelations?.buyRevelations)))
        )
    }
    
}

