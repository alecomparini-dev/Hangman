//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Domain

public class GameHelpManagerUseCaseGatewayImpl: FetchGameHelpManagerUseCaseGateway {
    

    public func fetch(_ userID: String) async throws -> GameHelpModel {
        
        
        return GameHelpModel()
    }
    
    public func insert(_ userID: String, gameHelp: Domain.GameHelpModel) async throws {
        
    }
    
    
}
