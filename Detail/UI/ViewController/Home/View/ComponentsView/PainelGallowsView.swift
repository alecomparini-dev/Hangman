//  Created by Alessandro Comparini on 13/12/23.
//

import UIKit
import CustomComponentsSDK

class PainelGallowsView: ViewBuilder {
    
    private let gamePainelView: UIView
    
    init(_ gamePainelView: UIView) {
        self.gamePainelView = gamePainelView
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
        configPainelGallowsView()
        addElements()
        configConstraints()
    }

    private func configPainelGallowsView() {
        self
            .setConstraints { build in
                build
                    .setTop.equalTo(gamePainelView, .bottom)
                    .setLeading.setTrailing.equalTo(gamePainelView)
                    .setBottom.equalToSafeArea
            }
    }
    
    private func addElements() {
        painelView.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        painelView.applyConstraint()
    }
    
    
}
