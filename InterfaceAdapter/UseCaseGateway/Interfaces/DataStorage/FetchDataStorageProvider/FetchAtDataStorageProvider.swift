//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation


public protocol FetchAtDataStorageProvider {
    func fetchAt<T>(id: Int) async throws -> T?
    func fetchAt<T>(id: Int, limit: Int) async throws -> T?
}
