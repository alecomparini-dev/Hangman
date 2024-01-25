//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

class FetchGameHelpUseCaseGatewaySpy: FetchGameHelpUseCaseGateway {
    var userID = ""
    var gameHelp = ""
    var typeGameHelp:TypeGameHelp = .hints
    
    var result: Result<GameHelpModel?, Error> = .success(nil)
    
    func fetch(_ userID: String) async throws -> GameHelpModel? {
        self.userID = userID
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
}
