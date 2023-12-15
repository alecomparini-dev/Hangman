//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK
import Handler

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

    lazy var stackView: StackView = {
        let comp = StackView()
        return comp
    }()
    
    lazy var scoreView: ScoreView = {
        let comp = ScoreView()
            .setConstraints { build in
                build
                    .setPinTop.equalToSafeArea
                    .setHeight.equalToConstant(50)
            }
        return comp
    }()
    
    lazy var painelGallowsView: PainelGallowsView = {
        let comp = PainelGallowsView(scoreView.get)
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
                    .setVerticalAlignmentY.equalTo(painelGallowsView.painelView.get)
                    .setTrailing.equalTo(painelGallowsView.painelView.get, .trailing, -14)
                    .setWidth.equalToConstant(50)
                    .setHeight.equalToConstant(35)
            }
        comp.get.addTarget(self, action: #selector(nextWordButtonTapped), for: .touchUpInside)
        return comp
    }()
    
    lazy var gallowsView: GallowsView = {
        let comp = GallowsView(frame: .zero)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(13)
                    .setBottom.equalToSuperView(-18)
                    .setLeading.setTrailing.equalToSuperView
            }
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
                    .setBottom.equalTo(hangmanWordView.get, .top, -4)
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
    
    lazy var hangmanWordView: HangmanWordView = {
        let view = HangmanWordView()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest.withAlphaComponent(0.1))
            .setBorder { build in
                build.setCornerRadius(8)
            }
            .setConstraints { build in
                build
                    .setBottom.equalTo(stackView.keyboardToStack.get, .top, -8)
                    .setLeading.setTrailing.equalToSuperView(24)
                    .setHeight.equalToConstant(80)
            }
        return view
    }()
    
    lazy var quantityLettersView: QuantityLettersView = {
        let comp = QuantityLettersView(hangmanWordView.get)
        return comp
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
        addGallowsView()
        nextWordButton.add(insideTo: self)
        categoryLabel.add(insideTo: stackView.wordsToStack.get)
        initialQuestionView.add(insideTo: stackView.wordsToStack.get)
        initialQuestionLabel.add(insideTo: initialQuestionView.get)
        addGallowsWordView()
        gallowsKeyboardView.add(insideTo: stackView.keyboardToStack.get)
    }
    
    private func addStackViewElements() {
        stackView.add(insideTo: self)
        scoreView.add(insideTo: stackView.gallowsToStack.get)
        painelGallowsView.add(insideTo: stackView.gallowsToStack.get)
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
        gallowsView.add(insideTo: painelGallowsView.painelView.get)
    }
    
    private func addGallowsWordView() {
        hangmanWordView.add(insideTo: stackView.wordsToStack.get)
        quantityLettersView.add(insideTo: stackView.wordsToStack.get)
    }
    
    private func configStackViewConstraints() {
        scoreView.applyConstraint()
        painelGallowsView.applyConstraint()
        stackView.gallowsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.40).isActive = true
        stackView.wordsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.24).isActive = true
        stackView.keyboardToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.36).isActive = true
        stackView.applyConstraint()
    }
    
    public func configGallowsWordViewContraints() {
        hangmanWordView.applyConstraint()
        quantityLettersView.applyConstraint()
    }
    
    
}

