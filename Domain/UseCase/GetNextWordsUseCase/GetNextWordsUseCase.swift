//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public protocol GetNextWordsUseCase {
    func nextWords(at: Int, limit: Int?) async throws -> [GetNextWordsUseCaseDTO]
}
