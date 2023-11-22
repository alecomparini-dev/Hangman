//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

class HangmanWordView: ViewBuilder {
    
    private let spacingHorizontal: CGFloat = 4
    private let spacingVertical: CGFloat = 0
    
    override init() {
        super.init()
        configure()
    }
    
    
    //  MARK: - LAZY Area
    lazy var stackView: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.center)
            .setSpacing(spacingVertical)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setTop.setTrailing.setLeading.equalToSuperView
                    .setBottom.equalToSuperView(-6)
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


//  MARK: - PUBLIC AREA
    func resetStackView() {
        for subview in horizontalStack1.get.subviews {
            subview.removeFromSuperview()
        }
        
        for subview in horizontalStack2.get.subviews {
            subview.removeFromSuperview()
        }
        
        horizontalStack2.setHidden(true)
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        addStacks()
    }
    
    private func addStacks() {
        stackView.add(insideTo: self.get)
        horizontalStack1.add(insideTo: stackView.get)
        horizontalStack2.add(insideTo: stackView.get)
    }
    
    private func configConstraints() {
        stackView.applyConstraint()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//  MARK: - RETIRAR DAQUI E PASSAR PARA VIEWCONTROLLER OU ATÉ MESMO PRESENTER
    
    
    func revealLetterInWord(_ letter: HangmanLetterInWordView, _ color: UIColor = Theme.shared.currentTheme.primary) {
        configLetterForAnimation(letter, color)
        revealLetterInWordAnimation(letter)
    }
    
    private func configLetterForAnimation(_ letter: HangmanLetterInWordView, _ color: UIColor = Theme.shared.currentTheme.primary) {
        letter.label.setHidden(false)
        letter.label.setAlpha(0)
//        letter.underlineLetter.gradient?.setReferenceColor(color, percentageGradient: -20)
//            .apply()
        letter.underlineLetter.setAlpha(0)
    }
    
    private func revealLetterInWordAnimation(_ letter: HangmanLetterInWordView) {
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            letter.label.get.alpha = 1
            letter.underlineLetter.get.alpha = 1
        })
    }
    
}
