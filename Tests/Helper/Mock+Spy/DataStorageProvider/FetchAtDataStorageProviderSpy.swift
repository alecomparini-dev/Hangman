//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import UseCaseGateway

class FetchAtDataStorageProviderSpy: FetchAtDataStorageProvider {
    var id: Int!
    var limit: Int!
    var result: Result<[[String: Any]]?, Error> = .success([[:]])
    
    func fetchAt<T>(id: Int, limit: Int) async throws -> T? {
        self.id = id
        self.limit = limit
        switch result {
            case .success(let data):
                return data as? T
            case .failure(let error):
                throw error
        }
    }
    
    func fetchAt<T>(id: Int) async throws -> T? {
        self.id = id
        switch result {
            case .success(let data):
                return data as? T
            case .failure(let error):
                throw error
        }
    }
    
}
