//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class GenericCountModelGatewaySpy: GenericCountModelGateway {
    var model = ""
    var result: Result<Int, Error> = .success(1)
    
    func count(_ model: String) async throws -> Int {
        self.model = model
        
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
        
}
