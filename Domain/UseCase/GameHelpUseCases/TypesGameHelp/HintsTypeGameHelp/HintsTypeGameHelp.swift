//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public struct HintsTypeGameHelp: TypeGameHelp {
    private let maxHintsHelp: Int = 10
    
    public init() {    }
    
    func use() async throws {}
    
    func add() async throws {}
    
    func maxHelp() -> Int { maxHintsHelp }
    
    func count(_ channel: ChannelGameHelpModel?) -> Int {
        guard let channel else { return 0}
        return (channel.advertising ?? 0) +
        (channel.free ?? 0) +
        (channel.buy ?? 0)
    }
    
    func used(_ channel: ChannelGameHelpModel?) -> Int { maxHelp() - count(channel) }
    
    func isFull(_ channel: ChannelGameHelpModel?) -> Bool { maxHelp() == count(channel) }
    
}
