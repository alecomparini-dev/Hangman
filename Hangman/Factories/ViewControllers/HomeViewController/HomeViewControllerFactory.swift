//  Created by Alessandro Comparini on 18/11/23.
//

import UIKit

import Detail
import Domain
import Presenter
import UseCaseGateway
import DataStorageSDKMain
import DataStorageDetail

class HomeViewControllerFactory: UIViewController {
    
    static func make() -> HomeViewController {
        
        let dataProvider = FirebaseStorageProvider(collection: "hangmanWords" )
        
        let dataStorageSDK = DataStorageMain(dataProvider: dataProvider )
        
        let fetchStorageProvider = HangmanDataStorage(dataStorage: dataStorageSDK)
        
        let nextWordsGateway = FirebaseGetNexWordsUseCaseGatewayImpl(fetchStorageProvider: fetchStorageProvider)
        
        let getNextWordsUseCase = GetNextWordsUseCaseImpl(nextWordsGateway: nextWordsGateway)
        
        let homePresenter = HomePresenterImpl(getNextWordsUseCase: getNextWordsUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
