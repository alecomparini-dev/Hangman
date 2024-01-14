//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

import Domain

public struct MapperDictDollsToListDollUseCaseDTO {
    
    public static func mapper(_ dictDolls: [Dictionary<String,Any>]? ) -> [DollUseCaseDTO]? {
        guard let dictDolls else { return nil }
        
        return dictDolls.map({ doll in
            return DollUseCaseDTO(
                head: doll["head"] as? [String],
                body: doll["body"] as? [String],
                success: doll["success"] as? [String],
                fail: doll["fail"] as? [String]
            )
        })
    }
    
}
