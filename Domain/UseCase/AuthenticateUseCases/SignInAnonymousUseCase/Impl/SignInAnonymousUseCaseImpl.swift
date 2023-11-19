//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public class SignInAnonymousUseCaseImpl: SignInAnonymousUseCase {
    private let signInAnonymousGateway: SignInAnonymousUseCaseGateway
    
    public init(signInAnonymousGateway: SignInAnonymousUseCaseGateway) {
        self.signInAnonymousGateway = signInAnonymousGateway
    }
    
    
    public func signInAnonymosly() async throws -> UserID? {
        return try await signInAnonymousGateway.signInAnonymosly()
    }

    
}
