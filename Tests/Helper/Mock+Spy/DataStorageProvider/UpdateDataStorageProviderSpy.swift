//  Created by Alessandro Comparini on 23/01/24.
//

import Foundation
import UseCaseGateway

class UpdateDataStorageProviderSpy: UpdateDataStorageProvider {
    var collection: String!
    var documentID: String!
    var value: Any!
    
    var updateResult: Result<[String: Any]?, Error> = .success([:])
    
    func update<T>(_ collection: String, _ documentID: String, _ value: T) async throws {
        self.collection = collection
        self.documentID = documentID
        self.value = value
        
        switch updateResult {
            case .success(_):
                return
            case .failure(let error):
                throw error
        }
    }
    
    
    
}
