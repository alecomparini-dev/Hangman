//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public protocol SaveWordPlayedUseCase {
    func save(userID: String, _ wordPlayed: WordPlayedUseCaseDTO) async throws
}
