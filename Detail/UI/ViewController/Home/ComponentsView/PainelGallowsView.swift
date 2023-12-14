//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

class PainelGallowsView: ViewBuilder {
    
    private let painelView: UIView
    
    init(_ painelView: UIView) {
        self.painelView = painelView
        super.init()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        self
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
                    .setVerticalAlignmentY.equalTo(painelView)
            }
    }
    
    
}
