//  Created by Alessandro Comparini on 05/01/24.
//

import UIKit

import CustomComponentsSDK
import Handler

protocol DropdownRevelationsViewDelegate: AnyObject {
    func closeDropDownRevealLetter()
    func revealLetterButtonTapped(component: UIView)
}

class DropdownRevelationsView: ViewBuilder {
    weak var delegate: DropdownRevelationsViewDelegate?
    
    private let tagImage = 10
    private var eyes: [ViewBuilder]? = []
    
    override init() {
        super.init()
        configure()
        self.setHidden(true)
    }
    
    deinit {
        eyes = nil
    }

    
//  MARK: - LAZY AREA
    
    lazy var overlay: BlurBuilder = {
        let overlay = BlurBuilder(style: .dark)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView(0.5)
            }
            .setActions { build in
                build
                    .setTap { [weak self] component, tapGesture in
                        self?.delegate?.closeDropDownRevealLetter()
                    }
            }
        return overlay
    }()
    
    lazy var arrowUpImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.triangleFill)
            .setTintColor(Theme.shared.currentTheme.surfaceContainerHigh)
            .setContentMode(.center)
            .setSize(32)
            .setConstraints { build in
                build
                    .setTop.equalTo(painelView.get, .top, -22)
                    .setTrailing.equalTo(painelView.get, .trailing, -150)
            }
        return comp
    }()
    
    lazy var painelView: ViewBuilder = {
        let comp = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 10)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(self.get, .top, 16)
                    .setLeading.equalTo(self.get, .leading, 40)
                    .setTrailing.equalTo(self.get, .trailing, -16)
                    .setHeight.equalToConstant(440)
            }
        return comp
    }()
    
    lazy var titleLabel: LabelBuilder = {
        let comp = LabelBuilder(K.String.revealLetter)
            .setSize(24)
            .setColor(Theme.shared.currentTheme.onSurface)
            .setWeight(.thin)
            .setShadow { build in
                build
                    .setColor(Theme.shared.currentTheme.onPrimary)
                    .setRadius(5)
                    .setOffset(width: 4, height: 4)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(painelView.get, .top, 12)
                    .setHorizontalAlignmentX.equalTo(painelView.get)
            }
        return comp
    }()
    
    lazy var useRevealLetterLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setTextAttributed { build in
                build
                    .setText(text: "Toque ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onSurface)
                    .setImage(systemName: K.Images.handTapFill, color: Theme.shared.currentTheme.onSurface)
                    .setText(text: " para ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onSurface)
                    .setText(text: "revelar")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18, weight: .bold))
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.primary)
                    .setText(text: " 1 letra")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 16))
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onSurface)
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(titleLabel.get, .bottom, 20)
                    .setLeading.setTrailing.equalTo(painelView.get, 4)
            }
        return comp
    }()
    
    lazy var stackEyes: StackViewBuilder = {
        let stack: UIStackView
        let comp = StackViewBuilder()
            .setAxis(.horizontal)
            .setSpacing(12)
            .setDistribution(.fillEqually)
            .setConstraints { build in
                build
                    .setTop.equalTo(useRevealLetterLabel.get, .bottom, 12)
                    .setLeading.setTrailing.equalTo(painelView.get, 24)
                    .setHeight.equalToConstant(55)
            }
        return comp
    }()
    
    lazy var restartRevealLetterLabel: LabelBuilder = {
        let comp = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onSurface)
            .setNumberOfLines(2)
            .setTextAlignment(.center)
            .setTextAttributed { build in
                build
                    .setText(text: "As ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setText(text: "revelações ")
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.primary)
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 18, weight: .light))
                    .setText(text: "reiniciam às ")
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onSurface)
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setText(text: "00:00 ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15, weight: .black))
                    .setText(text: "horas")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
            }
            .setConstraints { build in
                build
                    .setTop.equalTo(stackEyes.get, .bottom, 20)
                    .setLeading.setTrailing.equalTo(painelView.get, 4)
            }
        return comp
    }()
    
    lazy var underLineView: ViewBuilder = {
        return ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black.withAlphaComponent(0.8))
                    .setOpacity(1)
                    .setRadius(3)
                    .applyLayer()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(restartRevealLetterLabel.get, .bottom, 24)
                    .setHorizontalAlignmentX.equalTo(painelView.get)
                    .setHeight.equalToConstant(2)
                    .setWidth.equalToConstant(160)
            }
    }()
    
    lazy var adRevealLetterPainel: AdRevelationsPainelView = {
        let comp = AdRevelationsPainelView()
            .setConstraints { build in
                build
                    .setTop.equalTo(underLineView.get, .bottom, 32)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setHeight.equalToConstant(68)
            }
        return comp
    }()
    
    lazy var buyRevealLetterPainel: BuyRevealLetterPainelView = {
        let comp = BuyRevealLetterPainelView()
            .setConstraints { build in
                build
                    .setTop.equalTo(adRevealLetterPainel.get, .bottom, 24)
                    .setLeading.setTrailing.equalToSuperView(16)
                    .setHeight.equalToConstant(68)
            }
        return comp
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        overlay.add(insideTo: self.get)
        arrowUpImage.add(insideTo: self.get)
        painelView.add(insideTo: self.get)
        titleLabel.add(insideTo: painelView.get)
        useRevealLetterLabel.add(insideTo: painelView.get)
        stackEyes.add(insideTo: painelView.get)
        addEyeImage()
        restartRevealLetterLabel.add(insideTo: painelView.get)
        underLineView.add(insideTo: painelView.get)
        adRevealLetterPainel.add(insideTo: painelView.get)
        buyRevealLetterPainel.add(insideTo: painelView.get)
    }
    
    private func configConstraints() {
        overlay.applyConstraint()
        arrowUpImage.applyConstraint()
        painelView.applyConstraint()
        titleLabel.applyConstraint()
        useRevealLetterLabel.applyConstraint()
        stackEyes.applyConstraint()
        restartRevealLetterLabel.applyConstraint()
        underLineView.applyConstraint()
        adRevealLetterPainel.applyConstraint()
        buyRevealLetterPainel.applyConstraint()
    }
    
    private func addEyeImage() {
        let tagsEyes = (1...5)
        tagsEyes.forEach { tag in
            let eye = makeEyeImage(tag)
            .setActions { build in
                build
                    .setTap { [weak self] component, tapGesture in
                        self?.delegate?.revealLetterButtonTapped(component: component)
                    }
            }
            eye.add(insideTo: stackEyes.get)
            eyes?.append(eye)
        }
    }
    
    private func makeEyeImage(_ tag: Int) -> ViewBuilder {
        let view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.primary)
                    .setShape(.convex)
                    .setDistance(to: .light, percent: 2)
                    .setDistance(to: .dark, percent: 10)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 10)
                    .setIntensity(to: .light, percent: 50)
                    .setIntensity(to: .dark, percent: 100)
                    .apply()
            })
            .setBorder({ build in
                build
                    .setCornerRadius(8)
                    .setWidth(1)
                    .setColor(Theme.shared.currentTheme.primary.withAlphaComponent(0.4))
            })
            .setTag(tag)
            
        let img = ImageViewBuilder(systemName: K.Images.eyeSlashFill)
            .setSize(22)
            .setContentMode(.center)
            .setWeight(.bold)
            .setTintColor(Theme.shared.currentTheme.onSurfaceInverse.withAlphaComponent(0.8))
            .setTag(tag + tagImage)
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
            }
        
        img.add(insideTo: view.get)
        img.applyConstraint()
        
        return view
    }
    
    
}
