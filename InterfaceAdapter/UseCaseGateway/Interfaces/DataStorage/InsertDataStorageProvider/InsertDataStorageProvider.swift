//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

public protocol InsertDataStorageProvider {
    func insert<T>(_ value: T) async throws -> T?
    func insert<T>(_ document: String, _ value: T) async throws -> T?
}
