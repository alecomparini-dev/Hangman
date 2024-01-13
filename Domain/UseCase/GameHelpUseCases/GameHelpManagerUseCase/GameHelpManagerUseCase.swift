//  Created by Alessandro Comparini on 12/01/24.
//

import Foundation


public protocol GameHelpManagerUseCase {
    func fetch() async throws
    func renewFreeHelp() async throws
}
