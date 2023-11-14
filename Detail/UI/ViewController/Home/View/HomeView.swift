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
                    .setPin.equalToSuperView
            }
        return comp
    }()
    
    lazy var gallowsToStack: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(.red)
        return comp
    }()
    
    lazy var wordsToStack: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(.yellow)
        return comp
    }()
    
    lazy var keyboardToStack: ViewBuilder = {
        let comp = ViewBuilder()
            .setBackgroundColor(.cyan)
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
                    .setTop.equalToSafeArea(72)
                    .setLeading.equalToSafeArea(32)
                    .setTrailing.equalToSafeArea(-27)
                    .setHeight.equalToConstant(200)
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
            .setSize(22)
            .setColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setTextAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.equalTo(painelGallowsView.get, .bottom, 16)
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
                    .setHeight.equalToConstant(220)
                    .setLeading.setTrailing.setBottom.equalToSafeArea(24)
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
        
        painelGallowsView.add(insideTo: gallowsToStack.get)
        addGallowsView()
        
//        nextWordButton.add(insideTo: self)
//        tipDescriptionLabel.add(insideTo: self)
//        addGallowsWordView()
//        gallowsKeyboardView.add(insideTo: self)
    }
    
    private func addStackViewElements() {
        stackView.add(insideTo: self)
        
        gallowsToStack.add(insideTo: stackView.get)
        wordsToStack.add(insideTo: stackView.get)
        keyboardToStack.add(insideTo: stackView.get)
        
        gallowsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.35).isActive = true
        wordsToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.25).isActive = true
        keyboardToStack.get.heightAnchor.constraint(equalTo: stackView.get.heightAnchor, multiplier: 0.40).isActive = true
        
//        gallowsToStack.get.widthAnchor.constraint(equalTo: stackView.get.widthAnchor, multiplier: 0.35).isActive = true
//        wordsToStack.get.widthAnchor.constraint(equalTo: stackView.get.widthAnchor, multiplier: 0.25).isActive = true
//        keyboardToStack.get.widthAnchor.constraint(equalTo: stackView.get.widthAnchor, multiplier: 0.40).isActive = true
        
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        
        stackView.applyConstraint()
        
        painelGallowsView.applyConstraint()
        gallowsView.applyConstraint()
        
//        nextWordButton.applyConstraint()

//        tipDescriptionLabel.applyConstraint()
//        configGallowsWordViewContraints()
//        gallowsKeyboardView.applyConstraint()
    }
    
    private func addGallowsView() {
        gallowsView.add(insideTo: painelGallowsView.get)
    }
    
    private func addGallowsWordView() {
        gallowsWordView.add(insideTo: self)
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
                    .setTop.equalTo(painelGallowsView.get, .bottom, 45)
                    .setLeading.setTrailing.equalToSuperView(15)
                    .setHeight.equalToConstant(65)
            }
        return view
    }
    
}

