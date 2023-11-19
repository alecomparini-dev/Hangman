//  Created by Alessandro Comparini on 19/11/23.
//

import Foundation

public protocol AuthenticateAnonymous {
    typealias UserID = String
    func signInAnonymosly() async throws -> UserID?
}
