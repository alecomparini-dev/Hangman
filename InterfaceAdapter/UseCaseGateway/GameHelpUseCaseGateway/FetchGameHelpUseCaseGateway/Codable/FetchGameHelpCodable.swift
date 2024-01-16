//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Domain
import Handler


struct FetchGameHelpCodable: Codable {
    var dateRenewFree: String?
    var lives: FetchChannelsGameHelpCodable?
    var hints: FetchChannelsGameHelpCodable?
    var revelations: FetchChannelsGameHelpCodable?
    
    
    func mapperToGameHelp() -> GameHelpModel {
        return GameHelpModel(
            dateRenewFree: convertDateRenew(self.dateRenewFree) ,
            typeGameHelp: TypeGameHelpModel(
                lives: LivesGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.lives?.free,
                    advertising: self.lives?.ad,
                    buy: self.lives?.buy)),
                
                hints: HintsGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.hints?.free,
                    advertising: self.hints?.ad)),
                
                revelations: RevelationsGameHelpModel(channel: ChannelGameHelpModel(
                    free: self.revelations?.free,
                    advertising: self.revelations?.ad,
                    buy: self.revelations?.buy)))
        )
    }
    
    //  MARK: - PRIVATE AREA
    private func convertDateRenew(_ date: String?) -> Date? {
        guard let date else {return nil }
        return DateHandler.convertDate(date)
    }
    
}

