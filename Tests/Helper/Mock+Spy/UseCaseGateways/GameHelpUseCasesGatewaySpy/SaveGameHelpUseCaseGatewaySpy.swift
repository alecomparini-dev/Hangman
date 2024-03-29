//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

class SaveGameHelpUseCaseGatewaySpy: SaveGameHelpUseCaseGateway {
    var userID = ""
    var gameHelp: GameHelpModel!
    
    var result: Result<Bool?, Error> = .success(nil)

    func save(_ userID: String, gameHelp: GameHelpModel) async throws {
        self.userID = userID
        self.gameHelp = gameHelp
        
        switch result {
            case .success:
                return 
            case .failure(let error):
                throw error
        }
    }
    
}

