//  Created by Alessandro Comparini on 21/01/24.
//

import UIKit
import CustomComponentsSDK
import Handler

class AdHintPainelView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
    //  MARK: - LAZY AREA

    lazy var adImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setImage(systemName: K.Images.hint)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setWeight(.thin)
            .setContentMode(.center)
            .setSize(32)
            .setConstraints { build in
                build
                    .setTop.setLeading.equalToSuperView(-12)
            }
        return comp
    }()
    
    lazy var containerBackgroundView: ViewBuilder = {
        let comp = ViewBuilder()
            .setConstraints { build in
                build
                    .setBottom.setTrailing.equalToSuperView
                    .setSize.equalToConstant(60)
            }
        comp.get.clipsToBounds = true
        return comp
    }()
        
    lazy var descriptionLabel: LabelBuilder = {
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black
        shadow.shadowOffset = CGSize(width: 3, height: 3)
        shadow.shadowBlurRadius = 2
        
        let overlay = LabelBuilder()
            .setColor(.white)
            .setNumberOfLines(2)
            .setTextAttributed({ build in
                build
                    .setText(text: "Assista o vídeo e\n         ganhe ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17))
                    .setText(text: " +5")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 20, weight: .bold))
                    .setAttributed(key: .shadow, value: shadow )
                    .setText(text: " dicas ")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 26, weight: .bold))
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-2)
                    .setLeading.equalTo(adImage.get, .trailing, 16)
                    .setWidth.equalToConstant(200)
            }
        return overlay
    }()
    
    lazy var adPlayImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: K.Images.playFill)
            .setTintColor(Theme.shared.currentTheme.onPrimaryContainer)
            .setWeight(.bold)
            .setContentMode(.center)
            .setSize(44)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalToSuperView(-36)
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        adImage.add(insideTo: self.get)
        containerBackgroundView.add(insideTo: self.get)
        descriptionLabel.add(insideTo: self.get)
        adPlayImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        adImage.applyConstraint()
        containerBackgroundView.applyConstraint()
        descriptionLabel.applyConstraint()
        adPlayImage.applyConstraint()
    }
    
    public func configStyle() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
    }
    
    private func configNeumorphism() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.secondary.adjustBrightness(80))
                    .setShape(.concave)
                    .setLightPosition(.leftBottom)
                    .setShadowColor(Theme.shared.currentTheme.surfaceContainerLow)
                    .setIntensity(percent: 40)
                    .setBlur(percent: 8)
                    .setDistance(percent: 10)
                    .apply()
            }
        }
    }
    
}
