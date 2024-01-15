//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public struct HintsTypeGameHelp: TypeGameHelp {
    private let maxHintsHelp: Int = 10
    
    public init() {    }
    
    public func use() async throws {}
    
    public func add() async throws {}
    
    public func maxHelp() -> Int { maxHintsHelp }
    
    public func count(_ channel: ChannelGameHelpModel?) -> Int {
        guard let channel else { return 0}
        return (channel.advertising ?? 0) +
        (channel.free ?? 0) +
        (channel.buy ?? 0)
    }
    
    public func used(_ channel: ChannelGameHelpModel?) -> Int { maxHelp() - count(channel) }
    
    public func isFull(_ channel: ChannelGameHelpModel?) -> Bool { maxHelp() == count(channel) }
    
}
