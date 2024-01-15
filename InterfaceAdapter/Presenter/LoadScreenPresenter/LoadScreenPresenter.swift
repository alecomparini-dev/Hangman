//  Created by Alessandro Comparini on 15/01/24.
//

import Foundation
import Domain

public class LoadScreenPresenter {
    
    private let signInAnonymousUseCase: SignInAnonymousUseCase
    
    public init(signInAnonymousUseCase: SignInAnonymousUseCase) {
        self.signInAnonymousUseCase = signInAnonymousUseCase
        signInAnonymously()
    }
    
    private func signInAnonymously() {
        Task {
            do {
                _ = try await signInAnonymousUseCase.signInAnonymosly()
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
}
