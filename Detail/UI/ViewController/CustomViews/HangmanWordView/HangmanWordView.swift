//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

class HangmanWordView: ViewBuilder {
    
    private let spacingHorizontal: CGFloat = 2
    private let spacingVertical: CGFloat = 0
    
    private var word: [String] = []
    
    override init() {
        super.init()
        configure()
        setBackgroundColor(.red)
    }
    
    
    //  MARK: - LAZY Area
    lazy var verticalStack: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.center)
            .setSpacing(spacingVertical)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return stack
    }()
    
    lazy var horizontalStack1: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(spacingHorizontal)
            .setDistribution(.equalCentering)
        return stack
    }()
    
    lazy var horizontalStack2: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setHidden(true)
            .setAxis(.horizontal)
            .setAlignment(.center)
            .setSpacing(spacingHorizontal)
            .setDistribution(.equalCentering)
        return stack
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    
    private func addElements() {
        addStacks()
    }
    
    private func addStacks() {
        verticalStack.add(insideTo: self.get)
        horizontalStack1.add(insideTo: verticalStack.get)
        horizontalStack2.add(insideTo: verticalStack.get)
    }
    
    private func configConstraints() {
        verticalStack.applyConstraint()
    }
    

    
}
