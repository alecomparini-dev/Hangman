//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public protocol FetchInDataStorageProvider {
    func fetchIn<T>(id: [Int]) async throws -> T?
    func fetchNotIn<T>(id: [Int]) async throws -> T?
    
    func fetchIn<D,T>(column: String, _ values:[D]) async throws -> T?
}
