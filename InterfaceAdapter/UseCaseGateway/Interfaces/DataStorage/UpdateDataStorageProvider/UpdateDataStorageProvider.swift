//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation

public protocol UpdateDataStorageProvider {
    func update<T>(_ collection: String, _ documentID: String, _ value: T ) async throws
}
