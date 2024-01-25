//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import UseCaseGateway

class FetchInDataStorageProviderSpy: FetchInDataStorageProvider {
    var value: Any!
    var result: Result<[[String: Any]]?, Error> = .success([[:]])
    
    func fetchIn<T>(id: [Int]) async throws -> T? {
        value = id
        switch result {
            case .success(let data):
                return data as? T
            case .failure(let error):
                throw error
        }
    }
    
    func fetchNotIn<T>(id: [Int]) async throws -> T? {
        debugPrint("Not tested yet")
        return nil
    }
    
    func fetchIn<D, T>(column: String, _ values: [D]) async throws -> T? {
        debugPrint("Not tested yet")
        return nil
    }
    
}
