//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class GetNextWordsUseCaseGatewaySpy: GetNextWordsUseCaseGateway {
    var atID: Int!
    var limit: Int?
    
    var result: Result<[NextWordsUseCaseDTO], Error> = .success([])
    
    func nextWords(atID: Int, limit: Int?) async throws -> [NextWordsUseCaseDTO] {
        self.atID = atID
        self.limit = limit
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
    
}
