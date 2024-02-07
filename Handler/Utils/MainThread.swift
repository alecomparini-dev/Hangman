//  Created by Alessandro Comparini on 27/11/23.
//

import Foundation

public struct MainThread {
    
    public static func exec(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
            return
        }
        
        DispatchQueue.main.sync {
            completion()
        }
    }
    
}
