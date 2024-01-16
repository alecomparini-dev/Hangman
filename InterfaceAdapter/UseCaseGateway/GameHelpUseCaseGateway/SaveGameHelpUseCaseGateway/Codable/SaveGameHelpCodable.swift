//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation
import Domain

struct SaveGameHelpCodable: Codable {
    var renewFreeHelps: String?
    var hints: ChannelGameHelpCodable?
    var lives: ChannelGameHelpCodable?
    var revelations: ChannelGameHelpCodable?
    
    
    static func mapper(_ gameHelpModel: GameHelpModel) -> Self {
        return SaveGameHelpCodable(
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
