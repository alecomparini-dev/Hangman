//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public protocol FetchGameHelpManagerUseCaseGateway {
    func fetch(_ userID: String) async throws -> GameHelpModel
}
