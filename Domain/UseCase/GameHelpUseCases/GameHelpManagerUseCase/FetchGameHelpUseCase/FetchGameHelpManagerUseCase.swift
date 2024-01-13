//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public protocol FetchGameHelpManagerUseCase {
    func fetch(_ userID: String) async throws -> FetchGameHelpUseCaseDTO?
}
