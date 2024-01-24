//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import UseCaseGateway

class InsertDataStorageProviderSpy: InsertDataStorageProvider {
    var collection: String!
    var documentID: String!
    var value: Any!
    
    var insertResult: Result<[String: Any]?, Error> = .success([:])
    
    func insert<T>(_ collection: String, _ documentID: String, _ value: T) async throws -> T? {
        self.collection = collection
        self.documentID = documentID
        self.value = value
        
        switch insertResult {
            case .success(_):
                return nil
            case .failure(let error):
                throw error
        }
    }
    
    func insert<T>(_ value: T) async throws -> T? {
        return nil
    }
    
    func insert<T>(_ collection: String, _ value: T) async throws -> T? {
        return nil
    }
    
    
}
