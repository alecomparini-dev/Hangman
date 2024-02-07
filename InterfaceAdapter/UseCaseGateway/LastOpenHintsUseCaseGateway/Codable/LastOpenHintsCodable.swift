//  Created by Alessandro Comparini on 18/01/24.
//

import Foundation

struct LastOpenHintsCodable: Codable {
    var indexes: [Int]?
    
    static func mapper(_ indexes: [Int]) -> Self {
        return LastOpenHintsCodable(indexes: indexes)
    }
}
