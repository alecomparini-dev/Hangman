//  Created by Alessandro Comparini on 16/01/24.
//

import Foundation
import Domain
import Handler

struct GameHelpCodable: Codable {
    var dateRenewFree: String?
    var hints: Int?
    var lives: Int?
    var revelations: Int?
    
    
    static func mapper(_ gameHelpModel: GameHelpModel) -> Self {
        let date = DateHandler.separateDate(gameHelpModel.dateRenewFree?.description ?? Date().description)
        let dateRenewFree = "\(date.year)-\(date.month)-\(date.day)"
        
        return GameHelpCodable(
            dateRenewFree: dateRenewFree,
            hints: gameHelpModel.typeGameHelp?.hints,
            lives: gameHelpModel.typeGameHelp?.lives,
            revelations: gameHelpModel.typeGameHelp?.revelations)
    }
    
    
}
