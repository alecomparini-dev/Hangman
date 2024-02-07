//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

class QuantityLettersView: ViewBuilder {
    
    private let hangmanWordView: UIView
    
    init(_ hangmanWordView: UIView) {
        self.hangmanWordView = hangmanWordView
        super.init()
        configure()
    }
    
    lazy var countCorrectLetterLabel: LabelBuilder = {
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
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configPainelGallowsView()
        addElements()
        configConstraints()
    }
    
    private func configPainelGallowsView() {
        self
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
                    .setBottom.equalTo(hangmanWordView, .bottom, 10)
                    .setTrailing.equalTo(hangmanWordView, .trailing, 10)
                    .setWidth.equalToConstant(40)
                    .setHeight.equalToConstant(22)
            }
    }
    
    private func addElements() {
        countCorrectLetterLabel.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        countCorrectLetterLabel.applyConstraint()
    }
    
}
