//  Created by Alessandro Comparini on 14/11/23.
//

import UIKit

import CustomComponentsSDK

class GallowsView: ViewBuilder {
    
    private let gallowColor: UIColor = Theme.shared.currentTheme.primary
    public var topGallowsNeumorphism: NeumorphismBuilder?
    public var rodGallowsNeumorphism: NeumorphismBuilder?
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
    
    
//  MARK: - LAZY AREA
    lazy var topGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalTo(rodGallows.get, .top, 8)
                    .setLeading.equalTo(rodGallows.get, .leading, -1)
                    .setTrailing.equalTo(gallowsBase.get, .trailing, -56)
                    .setHeight.equalToConstant(8)
            }
        return view
    }()
    
    lazy var supportGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setBackgroundColor(gallowColor)
            .setConstraints { build in
                build
                    .setTop.equalTo(topGallows.get, .top)
                    .setLeading.equalTo(rodGallows.get, .trailing, 20)
                    .setHeight.equalToConstant(65)
                    .setWidth.equalToConstant(8)
            }
        view.get.transform = CGAffineTransform(rotationAngle: 50.degreesToPI )
        return view
    }()
    
    lazy var ropeGallows: ViewBuilder = {
        var view = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.primary.adjustBrightness(30))
            .setConstraints { build in
                build
                    .setTop.equalTo(topGallows.get, .bottom, -2)
                    .setHorizontalAlignmentX.equalTo(gallowsBase.get, 10)
                    .setWidth.equalToConstant(3)
                    .setHeight.equalToConstant(24)
            }
        return view
    }()
    
    lazy var ropeCircleGallows: ImageViewBuilder = {
        let img = UIImage(systemName: "transmission")
        var view = ImageViewBuilder(img)
            .setHidden(false)
            .setContentMode(.redraw)
            .setTintColor(Theme.shared.currentTheme.primary.adjustBrightness(30))
            .setConstraints { build in
                build
                    .setTop.equalTo(ropeGallows.get, .bottom, -2)
                    .setHorizontalAlignmentX.equalTo(ropeGallows.get, -1)
                    .setWidth.equalToConstant(16)
                    .setHeight.equalToConstant(20)
            }
        return view
    }()
    
    lazy var headImage: ImageViewBuilder = {
//        var named = "head3"
//        var img = UIImage(named: named)
//        img = img?.resizeImage(targetSize: CGSize(width: 171, height: 292))
//        var imgBase64String = img!.pngData()!.base64EncodedString()
//        print(imgBase64String)
//        let imgBase64Data = Data(base64Encoded: imgBase64String, options: .ignoreUnknownCharacters)
//        let imgBase64 = UIImage(data: imgBase64Data!)

        let comp = ImageViewBuilder()
            .setContentMode(.scaleToFill)
            .setBorder({ build in
                build.setCornerRadius(10)
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(ropeGallows.get, .top, 10)
                    .setHorizontalAlignmentX.equalTo(ropeGallows.get)
                    .setWidth.equalToConstant(65)
                    .setHeight.equalToConstant(110)
            }
        return comp
    }()
    
    lazy var bodyImage: ImageViewBuilder = {
        let comp = ImageViewBuilder()
            .setContentMode(.scaleToFill)
            .setBorder({ build in
                build.setCornerRadius(10)
            })
            .setConstraints { build in
                build
                    .setPin.equalTo(headImage.get)
            }
        return comp
    }()
    
    lazy var rodGallows: ViewBuilder = {
       var view = ViewBuilder()
            .setConstraints { build in
                build
                    .setTop.equalToSuperView
                    .setBottom.equalTo(gallowsBase.get, .bottom)
                    .setLeading.equalTo(gallowsBase.get, .leading, 32)
                    .setWidth.equalToConstant(12)
            }
        return view
    }()
    
    lazy var gallowsBase: ViewBuilder = {
       var view = ViewBuilder()
            .setNeumorphism({ build in
                build
                    .setReferenceColor(Theme.shared.currentTheme.surfaceContainerHighest)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 50)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 0)
                    .setBlur(to: .dark, percent: 5)
                    .setDistance(to:.light, percent: 3)
                    .setDistance(to:.dark, percent: 10)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setBottom.equalToSuperView
                    .setLeading.equalToSuperView(20)
                    .setTrailing.equalToSuperView(-24)
                    .setHeight.equalToConstant(3)
            }
        return view
    }()
    
    
    
//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configNeumorphism()
    }
    
    private func addElements() {
        ropeGallows.add(insideTo: self.get)
        ropeCircleGallows.add(insideTo: self.get)
        supportGallows.add(insideTo: self.get)
        topGallows.add(insideTo: self.get)
        rodGallows.add(insideTo: self.get)
        gallowsBase.add(insideTo: self.get)
        headImage.add(insideTo: self.get)
        bodyImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        gallowsBase.applyConstraint()
        topGallows.applyConstraint()
        ropeGallows.applyConstraint()
        ropeCircleGallows.applyConstraint()
        rodGallows.applyConstraint()
        supportGallows.applyConstraint()
        headImage.applyConstraint()
        bodyImage.applyConstraint()
    }
    
    private func configNeumorphism() {
        configTopGallowNeumorphism()
        configRodGallowsNeumorphism()
    }
    
    private func configTopGallowNeumorphism() {
        topGallowsNeumorphism = createNeumosphismGallow(topGallows)
    }
    
    private func configRodGallowsNeumorphism() {
        rodGallowsNeumorphism = createNeumosphismGallow(rodGallows)
    }
    
    private func createNeumosphismGallow(_ component: ViewBuilder) -> NeumorphismBuilder {
        return NeumorphismBuilder(component.get)
            .setReferenceColor(gallowColor)
            .setShape(.concave)
            .setLightPosition(.leftTop)
            .setIntensity(to:.light,percent: 50)
            .setIntensity(to:.dark,percent: 100)
            .setBlur(to:.light, percent: 0)
            .setBlur(to:.dark, percent: 5)
            .setDistance(to:.light, percent: 3)
            .setDistance(to:.dark, percent: 10)
            .apply()
    }
    
    
}
