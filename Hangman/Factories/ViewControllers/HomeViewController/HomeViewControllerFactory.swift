//  Created by Alessandro Comparini on 18/11/23.
//

import UIKit

import AuthenticationSDKMain
import Detail
import Domain
import Presenter
import UseCaseGateway
import DataStorageSDKMain


class HomeViewControllerFactory: UIViewController {
    
    static func make() -> HomeViewController {
        
        let fetchAtIDDataStorage = HangmanFirebaseDataStorageProvider(collection: "hangmanWords")
        
        let nextWordsGateway = DataStorageFetchAtIDNexWordsUseCaseGatewayImpl(fetchAtIDDataStorage: fetchAtIDDataStorage)
        
        let getNextWordsUseCase = GetNextWordsUseCaseImpl(nextWordsGateway: nextWordsGateway)
        
        let authMain = AuthenticationMain()
        
        let authAnonymousProvider = HangmanAuthenticationSDK(authenticateMain: authMain)
        
        let signInAnonymousGateway = SignInAnonymousUseCaseGatewayImpl(signInAnonymousProvider: authAnonymousProvider)
        
        let signInAnonymousUseCase = SignInAnonymousUseCaseImpl(signInAnonymousGateway: signInAnonymousGateway)
        
        
        let usersFirebaseDataProvider = FirebaseDataStorageProvider(collection: "users")
        
        let usersDataStorageSDK = HangmanDataStorageSDK(dataStorage: usersFirebaseDataProvider)
        
        //MARK: - CountWordsPlayedUseCaseImpl
        
        let countWordsPlayedGateway = CountWordsPlayedUseCaseGatewayImpl(fetchCountDataStorage: usersDataStorageSDK)
        
        let countWordsPlayedUseCase = CountWordsPlayedUseCaseImpl(countWordsPlayedGateway: countWordsPlayedGateway)
        
        
        //MARK: - saveWordPlayedUseCase
        
        let saveWordPlayedGateway = SaveWordPlayedUseCaseGatewayImpl(insertDataStorage: usersDataStorageSDK)
        
        let saveWordPlayedUseCase = SaveWordPlayedUseCaseImpl(saveWordPlayedGateway: saveWordPlayedGateway)
        
        
        //MARK: - countDollsUseCase

        let dataProviderDolls = FirebaseDataStorageProvider(collection: "dolls")
                
        let fetchDataStorageDolls = HangmanDataStorageSDK(dataStorage: dataProviderDolls)
        
        let countModelGateway = GenericCountModelGatewayImpl(fetchCountDataStorage: fetchDataStorageDolls)
        
        let countDollsUseCase = CountDollsUseCaseImpl(countModelGateway: countModelGateway)
        
        
        //MARK: - getDollsRandomUseCase

        let fetchInDataStorage = HangmanFirebaseDataStorageProvider(collection: "dolls")
          
        let getDollsGateway = GetDollsUseCaseGatewayImpl(fetchInDataStorage: fetchInDataStorage)
        
        let getDollsRandomUseCase = GetDollsRandomUseCaseImpl(countDollsUseCase: countDollsUseCase,
                                                              getDollsGateway: getDollsGateway)
        
        
        //MARK: - fetchGameHelpUseCase
        
        let fetchGameHelpGateway = FetchGameHelpUseCaseGatewayImpl(fetchDataStorage: usersDataStorageSDK)
        
        let fetchGameHelpUseCase = FetchGameHelpUseCaseImpl(fetchGameHelpGateway: fetchGameHelpGateway)
        
        let homePresenter = HomePresenterImpl(signInAnonymousUseCase: signInAnonymousUseCase,
                                              getNextWordsUseCase: getNextWordsUseCase, 
                                              countWordsPlayedUseCase: countWordsPlayedUseCase, 
                                              saveWordPlayedUseCase: saveWordPlayedUseCase,
                                              getDollsRandomUseCase: getDollsRandomUseCase, 
                                              fetchGameHelpUseCase: fetchGameHelpUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
