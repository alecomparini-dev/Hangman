//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public protocol FetchCountDataStorageProvider {
    func fetchCount(_ document: String) async throws -> Int
}
