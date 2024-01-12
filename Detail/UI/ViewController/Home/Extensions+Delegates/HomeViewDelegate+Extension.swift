//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation

extension HomeViewController: HomeViewDelegate {
    
    func nextWordButtonTapped() {
        if let dataTransferDTO = homePresenter.dataTransfer {
            coordinator?.gotoHomeNextWord(dataTransferDTO)
        }
    }
    
}
