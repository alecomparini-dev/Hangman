//  Created by Alessandro Comparini on 20/11/23.
//

import Foundation

struct SaveWordPlayedCodable: Codable {
    var wordID: Int
    var success: Bool?
    var quantityCorrectLetters: Int?
    var quantityErrorLetters: Int?
    var timeConclusion: Int?
}


