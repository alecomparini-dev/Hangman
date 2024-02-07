//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public protocol CountDollsUseCase {
    func count() async throws -> Int
}
