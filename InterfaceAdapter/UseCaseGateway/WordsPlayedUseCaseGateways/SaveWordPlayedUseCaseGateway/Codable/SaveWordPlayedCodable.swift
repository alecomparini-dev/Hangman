//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

struct SaveWordPlayedCodable: Codable {
    var id: Int
    var success: Bool?
    var correctLettersCount: Int?
    var wrongLettersCount: Int?
    var timeConclusion: Int?
    var level: Int?
}


