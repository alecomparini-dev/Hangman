//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

protocol HangmanViewDelegate: AnyObject {
    func closeWindow()
    func minimizeWindow()
    func nextWord()
}


class HomeView: UIView {
    weak var delegate: HangmanViewDelegate?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
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
                    .setIntensity(percent: 80)
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
        comp.get.addTarget(self, action: #selector(nextWord), for: .touchUpInside)
        return comp
    }()
    
    lazy var gallowsView: GallowsView = {
        let comp = createHangmanGallowsView()
        return comp
    }()
    
    lazy var tipDescriptionLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setText("Política")
            .setSize(18)
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(4)
                    .setLeading.setTrailing.equalToSuperView(16)
            }
        return comp
    }()
    
    lazy var gallowsWordView: HangmanWordView = {
        let view = createHangmanWordView()
        return view
    }()
    
    lazy var gallowsKeyboardView: HangmanKeyboardView = {
        let comp = HangmanKeyboardView()
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(8)
                    .setBottom.equalToSafeArea(-16)
                    .setLeading.setTrailing.equalToSafeArea(32)
            }
        return comp
    }()
    
    
//  MARK: - @OBJC Area
    @objc private func minimizeWindow() {
        delegate?.minimizeWindow()
    }
    
    @objc private func closeWindow() {
        delegate?.closeWindow()
    }
    
    @objc private func nextWord() {
        delegate?.nextWord()
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
        tipDescriptionLabel.add(insideTo: wordsToStack.get)
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
        tipDescriptionLabel.applyConstraint()
        configGallowsWordViewContraints()
        gallowsKeyboardView.applyConstraint()
    }
    
    private func addGallowsView() {
        gallowsView.add(insideTo: painelGallowsView.get)
    }
    
    private func addGallowsWordView() {
        gallowsWordView.add(insideTo: wordsToStack.get)
    }
    
    private func configStackViewConstraints() {
        scoreView.applyConstraint()
        painelView.applyConstraint()
        gallowsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.40).isActive = true
        wordsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.24).isActive = true
        keyboardToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.36).isActive = true
        stackView.applyConstraint()
    }
    
    private func configGallowsWordViewContraints() {
        gallowsWordView.applyConstraint()
    }

    
//  MARK: - PRIVATE Area
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
            .setConstraints { build in
                build
                    .setBottom.equalTo(keyboardToStack.get, .top, -8)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setHeight.equalToConstant(80)
            }
        return view
    }
    
}

