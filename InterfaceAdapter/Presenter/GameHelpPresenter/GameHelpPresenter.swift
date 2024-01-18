//  Created by Alessandro Comparini on 17/01/24.
//

import Foundation
import Domain

public enum TypeGameHelp {
    case lives
    case hints
    case revelations
}

public protocol GameHelpPresenter {
    var delegateOutput: GameHelpPresenterOutput? { get set }
    
    func update(_ userID: String, _ gameHelpModel: GameHelpModel)
    
    func fetch(_ userID: String)
    
    func maxHelp(_ typeGameHelp: TypeGameHelp) -> Int

}
