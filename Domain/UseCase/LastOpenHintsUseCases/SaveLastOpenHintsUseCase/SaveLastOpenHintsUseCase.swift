//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public protocol SaveLastOpenHintsUseCase {
    func save(_ userID: String, _ indexes: [Int]) async throws
}
