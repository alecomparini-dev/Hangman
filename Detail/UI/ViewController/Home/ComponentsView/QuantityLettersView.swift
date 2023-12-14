//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

class QuantityLettersView: ViewBuilder {
    
    private let gallowsWordView: UIView
    
    init(_ gallowsWordView: UIView) {
        self.gallowsWordView = gallowsWordView
        super.init()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
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
                    .setBottom.equalTo(gallowsWordView, .bottom, 10)
                    .setTrailing.equalTo(gallowsWordView, .trailing, 10)
                    .setWidth.equalToConstant(40)
                    .setHeight.equalToConstant(22)
            }
    }
    
}
