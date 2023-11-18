//  Created by Alessandro Comparini on 18/11/23.
//

import Foundation


public struct GetNextWordsDTO {
    
}

public protocol GetNextWords {
    func netxWords(at: Int, limit: Int?) -> GetNextWordsDTO
}
