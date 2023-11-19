//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public protocol FetchByDataStorageProvider {
    func fetchBy<T>(id: String) async throws -> T?
}
