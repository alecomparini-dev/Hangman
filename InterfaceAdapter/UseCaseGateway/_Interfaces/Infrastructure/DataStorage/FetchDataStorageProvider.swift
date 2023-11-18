//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation

public protocol FetchDataStorageProvider {
    
    func fetch<T>() async throws -> T?
    
    func fetch<T>(limit: Int) async throws -> T? 

    func fetchCount() async throws -> Int
    
    func fetchByID<T>(_ id: String) async throws -> T?

}
