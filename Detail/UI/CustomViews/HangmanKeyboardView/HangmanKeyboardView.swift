//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Handler

protocol HangmanKeyboardViewDelegate: AnyObject {
    func letterButtonTapped(_ button: UIButton)
    func moreTipTapped()
}

class HangmanKeyboardView: ViewBuilder {
    weak var delegate: HangmanKeyboardViewDelegate?
    
    private let spacingVertical: CGFloat = 10
    private let spacingHorizontal: CGFloat = 12
    
    private var lettersKeyboard: [String]
    
    init(_ lettersKeyboard: [String]) {
        self.lettersKeyboard = lettersKeyboard
        super.init(frame: .zero)
        configure()
    }
    
    
//  MARK: - LAZY Area

    lazy var verticalStack: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.fill)
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
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var leftHorizontalStack1: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var rightHorizontalStack1: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack2: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack3: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack4: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var horizontalStack5: StackViewBuilder = {
        let stack = StackViewBuilder()
            .setAxis(.horizontal)
            .setAlignment(.fill)
            .setSpacing(spacingHorizontal)
            .setDistribution(.fillEqually)
        return stack
    }()
    
    lazy var space: ViewBuilder = {
        let btn = ViewBuilder()
        return btn
    }()
    

//  MARK: - LAZY MORE TIP
    lazy var moreTipButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(systemName: K.Images.moreTipButton).setContentMode(.center)
        var comp = createButtonDefault(K.String.tips)
            .setImageButton(img)
            .setImagePlacement(.trailing)
            .setImageSize(12)
        addNeumorphismDefault(comp, color: Theme.shared.currentTheme.secondary)
        comp.get.addTarget(self, action: #selector(moreTipTapped), for: .touchUpInside)
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        addStackElements()
        addLetterToHorizontalStacks()
        addSpaceToLeftHorizontalStack1()
        addHintToRightHorizontalStack1()
    }
    
    private func addStackElements() {
        verticalStack.add(insideTo: self.get)
        horizontalStack5.add(insideTo: verticalStack.get)
        horizontalStack4.add(insideTo: verticalStack.get)
        horizontalStack3.add(insideTo: verticalStack.get)
        horizontalStack2.add(insideTo: verticalStack.get)
        horizontalStack1.add(insideTo: verticalStack.get)
        leftHorizontalStack1.add(insideTo: horizontalStack1.get)
        rightHorizontalStack1.add(insideTo: horizontalStack1.get)
    }
    
    private func addSpaceToLeftHorizontalStack1() {
        space.add(insideTo: leftHorizontalStack1.get)
    }

    private func addHintToRightHorizontalStack1() {
        moreTipButton.add(insideTo: rightHorizontalStack1.get)
    }
    
    private func configConstraints() {
        verticalStack.applyConstraint()
    }
    
    private func addLetterToHorizontalStacks() {
        lettersKeyboard.enumerated().forEach { index,letter in
            switch index {
                case 0...5:
                    addLetterToHorizontalStack(letter, stack: horizontalStack5)
                
                case 6...11:
                    addLetterToHorizontalStack(letter, stack: horizontalStack4)

                case 12...17:
                    addLetterToHorizontalStack(letter, stack: horizontalStack3)

                case 18...23:
                    addLetterToHorizontalStack(letter, stack: horizontalStack2)

                case 24...25:
                    addLetterToHorizontalStack(letter, stack: leftHorizontalStack1)
                    
                default:
                    break
            }
        }
    }
    
    private func addLetterToHorizontalStack(_ letter: String, stack: StackViewBuilder) {
        if let letterButton = createButtonLetter(title: letter) {
            letterButton.add(insideTo: stack.get)
        }
    }
    
    private func createButtonLetter(title: String) -> ButtonImageBuilder? {
        let buttonDefault = createButtonDefault(title)
        addNeumorphismDefault(buttonDefault, color: Theme.shared.currentTheme.surfaceContainer)
        buttonDefault.get.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
        return buttonDefault
    }
    
    private func createButtonDefault(_ title: String) -> ButtonImageBuilder {
        return ButtonImageBuilder()
            .setTag(K.Keyboard.letter[title.uppercased()] ?? 0)
            .setTitle(title)
            .setTitleAlignment(.center)
            .setTitleColor(Theme.shared.currentTheme.onSurface)
            .setTintColor(Theme.shared.currentTheme.onSurface.adjustBrightness(-20))
            .setTitleSize(16)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
    }
    
    private func addNeumorphismDefault(_ component: ButtonImageBuilder, color: UIColor) {
        _ = NeumorphismBuilder(component)
            .setReferenceColor(color)
            .setShape(.concave)
            .setLightPosition(.leftTop)
            .setIntensity(to: .light, percent: 100)
            .setIntensity(to: .dark, percent: 80)
            .setBlur(to: .light, percent: 3)
            .setBlur(to: .dark, percent: 5)
            .setDistance(to: .light, percent: 3)
            .setDistance(to: .dark, percent: 10)
            .apply()
    }
    


//  MARK: - OBJEC FUNCTIONS AREA
    @objc private func moreTipTapped() {
        delegate?.moreTipTapped()
    }
    
    @objc private func letterButtonTapped(_ button: UIButton) {
        delegate?.letterButtonTapped(button)
    }
    
}

