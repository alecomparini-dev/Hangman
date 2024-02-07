//  Created by Alessandro Comparini on 13/01/24.
//

import Foundation
import Domain
import Handler


struct FetchGameHelpCodable: Codable {
    var dateRenewFree: String?
    var lives: Int?
    var hints: Int?
    var revelations: Int?
    
    
    func mapperToGameHelp() -> GameHelpModel {
        return GameHelpModel(
            dateRenewFree: convertDateRenew(self.dateRenewFree) ,
            typeGameHelp: TypeGameHelpModel(
                lives: self.lives,
                hints: self.hints,
                revelations: self.revelations)
            )
    }
    
    //  MARK: - PRIVATE AREA
    private func convertDateRenew(_ date: String?) -> Date? {
        guard let date else {return nil }
        return DateHandler.convertDate(date)
    }
    
}

