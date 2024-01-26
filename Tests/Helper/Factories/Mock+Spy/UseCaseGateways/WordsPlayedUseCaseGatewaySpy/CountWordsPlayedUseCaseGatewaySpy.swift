//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class CountWordsPlayedUseCaseGatewaySpy: CountWordsPlayedUseCaseGateway {
    var userID = ""
    
    var result: Result<Int, Error> = .success(0)
    
    func count(userID: String) async throws -> Int {
        self.userID = userID
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
}
