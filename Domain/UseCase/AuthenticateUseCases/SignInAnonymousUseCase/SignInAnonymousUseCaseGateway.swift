//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public protocol SignInAnonymousUseCaseGateway {
    typealias UserID = String
    func signInAnonymosly() async throws -> UserID?
}
