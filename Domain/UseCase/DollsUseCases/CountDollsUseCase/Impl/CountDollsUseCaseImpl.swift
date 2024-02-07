//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation
import Handler

public class CountDollsUseCaseImpl: CountDollsUseCase {
    
    private let dollsCollection: String = K.Collections.dolls
    
    private let countModelGateway: GenericCountModelGateway
    
    public init(countModelGateway: GenericCountModelGateway) {
        self.countModelGateway = countModelGateway
    }
    
    public func count() async throws -> Int {
        return try await countModelGateway.count(dollsCollection)
    }
    
    
}
