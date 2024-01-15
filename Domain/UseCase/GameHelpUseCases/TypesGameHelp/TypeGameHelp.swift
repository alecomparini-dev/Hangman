//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public protocol TypeGameHelp {
    
    func use() async throws
    func add() async throws
    
    func maxHelp() -> Int
    func count(_ channel: ChannelGameHelpModel?) -> Int
    func used(_ channel: ChannelGameHelpModel?) -> Int
    func isFull(_ channel: ChannelGameHelpModel?) -> Bool
}
