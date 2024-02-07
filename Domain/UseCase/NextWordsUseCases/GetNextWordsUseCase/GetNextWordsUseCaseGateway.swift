//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public protocol GetNextWordsUseCaseGateway {
    func nextWords(atID: Int, limit: Int?) async throws -> [NextWordsUseCaseDTO]
}
