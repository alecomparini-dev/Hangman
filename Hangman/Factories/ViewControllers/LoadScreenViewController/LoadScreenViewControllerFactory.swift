//
//  LoadScreenViewController.swift
//  Hangman
//
//  Created by Alessandro Comparini on 15/01/24.
//

import UIKit
import Domain
import Presenter
import Detail

class LoadScreenViewControllerFactory: UIViewController {
    
    static func make() -> LoadScreenViewController {
        
        let signInAnonymousUseCase = SignInAnonymousUseCaseFactory.make()
        
        let loadScreenPresenter = LoadScreenPresenter(signInAnonymousUseCase: signInAnonymousUseCase)
        
        return LoadScreenViewController(loadScreenPresenter: loadScreenPresenter)
        
    }
    
}
