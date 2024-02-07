//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class SignInAnonymousUseCaseMock: ObservableResultSpy, SignInAnonymousUseCase {
    
    func signInAnonymosly() async throws -> String? {
        return try await result()
    }
    
}
