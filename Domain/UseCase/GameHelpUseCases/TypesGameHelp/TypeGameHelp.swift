//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

protocol TypeGameHelp {
    var isFull: Bool { get }
    
    func use() async throws
    
    func add(_ count: Int) async throws
    
    func maxHelp() -> Int
    func count() -> Int
    func used() -> Int
}
