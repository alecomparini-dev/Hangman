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
        
        
        let dataProvider = FirebaseStorageProvider(collection: "users")
        
        //MARK: - CountWordsPlayedUseCaseImpl
        let dataStorageMain = DataStorageMain(dataProvider: dataProvider)
        
        let fetchCountDataStorage = HangmanDataStorageSDK(dataStorage: dataStorageMain)
        
        let countWordsPlayedGateway = CountWordsPlayedUseCaseGatewayImpl(fetchCountDataStorage: fetchCountDataStorage)
        
        let countWordsPlayedUseCase = CountWordsPlayedUseCaseImpl(countWordsPlayedGateway: countWordsPlayedGateway)
        
        
        //MARK: - saveWordPlayedUseCase
        let insertDataStorage = HangmanDataStorageSDK(dataStorage: dataStorageMain)
        
        let saveWordPlayedGateway = SaveWordPlayedUseCaseGatewayImpl(insertDataStorage: insertDataStorage)
        
        let saveWordPlayedUseCase = SaveWordPlayedUseCaseImpl(saveWordPlayedGateway: saveWordPlayedGateway)
        
        
        //MARK: - countDollsUseCase

        let dataProviderDolls = FirebaseStorageProvider(collection: "dolls")
        
        let dataStorageMainDolls = DataStorageMain(dataProvider: dataProviderDolls)
        
        let fetchCountDataStorageDolls = HangmanDataStorageSDK(dataStorage: dataStorageMainDolls)
        
        let countModelGateway = GenericCountModelGatewayImpl(fetchCountDataStorage: fetchCountDataStorageDolls)
        
        let countDollsUseCase = CountDollsUseCaseImpl(countModelGateway: countModelGateway)
        
        let homePresenter = HomePresenterImpl(signInAnonymousUseCase: signInAnonymousUseCase,
                                              getNextWordsUseCase: getNextWordsUseCase, 
                                              countWordsPlayedUseCase: countWordsPlayedUseCase, 
                                              saveWordPlayedUseCase: saveWordPlayedUseCase, 
                                              countDollsUseCase: countDollsUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
