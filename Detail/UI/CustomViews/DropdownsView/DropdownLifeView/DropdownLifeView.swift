//  Created by Alessandro Comparini on 05/01/24.
//

import UIKit

import CustomComponentsSDK

class DropdownLifeView: ViewBuilder {
    
    override init() {
        super.init()
        configure()
    }

    
//  MARK: - LAZY AREA
    
    lazy var overlay: BlurBuilder = {
        let overlay = BlurBuilder(style: .extraLight)
            .setConstraints { build in
                build
                    .setPin.equalToSafeArea
            }
        return overlay
    }()
    
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        overlay.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        overlay.applyConstraint()
    }
    
    
}
