//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import UseCaseGateway

class AuthenticateAnonymousSpy: AuthenticateAnonymous {
    var result: Result<String?, Error> = .success("")
    
    func signInAnonymosly() async throws -> UserID? {
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
    
}
