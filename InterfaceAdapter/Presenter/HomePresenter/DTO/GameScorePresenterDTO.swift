//  Created by Alessandro Comparini on 09/01/24.
//

import Foundation

public struct GameScorePresenterDTO {
    public var life: Int8
    public var tip: Int8
    public var reveal: Int8
    
    public init(life: Int8, tips: Int8, reveal: Int8) {
        self.life = life
        self.tip = tips
        self.reveal = reveal
    }
}
