//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct HintsGameHelpModel {
    public var freeHints: Int
    public var adHints: Int
 
    public init(freeHints: Int, adHints: Int) {
        self.freeHints = freeHints
        self.adHints = adHints
    }
}


public struct ChannelGameHelp {
    public var free: Int
    public var advertising: Int
    public var buy: Int
}


//public struct HintsGameHelpModel {
//    public var channel: ChannelGameHelp
// 
//    public init(channel: ChannelGameHelp) {
//        self.channel = channel
//    }
//}
//
//
//public struct ChannelGameHelp {
//    public var free: Int
//    public var advertising: Int
//    public var buy: Int
//}
