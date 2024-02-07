//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation

public protocol FetchDataStorageProvider {
    func fetch<T>() async throws -> [T]
    func fetch<T>(_ collection: String) async throws -> [T]
}
