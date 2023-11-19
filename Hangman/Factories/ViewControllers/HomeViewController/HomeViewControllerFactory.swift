//  Created by Alessandro Comparini on 18/11/23.
//

import UIKit

import AuthenticationSDKMain
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
        
        let authMain = AuthenticationMain()
        
        let authAnonymousProvider = HangmanAuthenticationSDK(authenticateMain: authMain)
        
        let signInAnonymousGateway = SignInAnonymousUseCaseGatewayImpl(signInAnonymousProvider: authAnonymousProvider)
        
        let signInAnonymousUseCase = SignInAnonymousUseCaseImpl(signInAnonymousGateway: signInAnonymousGateway)
        
        let homePresenter = HomePresenterImpl(signInAnonymousUseCase: signInAnonymousUseCase,
                                              getNextWordsUseCase: getNextWordsUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
