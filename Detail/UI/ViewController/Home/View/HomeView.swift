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
    
    lazy var gamePainelView: GamePainelView = {
        let comp = GamePainelView()
            .setConstraints { build in
                build
                    .setPinTop.equalToSafeArea
                    .setHeight.equalToConstant(50)
            }
        return comp
    }()
    
    lazy var painelGallowsView: PainelGallowsView = {
        let comp = PainelGallowsView(gamePainelView.get)
        return comp
    }()
    
    lazy var dropdownLifeView: DropdownLifeView = {
        let comp = DropdownLifeView()
            .setHidden(true)
            .setAlpha(0)
            .setConstraints { build in
                build
                    .setTop.equalTo(gamePainelView.get, .bottom)
                    .setPinBottom.equalToSuperView
            }
        return comp
    }()
    
    lazy var dropdownRevealLetterView: DropdownRevealLetterView = {
        let comp = DropdownRevealLetterView()
            .setAlpha(0)
            .setConstraints { build in
                build
                    .setTop.equalTo(gamePainelView.get, .bottom)
                    .setPinBottom.equalToSuperView
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
            .setSkeleton({ build in
                build
                    .setCornerRadius(8)
                    .setColorSkeleton(Theme.shared.currentTheme.surfaceContainerHigh)
            })
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(4)
                    .setHorizontalAlignmentX.equalToSuperView
                    .setHeight.equalToConstant(30)
                    .setWidth.greaterThanOrEqualToConstant(180)
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
            .setSkeleton({ build in
                build
                    .setCornerRadius(8)
                    .setColorSkeleton(Theme.shared.currentTheme.surfaceContainerHigh)
                    .setPadding(top: 12, left: 8, bottom: 8, rigth: 8)
            })
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
                    .setAlignmentCenterXY.equalToSuperView
            }
        return comp
    }()
    
    
    //  MARK: - DISCOVERY WORD
    
    lazy var revealingImage: ImageViewBuilder = {
        let img = UIImage(systemName: K.Images.eyeFill)
        let comp = ImageViewBuilder(img)
            .setAlpha(0)
            .setTintColor(Theme.shared.currentTheme.primary)
            .setSize(14)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setTop.setLeading.equalTo(hangmanWordView.get, -8)
            }
        return comp
    }()
    
    lazy var minusOneRevealLabel: LabelBuilder = {
        let comp = LabelBuilder("-1")
            .setAlpha(0)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setWeight(.semibold)
            .setSize(18)
            .setConstraints { build in
                build
                    .setTop.setTrailing.equalTo(revealingImage.get)
            }
        return comp
    }()
    
    lazy var hangmanWordView: HangmanWordView = {
        let view = HangmanWordView()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest.withAlphaComponent(0.1))
            .setBorder { build in
                build.setCornerRadius(8)
            }
            .setSkeleton({ build in
                build
                    .setColorSkeleton(Theme.shared.currentTheme.surfaceContainerLow.adjustBrightness(30))
            })
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
            .setSkeleton({ build in
                build
                    .setColorSkeleton(Theme.shared.currentTheme.tertiary)
            })
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
        configShowSkeleton()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        stackView.add(insideTo: self)
        gamePainelView.add(insideTo: stackView.gallowsToStack.get)
        painelGallowsView.add(insideTo: stackView.gallowsToStack.get)
        painelGallowsView.add(insideTo: stackView.gallowsToStack.get)
        gallowsView.add(insideTo: painelGallowsView.painelView.get)
        nextWordButton.add(insideTo: self)
        categoryLabel.add(insideTo: stackView.wordsToStack.get)
        initialQuestionView.add(insideTo: stackView.wordsToStack.get)
        initialQuestionLabel.add(insideTo: initialQuestionView.get)
        addGallowsWordView()
        gallowsKeyboardView.add(insideTo: stackView.keyboardToStack.get)
        dropdownLifeView.add(insideTo: self)
        dropdownRevealLetterView.add(insideTo: self)

    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        configStackViewConstraints()
        painelGallowsView.applyConstraint()
        dropdownLifeView.applyConstraint()
        dropdownRevealLetterView.applyConstraint()
        gallowsView.applyConstraint()
        nextWordButton.applyConstraint()
        categoryLabel.applyConstraint()
        initialQuestionView.applyConstraint()
        initialQuestionLabel.applyConstraint()
        configGallowsWordViewContraints()
        gallowsKeyboardView.applyConstraint()
    }
    
    private func configShowSkeleton() {
        categoryLabel.skeleton?.showSkeleton()
        initialQuestionLabel.skeleton?.showSkeleton()
        hangmanWordView.skeleton?.showSkeleton()
        quantityLettersView.skeleton?.showSkeleton()
    }
    
    
    private func addGallowsWordView() {
        hangmanWordView.add(insideTo: stackView.wordsToStack.get)
        revealingImage.add(insideTo: stackView.wordsToStack.get)
        minusOneRevealLabel.add(insideTo: stackView.wordsToStack.get)
        quantityLettersView.add(insideTo: stackView.wordsToStack.get)
    }
    
    public func configGallowsWordViewContraints() {
        hangmanWordView.applyConstraint()
        revealingImage.applyConstraint()
        minusOneRevealLabel.applyConstraint()
        quantityLettersView.applyConstraint()
    }
    
    private func configStackViewConstraints() {
        gamePainelView.applyConstraint()
        painelGallowsView.applyConstraint()
        stackView.gallowsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.40).isActive = true
        stackView.wordsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.24).isActive = true
        stackView.keyboardToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.36).isActive = true
        stackView.applyConstraint()
    }
    
    
    
    
}

