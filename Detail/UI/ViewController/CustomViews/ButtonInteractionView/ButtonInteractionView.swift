//  Created by Alessandro Comparini on 14/11/23.
//


import UIKit

import CustomComponentsSDK

class ButtonInteractionView: UIView {
    private let identifier =  String(describing: ButtonInteractionView.self)
    private let keyPath = "shadowOpacity"
    
    private var shadowTapped: ShadowBuilder?
    private var shadowLayer: CALayer = CALayer()
    private var animation: CABasicAnimation = CABasicAnimation()
    
    private(set) var isPressed: Bool = false
    private var colorInteraction: UIColor = Theme.shared.currentTheme.primary.adjustBrightness(20)
    private var enabledInteraction: Bool = true
    
    private weak var component: BaseBuilder?
    
    init(_ component: BaseBuilder) {
        self.component = component
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setColor(_ color: UIColor ) -> Self {
        self.colorInteraction = color
        return self
    }
    
    @discardableResult
    func setEnabledInteraction(_ enabled: Bool) -> Self {
        self.enabledInteraction = enabled
        return self
    }
    
    
//  MARK: - ACTIONS
    
    var tapped: Void {
        if !enabledInteraction {return}
        createShadowTapped()
        createAnimation()
        setDelegate()
        addAnimationOnComponent()
        return
    }
    
    var pressed: Void {
        if !enabledInteraction {return}
        if isPressed {return}
        isPressed = true
        createShadowTapped()
        return
    }
    
    var unpressed: Void {
        if !enabledInteraction {return}
        isPressed = false
        removeShadowTapped()
        return
    }
    
    
//  MARK: - PRIVATE Area
    private func setDelegate() {
        animation.delegate = self
    }
    
    private func createShadowTapped() {
        guard let component else {return}
        shadowTapped = ShadowBuilder(component)
                .setColor(colorInteraction)
                .setOffset(width: 0, height: 0)
                .setOpacity(1)
                .setRadius(2)
                .setBringToFront()
                .setID(identifier)
                .apply()
    }
    
    private func removeShadowTapped() {
        component?.baseView.removeShadowByID(identifier)
    }
    
    private func createAnimation() {
        animation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue = 1.0
        animation.toValue = 1.0
        animation.duration = 0.2
        animation.isRemovedOnCompletion = true
    }
    
    private func addAnimationOnComponent() {
        if let layer = shadowTapped?.getShadowById(identifier) {
            self.shadowLayer = layer
            shadowLayer.add(animation, forKey: identifier)
        }
    }
    
    func removeShadowOpacityAnimation() {
        shadowLayer.removeAnimation(forKey: identifier)
    }
    
}


//  MARK: - EXTENSION CAAnimationDelegate
extension ButtonInteractionView: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        removeShadowTapped()
        removeShadowOpacityAnimation()
        shadowLayer.shadowOpacity = 0
    }
    
}
