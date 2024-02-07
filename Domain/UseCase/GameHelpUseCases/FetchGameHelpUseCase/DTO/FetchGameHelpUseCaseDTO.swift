//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

public struct FetchGameHelpUseCaseDTO: Equatable {
    public var livesCount: Int?
    public var hintsCount: Int?
    public var revelationsCount: Int?
    
    public init(livesCount: Int? = nil, hintsCount: Int? = nil, revelationsCount: Int? = nil) {
        self.livesCount = livesCount
        self.hintsCount = hintsCount
        self.revelationsCount = revelationsCount
    }
}
