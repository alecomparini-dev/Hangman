//  Created by Alessandro Comparini on 24/01/24.
//

import Foundation
import Domain

struct DollUseCaseDTOFactory {
    
    static func make() -> DollUseCaseDTO {
        return DollUseCaseDTO(head: ["head1","head2"],
                              body: ["body1","body2","body3","body4","body5"],
                              success: ["dollSuccess"],
                              fail: ["dollFail"])
        
    }
    
    static func toJSON() -> [String: Any] {
        return [
            "head": ["head1","head2"],
            "body": ["body1","body2","body3","body4","body5"],
            "success": ["dollSuccess"],
            "fail": ["dollFail"]
        ]
    }
    
}
