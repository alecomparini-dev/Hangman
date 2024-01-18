//  Created by Alessandro Comparini on 18/12/23.
//

import Foundation

public protocol HintsPresenter {
    var delegateOutput: HintsPresenterOutput? { get set }
    
    var dataTransfer: DataTransferHints? { get set }
    
    func numberOfItemsCallback() -> Int
    
    func getHintByIndex(_ index: Int) -> String
    
    func openHint(indexHint: Int?)
    
    func verifyHintIsOver()
    
}
