//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

extension HomeViewController: DropdownLifeViewDelegate {
    
    func closeDropDown() {
        animations.hideDropdownAnimation(dropdown: screen.dropdownLifeView.get)
    }
    
}
