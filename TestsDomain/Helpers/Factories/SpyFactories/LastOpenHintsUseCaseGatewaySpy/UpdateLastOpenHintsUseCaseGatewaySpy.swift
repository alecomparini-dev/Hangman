//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

class UpdateLastOpenHintsUseCaseGatewaySpy: UpdateLastOpenHintsUseCaseGateway {
    var userID: String = ""
    var indexes: [Int] = []
    var result: Result<Bool, Error> = .success(true)
    
    func update(_ userID: String, _ indexes: [Int]) async throws {
        self.userID = userID
        self.indexes = indexes
        
        switch result {
            case .success:
                return
            case .failure(let error):
                throw error
        }

    }

}

