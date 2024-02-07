//  Created by Alessandro Comparini on 12/01/24.
//

import UIKit
import CustomComponentsSDK

extension HomeViewController: GameHelpPainelViewDelegate {
    
    func livesCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        if !screen.dropdownLifeView.get.isHidden {
            animations.hideDropdownAnimation(dropdown: screen.dropdownLifeView.get)
            return
        }
        
        animations.showDropdownAnimation(dropdown: screen.dropdownLifeView.get)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            if let dropdown = self?.screen.dropdownRevealLetterView.get {
                self?.animations.hideDropdownAnimation(dropdown: dropdown)
            }
        })
    }
    
    func hintsCountViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        if homePresenter.isEndGame { return }
        animations.hideDropdownAnimation(dropdown: screen.dropdownLifeView.get)
        animations.hideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get)
        coordinator?.gotoHints(makeDataTransferTipVC())
    }
    
    func revelationsCountDropdownViewTapped(_ tapGesture: TapGestureBuilder, _ view: ViewBuilder) {
        if !screen.dropdownRevealLetterView.get.isHidden {
            animations.hideDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get)
            return
        }
        
        animations.showDropdownAnimation(dropdown: screen.dropdownRevealLetterView.get)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
            if let dropdown = self?.screen.dropdownLifeView.get {
                self?.animations.hideDropdownAnimation(dropdown: dropdown)
            }
        })
    }
    
}
