//  Created by Alessandro Comparini on 14/11/23.
//


import UIKit

import CustomComponentsSDK

class DefaultViewButton: ViewBuilder {
    
    private let cornerRadiusOutline: CGFloat = 7
    private let marginInner: CGFloat = 4.0
    
    private let colorButton: UIColor
    private var image: ImageViewBuilder = ImageViewBuilder()
    private var text: String = ""
    
    init(_ colorButton: UIColor, _ image: ImageViewBuilder) {
        self.colorButton = colorButton
        self.image = image
        super.init()
        configure()
    }

    convenience init(_ colorButton: UIColor) {
        self.init(colorButton, ImageViewBuilder())
    }

    init(_ colorButton: UIColor, _ text: String) {
        self.colorButton = colorButton
        self.text = text
        super.init()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

//  MARK: - PRIVATE Area
    
    private func configure() {
        addElements()
        configConstraints()
    }
    

//  MARK: - LAZY Area
    
    lazy var outlineView: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(cornerRadiusOutline)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(colorButton)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(percent: 80)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to: .light, percent: 5)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return view
    }()
    
    lazy var button: ButtonImageBuilder = {
        var btn = ButtonImageBuilder(self.image)
            .setTitle(self.text)
            .setTitleColor(Theme.shared.currentTheme.onSurface)
            .setTintColor(Theme.shared.currentTheme.onSurface.adjustBrightness(-20))
            .setTitleAlignment(.center)
            .setTitleSize(16)
            .setImageSize(12)
            .setTitleWeight(.regular)
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return btn
    }()
    
    
//  MARK: - PRIVATE Area
    private func addElements() {
        outlineView.add(insideTo: self.get)
        button.add(insideTo: self.outlineView.get)
    }
    
    private func configConstraints() {
        outlineView.applyConstraint()
        button.applyConstraint()
    }
    
}
