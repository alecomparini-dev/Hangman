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
        
        let signInAnonymousUseCase = SignInAnonymousUseCaseFactory.make()
        
        let firebaseProvider = FirebaseDataStorageProvider()
        
        let dataStorageSDK = HangmanDataStorageSDK(dataStorage: firebaseProvider)
        
        
        //MARK: - CountWordsPlayedUseCaseImpl
        
        let countWordsPlayedGateway = CountWordsPlayedUseCaseGatewayImpl(fetchCountDataStorage: dataStorageSDK)
        
        let countWordsPlayedUseCase = CountWordsPlayedUseCaseImpl(countWordsPlayedGateway: countWordsPlayedGateway)
        
        
        //MARK: - saveWordPlayedUseCase
        
        let saveWordPlayedGateway = SaveWordPlayedUseCaseGatewayImpl(insertDataStorage: dataStorageSDK)
        
        let saveWordPlayedUseCase = SaveWordPlayedUseCaseImpl(saveWordPlayedGateway: saveWordPlayedGateway)
        
        
        //MARK: - countDollsUseCase
                        
        let countModelGateway = GenericCountModelGatewayImpl(fetchCountDataStorage: dataStorageSDK)
        
        let countDollsUseCase = CountDollsUseCaseImpl(countModelGateway: countModelGateway)
        
        
        //MARK: - getDollsRandomUseCase

        let fetchInDataStorage = HangmanFirebaseDataStorageProvider(collection: "dolls")
          
        let getDollsGateway = GetDollsUseCaseGatewayImpl(fetchInDataStorage: fetchInDataStorage)
        
        let getDollsRandomUseCase = GetDollsRandomUseCaseImpl(countDollsUseCase: countDollsUseCase,
                                                              getDollsGateway: getDollsGateway)
        
        
        //MARK: - fetchGameHelpUseCase
        
        let fetchGameHelpGateway = FetchGameHelpUseCaseGatewayImpl(fetchDataStorage: dataStorageSDK)
        
        let saveGameHelpGateway = SaveGameHelpUseCaseGatewayImpl(insertDataStorage: dataStorageSDK)
        
        
        let maxGameHelpUseCase = MaxGameHelpUseCaseImpl()
        
        let fetchGameHelpUseCase = FetchGameHelpUseCaseImpl(fetchGameHelpGateway: fetchGameHelpGateway,
                                                            saveGameHelpGateway: saveGameHelpGateway, 
                                                            maxGameHelpUseCase: maxGameHelpUseCase)
        
            
        let homePresenter = HomePresenterImpl(signInAnonymousUseCase: signInAnonymousUseCase,
                                              getNextWordsUseCase: getNextWordsUseCase, 
                                              countWordsPlayedUseCase: countWordsPlayedUseCase, 
                                              saveWordPlayedUseCase: saveWordPlayedUseCase,
                                              getDollsRandomUseCase: getDollsRandomUseCase, 
                                              fetchGameHelpUseCase: fetchGameHelpUseCase, 
                                              maxGameHelpUseCase: maxGameHelpUseCase)
        
        return HomeViewController(homePresenter: homePresenter)
        
    }
    
}
