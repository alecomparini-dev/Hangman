//  Created by Alessandro Comparini on 17/01/24.
//

import Foundation

public class UseGameHelpUseCaseImpl: UseGameHelpUseCase {
    
    
    private let updateGameHelpUseCase: UpdateGameHelpUseCase
    
    public init(updateGameHelpUseCase: UpdateGameHelpUseCase) {
        self.updateGameHelpUseCase = updateGameHelpUseCase
    }
    
    public func use(_ userID: String, _ typeGameHelp: TypeGameHelp) async throws {
        
    }
    

}
