//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public protocol DeleteLastOpenHintsUseCase {
    func delete(_ userID: String) async throws
}
