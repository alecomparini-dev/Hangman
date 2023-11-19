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
        
        
        let fetchAtIDDataStorage = FirebaseDataStorageProvider(collection: "hangmanWords")
        
        let nextWordsGateway = DataStorageFetchAtIDNexWordsUseCaseGatewayImpl(fetchAtIDDataStorage: fetchAtIDDataStorage)
        
        let getNextWordsUseCase = GetNextWordsUseCaseImpl(nextWordsGateway: nextWordsGateway)
        
        let homePresenter = HomePresenterImpl(getNextWordsUseCase: getNextWordsUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
