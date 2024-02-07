//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import UseCaseGateway

class FindByDataStorageProviderSpy: FindByDataStorageProvider {
    var path: String!
    var helpDocument: String!
    var findByResult: Result<[String: Any]?, Error> = .success([:])
    
    func findBy<T>(_ path: String, _ documentID: String) async throws -> T? {
        self.path = path
        self.helpDocument = documentID
        
        switch findByResult {
        case .success(let data):
            return data as? T
        case .failure(let error):
            throw error
        }
    }
    
    func findBy<T>(id: String) async throws -> T? {
        return nil
    }
    
}
