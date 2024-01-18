//  Created by Alessandro Comparini on 17/01/24.
//

import Foundation

public protocol GameHelpPresenterOutput {
    
    func fetchGameHelpSuccess(_ gameHelpPresenterDTO: GameHelpPresenterDTO?)
    func fetchGameHelpError(title: String, message: String)
    
    func updateGameHelpSuccess()
    func updateGameHelpError(title: String, message: String)
    
    
    
}
