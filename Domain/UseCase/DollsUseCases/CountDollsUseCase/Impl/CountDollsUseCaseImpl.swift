//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public class CountDollsUseCaseImpl: CountDollsUseCase {
    
    private let countModelGateway: GenericCountModelGateway
    
    public init(countModelGateway: GenericCountModelGateway) {
        self.countModelGateway = countModelGateway
    }
    
    
    public func count() async throws -> Int {
        return try await countModelGateway.count()
    }
    
    
}
