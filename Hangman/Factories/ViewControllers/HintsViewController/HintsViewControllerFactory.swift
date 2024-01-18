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
        
        
        //MARK: - updateGameHelpUseCase
        
        let updateGameGateway =  UpdateGameHelpUseCaseGatewayImpl(updateDataStorage: dataStorageSDK)
        
        let updateGameHelpUseCase = UpdateGameHelpUseCaseImpl(updateGameGateway: updateGameGateway)
        
        
        //MARK: - getLastOpenHintsUseCase
        
        let getLastOpenHintsGateway = GetLastOpenHintsUseCaseGatewayImpl(fetchDataStorage: dataStorageSDK)
        
        let getLastOpenHintsUseCase = GetLastOpenHintsUseCaseImpl(getLastOpenHintsGateway: getLastOpenHintsGateway)

        let hintsPresenter = HintsPresenterImpl(updateGameHelpUseCase: updateGameHelpUseCase, 
                                                getLastOpenHintsUseCase: getLastOpenHintsUseCase,
                                                dataTransfer: dataTransfer)
        
        return HintsViewController(hintsPresenter: hintsPresenter )
    }
    
    
}
