//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public protocol GetDollsRandomUseCase {
    func getDollsRandom(quantity: Int) async throws -> [DollUseCaseDTO]
}
