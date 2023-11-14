//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

class HomeView: UIView {
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - LAZY PROPERTIES
    lazy var backgroundView: ViewBuilder = {
        let view = ViewBuilder()
            .setGradient { build in
                build
                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return view
    }()
    
    lazy var painelGallowsView: ViewBuilder = {
        let view = ViewBuilder()
            .setBorder({ build in
                build
                    .setCornerRadius(10)
            })
            .setNeumorphism { build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark, percent: 10)
                    .setDistance(to: .light, percent: 5)
                    .setDistance(to: .dark, percent: 10)
                    .apply()
            }
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(48)
                    .setLeading.equalToSuperView(32)
                    .setTrailing.equalToSuperView(-27)
                    .setHeight.equalToConstant(200)
            }
        return view
    }()
    
    lazy var gallowsView: GallowsView = {
        let view = createHangmanGallowsView()
        return view
    }()
    
    
//  MARK: - PRIVATE AREA
    private func configure() {
        addElements()
        configConstraints()
    }
    
    private func addElements() {
        backgroundView.add(insideTo: self)
        painelGallowsView.add(insideTo: self)
        gallowsView.add(insideTo: painelGallowsView.get)
    }
    
    private func configConstraints() {
        backgroundView.applyConstraint()
        painelGallowsView.applyConstraint()
        gallowsView.applyConstraint()
    }
    
    //  MARK: - PRIVATE Area
        
        private func createHangmanGallowsView() -> GallowsView {
            let view = GallowsView(frame: .zero)
                .setConstraints { build in
                    build
                        .setTop.equalToSuperView(13)
                        .setBottom.equalToSuperView(-18)
                        .setLeading.setTrailing.equalToSuperView
                }
            return view
        }
    
}


