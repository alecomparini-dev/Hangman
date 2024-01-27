//  Created by Alessandro Comparini on 25/01/24.
//

import Foundation
import Domain

class SignInAnonymousUseCaseMock<T>: ObservableResultSpy<T>, SignInAnonymousUseCase {
    
    func signInAnonymosly() async throws -> String? {
        return try await result() as? String
    }
    
}
