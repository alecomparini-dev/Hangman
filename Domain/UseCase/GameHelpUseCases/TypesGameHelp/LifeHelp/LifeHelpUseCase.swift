//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

class LifeHelpUseCase: TypeGameHelp {
    private let maxLifeHelp: Int = 5

    var isFull: Bool { true }
    
    func use() async throws {
        
    }
    
    func add(_ count: Int) async throws {
        
    }
    
    func usedCount() -> Int {
        0
    }
    
    func maxHelp() -> Int {
        // TODO: - CHANGE TO FETCH FROM THE DATABASE
        return maxLifeHelp
    }
    
    func remaining() -> Int {
        return maxHelp() - usedCount()
    }
    
    func renewFreeHelp() async throws {
        
    }
    
    
}
