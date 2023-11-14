//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

class HomeView: ViewBuilder {
        
    override init() {
        super.init()
        configure()
    }
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        configBackgroundColor()
    }
    
    private func configBackgroundColor() {
        self.setGradient { build in
            build
                .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                .setAxialGradient(.leftTopToRightBottom)
                .apply()
        }
        
        
    }
    
    
}


