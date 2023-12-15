//  Created by Alessandro Comparini on 15/12/23.
//


import UIKit
import CustomComponentsSDK

class StackView: StackViewBuilder {
    
    override init() {
        super.init()
        configure()
    }
    
    lazy var gallowsToStack: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var wordsToStack: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var keyboardToStack: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configStackView()
        configElements()
     }

    private func configStackView() {
        self
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fill)
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
    }
    
    private func configElements() {
        gallowsToStack.add(insideTo: self.get)
        wordsToStack.add(insideTo: self.get)
        keyboardToStack.add(insideTo: self.get)
    }
    
}
