//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class SaveWordPlayedUseCaseGatewaySpy: SaveWordPlayedUseCaseGateway {
    var userID = ""
    var wordPlayed: WordPlayedUseCaseDTO!
    
    var result: Result<Bool?, Error> = .success(nil)
    
    func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws {
        self.userID = userID
        self.wordPlayed = wordPlayed
        
        switch result {
            case .success:
                return
            case .failure(let error):
                throw error
        }
    }
    
}
