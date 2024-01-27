//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class UpdateGameHelpUseCaseSpy: UpdateGameHelpUseCase {
    var userID: String = ""
    var gameHelp: GameHelpModel!
    
    var result: Result<Bool?, Error> = .success(true)
    
    func update(_ userID: String, gameHelp: Domain.GameHelpModel) async throws {
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
