//  Created by Alessandro Comparini on 18/12/23.
//

import Foundation

public protocol HintsPresenter {
    var delegateOutput: HintsPresenterOutput? { get set }
    
    var dataTransfer: DataTransferHintsVC? { get set }
    
    func numberOfItemsCallback() -> Int
    
    func getHint(_ index: Int) -> String
    
    func revealHint()
    
    func saveHintOpen(_ index: Int )
}
