//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

class GetLastOpenHintsUseCaseGatewaySpy: GetLastOpenHintsUseCaseGateway {
    var userID: String = ""
    var result: Result<[Int], Error> = .success([0])
    
    func get(_ userID: String) async throws -> [Int] {
        self.userID = userID
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
}
