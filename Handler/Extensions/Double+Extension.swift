//  Created by Alessandro Comparini on 28/11/23.
//

import Foundation

public extension Double {
    var degreesToPI: Double { self * (Double.pi/180) }
    
    var piToDegrees: Double { self * (180/Double.pi) }
}
