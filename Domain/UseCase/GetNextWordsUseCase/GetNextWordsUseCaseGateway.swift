//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public protocol GetNextWordsUseCaseGateway {
    func nextWords(at: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO]
}
