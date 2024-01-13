//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

protocol TypeGameHelpUseCase {
    var isFull: Bool { get }
    
    func use() async throws
    func add(_ count: Int8) async throws
    
    func maxHelp() -> Int8
    func usedCount() -> Int8
    func remaining() -> Int8
}
