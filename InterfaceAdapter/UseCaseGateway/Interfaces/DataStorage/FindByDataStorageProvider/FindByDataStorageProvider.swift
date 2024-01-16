//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public protocol FindByDataStorageProvider {
    func findBy<T>(id: String) async throws -> T?
    func findBy<T>(_ path: String, _ documentID: String) async throws -> T?
}
