//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

class LifeHelpUseCase: TypeGameHelpUseCase {
    private let maxLifeHelp: Int8 = 5

    var isFull: Bool { true }
    
    func use() async throws {
        
    }
    
    func add(_ count: Int8) async throws {
        
    }
    
    func usedCount() -> Int8 {
        0
    }
    
    func maxHelp() -> Int8 {
        // TODO: - CHANGE TO FETCH FROM THE DATABASE
        return maxLifeHelp
    }
    
    func remaining() -> Int8 {
        return maxHelp() - usedCount()
    }
    
    func renewFreeHelp() async throws {
        
    }
    
    
}
