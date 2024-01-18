//  Created by Alessandro Comparini on 17/01/24.
//

import UIKit
import Detail
import Domain
import Presenter
import UseCaseGateway
import DataStorageSDKMain

class HintsViewControllerFactory: UIViewController {
    
    static func make(_ dataTransfer: DataTransferHints?) -> HintsViewController {
        
        let firebaseProvider = FirebaseDataStorageProvider()
        
        let dataStorageSDK = HangmanDataStorageSDK(dataStorage: firebaseProvider)
        
        let updateGameGateway =  UpdateGameHelpUseCaseGatewayImpl(updateDataStorage: dataStorageSDK)
        
        let updateGameHelpUseCase = UpdateGameHelpUseCaseImpl(updateGameGateway: updateGameGateway)
        
        let hintsPresenter = HintsPresenterImpl(updateGameHelpUseCase: updateGameHelpUseCase, 
                                                dataTransfer: dataTransfer)
        
        return HintsViewController(hintsPresenter: hintsPresenter )
    }
    
    
}
