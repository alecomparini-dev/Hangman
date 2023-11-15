//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

protocol HangmanKeyboardViewDelegate: AnyObject {
    func moreTipTapped()
}

class HangmanKeyboardView: ViewBuilder {
    weak var delegate: HangmanKeyboardViewDelegate?
    
    private let sizeLetter: CGFloat = 16
    private let spacingVertical: CGFloat = 10
    private let spacingHorizontal: CGFloat = 12
    private let lettersOfKeyboard: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",""]
    private var letterViewOfKeyboard: [HangmanKeyboardLetterView] = []
    
    override init() {
        super.init()
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
    lazy var moreTipButton: DefaultViewButton = {
        let img = ImageViewBuilder(systemName: "lightbulb.fill")
        let comp = DefaultViewButton(Theme.shared.currentTheme.secondary, String(repeating: " ", count: 8) + "Dicas")
        comp.button.setTitleColor(Theme.shared.currentTheme.onSurface)
            .setImageButton(img)
            .setImageSize(12)
            .setTitleAlignment(.left)
            .setTitleSize(sizeLetter)
        comp.button.get.addTarget(self, action: #selector(moreTipTapped), for: .touchUpInside)
        comp.button.get.imageEdgeInsets = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        return comp
    }()
    
    @objc private func moreTipTapped() {
        delegate?.moreTipTapped()
    }
    
    
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
    
    private func addLetterToHorizontalStacks() {
        lettersOfKeyboard.enumerated().forEach { index,letter in
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
        let letterView = createGallowsLetterView(letter)
        letterView.add(insideTo: stack.get)
        self.letterViewOfKeyboard.append(letterView)
    }
    
    private func createGallowsLetterView(_ text: String) -> HangmanKeyboardLetterView {
        let letter = HangmanKeyboardLetterView(text, Theme.shared.currentTheme.surfaceContainer)
        letter.gallowsLetter.button.setTitleSize(sizeLetter)
        return letter
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
    
}

