//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public protocol GetLastOpenHintsUseCaseGateway {
    func get(_ userID: String) async throws -> [Int]
}
