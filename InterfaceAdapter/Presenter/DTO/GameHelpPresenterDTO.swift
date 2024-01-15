//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameHelpPresenterDTO {
    public var livesCount: Int
    public var hintsCount: Int
    public var revelationsCount: Int
    
    public init(livesCount: Int, hintsCount: Int, revelationsCount: Int) {
        self.livesCount = livesCount
        self.hintsCount = hintsCount
        self.revelationsCount = revelationsCount
    }
}
