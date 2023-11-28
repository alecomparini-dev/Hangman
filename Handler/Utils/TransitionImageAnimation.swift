//  Created by Alessandro Comparini on 27/11/23.
//

import UIKit

public struct ImageAnimation {
    
    static public func transition(_ currentImageView: UIImageView, _ newImage: UIImage?) {
        UIView.transition(with: currentImageView, duration: 1, options: .transitionCrossDissolve, animations: {
            currentImageView.image = newImage
        }, completion: nil)
    }
    
}
