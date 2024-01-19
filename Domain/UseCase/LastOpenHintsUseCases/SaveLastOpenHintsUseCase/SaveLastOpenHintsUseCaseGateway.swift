//  Created by Alessandro Comparini on 19/01/24.
//

import Foundation

public protocol SaveLastOpenHintsUseCaseGateway {
    func save(_ userID: String, _ indexes: [Int]) async throws
}
