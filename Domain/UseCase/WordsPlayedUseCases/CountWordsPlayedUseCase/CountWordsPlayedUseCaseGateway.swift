//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public protocol CountWordsPlayedUseCaseGateway {
    func count(userID: String) async throws -> Int
}
