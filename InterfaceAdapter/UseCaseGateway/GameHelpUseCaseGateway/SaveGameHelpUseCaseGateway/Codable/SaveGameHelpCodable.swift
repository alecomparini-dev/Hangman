//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation
import Domain
import Handler

struct SaveGameHelpCodable: Codable {
    var dateRenewFree: String?
    var hints: ChannelGameHelpCodable?
    var lives: ChannelGameHelpCodable?
    var revelations: ChannelGameHelpCodable?
    
    
    static func mapper(_ gameHelpModel: GameHelpModel) -> Self {
        let date = DateHandler.separateDate(gameHelpModel.dateRenewFree?.description ?? Date().description)
        let dateRenewFree = "\(date.year)-\(date.month)-\(date.day)"
        
        return SaveGameHelpCodable(
            dateRenewFree: dateRenewFree,
            hints: makeChannel(gameHelpModel.typeGameHelp?.hints?.channel),
            lives: makeChannel(gameHelpModel.typeGameHelp?.lives?.channel),
            revelations: makeChannel(gameHelpModel.typeGameHelp?.revelations?.channel))
    }
    
    static func makeChannel(_ channel: ChannelGameHelpModel?) -> ChannelGameHelpCodable {
        return ChannelGameHelpCodable(free: channel?.free,
                                      ad: channel?.advertising,
                                      buy: channel?.buy)
    }
    
}
