//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

protocol HangmanViewDelegate: AnyObject {
    func nextWordButtonTapped()
}


class HomeView: UIView {
    weak var delegate: HangmanViewDelegate?
    
    private let lettersKeyboard: [String]
    
    init(_ lettersKeyboard: [String]) {
        self.lettersKeyboard = lettersKeyboard
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY PROPERTIES
    
    lazy var backgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return comp
    }()

    lazy var stackView: StackViewBuilder = {
        let comp = StackViewBuilder()
            .setAxis(.vertical)
            .setAlignment(.fill)
            .setDistribution(.fill)
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return comp
    }()
    
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

    lazy var scoreView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setPinTop.equalToSafeArea
                    .setHeight.equalToConstant(50)
            }
        return comp
    }()
    
    lazy var painelView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalTo(scoreView.get, .bottom)
                    .setLeading.setTrailing.equalTo(scoreView.get)
                    .setBottom.equalToSafeArea
            }
        return comp
    }()
    
    lazy var painelGallowsView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 100)
                    .setIntensity(to: .dark, percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 10)
                    .setDistance(to: .light, percent: 8)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setLeading.equalToSafeArea(32)
                    .setTrailing.equalToSafeArea(-27)
                    .setHeight.equalToConstant(200)
                    .setVerticalAlignmentY.equalTo(painelView.get)
            }
        return comp
    }()
    
    lazy var nextWordButton: ButtonImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: K.Images.nextWordButton))
        let comp = ButtonImageBuilder(img)
            .setHidden(false)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageSize(22)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(painelGallowsView.get)
                    .setTrailing.equalTo(painelGallowsView.get, .trailing, -14)
                    .setWidth.equalToConstant(50)
                    .setHeight.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(nextWordButtonTapped), for: .touchUpInside)
        return comp
    }()
    
    lazy var gallowsView: GallowsView = {
        let comp = createHangmanGallowsView()
        return comp
    }()
    
    
//  MARK: - CATEGORY and INITIAL QUESTION
    lazy var categoryLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setSize(20)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(4)
                    .setLeading.setTrailing.equalToSuperView(16)
            }
        return comp
    }()
    
    lazy var initialQuestionView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalTo(categoryLabel.get, .bottom)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setBottom.equalTo(gallowsWordView.get, .top, -4)
            }
        return comp
    }()
    
    lazy var initialQuestionLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setSize(14)
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
                    .setAlignmentCenterXY.equalToSuperView
            }
        return comp
    }()
    
    
    //  MARK: - DISCOVERY WORD
    
    lazy var quantityLettersView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder { build in
                build
                    .setCornerRadius(8)
            }
            .setGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            }
            .setShadow { build in
                build
                    .setColor(.black)
                    .setRadius(5)
                    .setOpacity(1)
                    .setOffset(width: 3, height: 3)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(gallowsWordView.get, .bottom, 10)
                    .setTrailing.equalTo(gallowsWordView.get, .trailing, 10)
                    .setWidth.equalToConstant(40)
                    .setHeight.equalToConstant(22)
            }
        return comp
    }()
    
    lazy var quantityLettersLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setSize(12)
            .setWeight(.regular)
            .setColor(Theme.shared.currentTheme.onPrimary)
            .setTextAlignment(.center)
            .setConstraints { build in
                build.setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var gallowsWordView: HangmanWordView = {
        let view = createHangmanWordView()
        return view
    }()
    
    
    //  MARK: - KEYBOARD
    lazy var gallowsKeyboardView: HangmanKeyboardView = {
        let comp = HangmanKeyboardView(lettersKeyboard)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setBottom.equalToSafeArea(-16)
                    .setLeading.setTrailing.equalToSafeArea(24)
            }
        return comp
    }()
    
    
//  MARK: - @OBJC Area
    @objc private func nextWordButtonTapped() {
        delegate?.nextWordButtonTapped()
    }

    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        addStackViewElements()
        painelGallowsView.add(insideTo: painelView.get)
        addGallowsView()
        nextWordButton.add(insideTo: self)
        categoryLabel.add(insideTo: wordsToStack.get)
        initialQuestionView.add(insideTo: wordsToStack.get)
        initialQuestionLabel.add(insideTo: initialQuestionView.get)
        addGallowsWordView()
        gallowsKeyboardView.add(insideTo: keyboardToStack.get)
    }
    
    private func addStackViewElements() {
        stackView.add(insideTo: self)
        scoreView.add(insideTo: gallowsToStack.get)
        painelView.add(insideTo: gallowsToStack.get)
        gallowsToStack.add(insideTo: stackView.get)
        wordsToStack.add(insideTo: stackView.get)
        keyboardToStack.add(insideTo: stackView.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        configStackViewConstraints()
        painelGallowsView.applyConstraint()
        gallowsView.applyConstraint()
        nextWordButton.applyConstraint()
        categoryLabel.applyConstraint()
        initialQuestionView.applyConstraint()
        initialQuestionLabel.applyConstraint()
        configGallowsWordViewContraints()
        gallowsKeyboardView.applyConstraint()
    }
    
    private func addGallowsView() {
        gallowsView.add(insideTo: painelGallowsView.get)
    }
    
    private func addGallowsWordView() {
        gallowsWordView.add(insideTo: wordsToStack.get)
        quantityLettersView.add(insideTo: wordsToStack.get)
        quantityLettersLabel.add(insideTo: quantityLettersView.get)
    }
    
    private func configStackViewConstraints() {
        scoreView.applyConstraint()
        painelView.applyConstraint()
        gallowsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.40).isActive = true
        wordsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.24).isActive = true
        keyboardToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.36).isActive = true
        stackView.applyConstraint()
    }
    
    public func configGallowsWordViewContraints() {
        gallowsWordView.applyConstraint()
        quantityLettersView.applyConstraint()
        quantityLettersLabel.applyConstraint()
    }
    
    private func createHangmanGallowsView() -> GallowsView {
        let view = GallowsView(frame: .zero)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(13)
                    .setBottom.equalToSuperView(-18)
                    .setLeading.setTrailing.equalToSuperView
            }
        return view
    }

    private func createHangmanWordView() -> HangmanWordView {
        let view = HangmanWordView()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest.withAlphaComponent(0.1))
            .setBorder { build in
                build.setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(keyboardToStack.get, .top, -8)
                    .setLeading.setTrailing.equalToSuperView(24)
                    .setHeight.equalToConstant(80)
            }
        return view
    }
    
}

