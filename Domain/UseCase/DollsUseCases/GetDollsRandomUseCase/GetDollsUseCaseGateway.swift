//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public protocol GetDollsUseCaseGateway {
    func getDolls(id: [Int]) async throws -> [DollUseCaseDTO]
}
