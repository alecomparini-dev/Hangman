//  Created by Alessandro Comparini on 12/01/24.
//

import UIKit

extension HomeViewController: DropdownRevelationsViewDelegate {
    
    func revealLetterButtonTapped(component: UIView) {
        buttonReveal = component
        homePresenter.revealLetterGameRandom(1)
    }
    
    func closeDropDownRevealLetter() {
        animations.hideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get)
    }
    
}
