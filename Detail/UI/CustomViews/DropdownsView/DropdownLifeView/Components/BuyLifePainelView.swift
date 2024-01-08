//  Created by Alessandro Comparini on 06/01/24.
//

import UIKit
import CustomComponentsSDK

class BuyLifePainelView: ViewBuilder {
    
    override init() {
        super.init(frame: .zero)
        configure()
    }
        
    
//  MARK: - LAZY AREA
    
    lazy var heartImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "arrow.clockwise.heart")
            .setTintColor(.white)
            .setWeight(.thin)
            .setContentMode(.center)
            .setSize(38)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView(-2)
                    .setLeading.equalToSuperView(6)
            }
        return comp
    }()
    
    lazy var recoverLifeLabel: LabelBuilder = {
        let overlay = LabelBuilder()
            .setColor(.white)
            .setNumberOfLines(2)
            .setTextAttributed({ build in
                build
                    .setText(text: "Recupere suas")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 17))
                    .setText(text: "\n          VIDAS !")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 21, weight: .bold))
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setLeading.equalTo(heartImage.get, .trailing, 6)
            }
        return overlay
    }()
    
    
    //  MARK: - STACK
    lazy var discountStack: StackViewBuilder = {
        let comp = StackViewBuilder()
            .setBackgroundColor(.blue)
            .setAxis(.vertical)
            .setDistribution(.fillEqually)
            .setAlignment(.center)
            .setConstraints { build in
                build
                    .setTop.setBottom.equalToSuperView(8)
                    .setLeading.equalTo(recoverLifeLabel.get, .trailing, 14)
            }
        return comp
    }()
    
    
    //  MARK: - GROUP DISCOUNT OF
    lazy var groupOfView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var ofLabel: LabelBuilder = {
        let overlay = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onError)
            .setTextAttributed({ build in
                build
                    .setText(text: "DE:")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 11))
                    .setAttributed(key: .foregroundColor, value: Theme.shared.currentTheme.onError)
            })
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(4)
                    .setLeading.equalToSuperView(14)
            }
        return overlay
    }()
    
    lazy var valueOfLabel: LabelBuilder = {
        let overlay = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onError)
            .setTextAttributed({ build in
                build
                    .setText(text: "9,")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 15))
                    .setAttributed(key: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue)
                    .setText(text: "99")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 12))
                    .setAttributed(key: .baselineOffset, value: 2)
                    .setAttributed(key: .strikethroughStyle, value: NSUnderlineStyle.single.rawValue)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(ofLabel.get)
                    .setLeading.equalTo(ofLabel.get, .trailing, 4)
            }
        return overlay
    }()
    

    //  MARK: - GROUP DISCOUNT BY
    lazy var groupByView: ViewBuilder = {
        let comp = ViewBuilder()
        return comp
    }()
    
    lazy var byLabel: LabelBuilder = {
        let comp = LabelBuilder("POR:")
            .setSize(12)
            .setColor(Theme.shared.currentTheme.onPrimaryContainer)
            .setWeight(.bold)
            .setTextAlignment(.justified)
            .setConstraints { build in
                build
                    .setTop.equalToSuperView(4)
                    .setLeading.equalToSuperView
            }
        return comp
    }()

    lazy var valueByLabel: LabelBuilder = {
        let overlay = LabelBuilder()
            .setColor(Theme.shared.currentTheme.onPrimaryContainer)
            .setTextAttributed({ build in
                build
                    .setText(text: "4,")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 22, weight: .bold))
                    .setText(text: "99")
                    .setAttributed(key: .font, value: UIFont.systemFont(ofSize: 16))
                    .setAttributed(key: .baselineOffset, value: 4)
            })
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(byLabel.get)
                    .setLeading.equalTo(byLabel.get, .trailing, 4)
            }
        return overlay
    }()
    
    lazy var chevronRightImage: ImageViewBuilder = {
        let comp = ImageViewBuilder(systemName: "chevron.compact.right")
            .setTintColor(.white)
            .setWeight(.bold)
            .setSize(24)
            .setContentMode(.center)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalToSuperView
                    .setTrailing.equalToSuperView(-8)
            }
        
        return comp
    }()
    

//  MARK: - PRIVATE AREA
    
    private func configure() {
        addElements()
        configConstraints()
        configStyle()
    }
    
    private func addElements() {
        heartImage.add(insideTo: self.get)
        recoverLifeLabel.add(insideTo: self.get)
        discountStack.add(insideTo: self.get)
        groupOfView.add(insideTo: discountStack.get)
        ofLabel.add(insideTo: groupOfView.get)
        valueOfLabel.add(insideTo: groupOfView.get)
        groupByView.add(insideTo: discountStack.get)
        byLabel.add(insideTo: groupByView.get)
        valueByLabel.add(insideTo: groupByView.get)
        chevronRightImage.add(insideTo: self.get)
    }
    
    private func configConstraints() {
        heartImage.applyConstraint()
        recoverLifeLabel.applyConstraint()
        discountStack.applyConstraint()
        ofLabel.applyConstraint()
        valueOfLabel.applyConstraint()
        byLabel.applyConstraint()
        valueByLabel.applyConstraint()
        chevronRightImage.applyConstraint()
    }
    
    private func configStyle() {
        configBorder()
        configNeumorphism()
    }
    
    private func configBorder() {
        self
            .setBorder({ build in
                build.setCornerRadius(4)
            })
    }
    
    private func configNeumorphism() {
        self
            .setNeumorphism { build in
                build
                    .setReferenceColor(UIColor.HEX("#ba4949"))
                    .setShape(.convex)
                    .setIntensity(to: .light, percent: 80)
                    .setIntensity(to: .dark, percent: 100)
                    .setBlur(to: .light, percent: 1)
                    .setBlur(to: .dark, percent: 8)
                    .setDistance(to: .light, percent: 1)
                    .setDistance(to: .dark, percent: 8)
                    .apply()
            }
    }
    
    
}
