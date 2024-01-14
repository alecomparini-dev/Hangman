//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

class RevelationHelp: TypeGameHelp {
    private let maxRevelationHelp: Int = 5
    
    var isFull: Bool { maxHelp() == count() }
    
    
    func use() async throws {
        
    }
    
    func add(_ count: Int) async throws {
        
    }
    
    func maxHelp() -> Int { maxRevelationHelp }
    
    func count() -> Int {
        5
    }
    
    func used() -> Int { maxHelp() - count() }
    
}
