//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

import Domain


public class SignInAnonymousUseCaseGatewayImpl: SignInAnonymousUseCaseGateway {
    
    private let signInAnonymousProvider: AuthenticateAnonymous
    
    public init(signInAnonymousProvider: AuthenticateAnonymous) {
        self.signInAnonymousProvider = signInAnonymousProvider
    }
    
    public func signInAnonymosly() async throws -> UserID? {
        return try await signInAnonymousProvider.signInAnonymosly()
    }
    
}
