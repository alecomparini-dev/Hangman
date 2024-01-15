//
//  asdf.swift
//  Hangman
//
//  Created by Alessandro Comparini on 15/01/24.
//

import Foundation

import AuthenticationSDKMain
import Domain
import UseCaseGateway
import DataStorageSDKMain
import Detail

class SignInAnonymousUseCaseFactory {
 
    static func make() -> SignInAnonymousUseCaseImpl {
        
        let authMain = AuthenticationMain()
        
        let authAnonymousProvider = HangmanAuthenticationSDK(authenticateMain: authMain)
        
        let signInAnonymousGateway = SignInAnonymousUseCaseGatewayImpl(signInAnonymousProvider: authAnonymousProvider)
        
        return SignInAnonymousUseCaseImpl(signInAnonymousGateway: signInAnonymousGateway)
        
    }
    
}
