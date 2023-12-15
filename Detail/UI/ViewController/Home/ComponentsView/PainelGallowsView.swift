//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

class PainelGallowsView: ViewBuilder {
    
    private let scoreView: UIView
    
    init(_ scoreView: UIView) {
        self.scoreView = scoreView
        super.init()
        configure()
    }
    
    lazy var painelView: ViewBuilder = {
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
                    .setVerticalAlignmentY.equalTo(self.get)
            }
        return comp
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        self
            .setBackgroundColor(.yellow)
            .setConstraints { build in
                build
                    .setTop.equalTo(scoreView, .bottom)
                    .setLeading.setTrailing.equalTo(scoreView)
                    .setBottom.equalToSafeArea
            }
        
        painelView.add(insideTo: self.get)
        painelView.applyConstraint()
            
    }
    
    
}
