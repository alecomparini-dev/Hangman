//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation

import Domain

class SignInAnonymousUseCaseGatewayMock: SignInAnonymousUseCaseGateway {
    var result: Result<String?, Error> = .success("userID")
    
    func signInAnonymosly() async throws -> String? {
        switch result {
            case .success(let data):
                return data
            case .failure(let error):
                throw error
        }
    }
            
}
