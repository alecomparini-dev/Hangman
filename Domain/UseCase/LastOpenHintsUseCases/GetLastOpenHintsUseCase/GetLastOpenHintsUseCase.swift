//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

public protocol GetLastOpenHintsUseCase {
    typealias Index = Int
    func get(_ userID: String) async throws -> [Index]
}
