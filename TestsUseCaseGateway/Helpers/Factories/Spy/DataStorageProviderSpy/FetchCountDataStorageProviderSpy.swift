//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import UseCaseGateway

class FetchCountDataStorageProviderSpy: FetchCountDataStorageProvider {
    var document = ""
    
    var result: Result<Int, Error> = .success(0)
    
    func fetchCount(_ document: String) async throws -> Int {
        self.document = document
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
    
}

