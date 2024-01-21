//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

import AuthenticationSDKMain
import UseCaseGateway

public class HangmanAuthenticationSDK {
    
    private let authenticateMain: AuthenticationMain
    
    public init(authenticateMain: AuthenticationMain) {
        self.authenticateMain = authenticateMain
    }
    
}


//  MARK: - AuthenticateAnonymous
extension HangmanAuthenticationSDK: AuthenticateAnonymous {
    
    public func signInAnonymosly() async throws -> UserID? {
        return try await authenticateMain.signInAnonymous()
    }
    
}
