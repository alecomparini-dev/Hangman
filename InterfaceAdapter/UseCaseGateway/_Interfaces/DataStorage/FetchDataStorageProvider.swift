//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation


public protocol FetchByIDDataStorageProvider {
    func fetchByID<T>(_ id: String) async throws -> T?
}

public protocol FetchCountDataStorageProvider {
    func fetchCount() async throws -> Int
}

public protocol FetchAtIDDataStorageProvider {
    func fetchAt<T>(id: Int) async throws -> T?
    func fetchAt<T>(id: Int, limit: Int) async throws -> T?
}
