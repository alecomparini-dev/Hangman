//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public protocol TypeHelpStrategy {
    var isFull: Bool { get }
    
    func use() async throws
    func add(_ quantity: Int8) async throws
    
    func maxHelp() -> Int8
    func quantityUsed() -> Int8
    func remaining() -> Int8
}
