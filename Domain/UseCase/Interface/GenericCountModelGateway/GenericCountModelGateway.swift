//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public protocol GenericCountModelGateway {
    func count(_ model: String) async throws -> Int
    
    func count() async throws -> Int 
}
