//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public protocol TypeGameHelp {
    
    static var maxHelp: Int { get }
    
    func use() async throws
    func add() async throws
    
    func count(_ channel: ChannelGameHelpModel?) -> Int
    func used(_ channel: ChannelGameHelpModel?) -> Int
    func isFull(_ channel: ChannelGameHelpModel?) -> Bool
}
