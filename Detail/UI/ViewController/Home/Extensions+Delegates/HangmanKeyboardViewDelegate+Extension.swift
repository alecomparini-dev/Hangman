//  Created by Alessandro Comparini on 12/01/24.
//

import UIKit

extension HomeViewController: HangmanKeyboardViewDelegate {
    
    func letterButtonTapped(_ button: UIButton) {
        homePresenter.verifyMatchInWord(button.titleLabel?.text)
    }
    
    func hintsButtonTapped() {
        if homePresenter.isEndGame { return }
        coordinator?.gotoHints(makeDataTransferTipVC())
    }
    
}
