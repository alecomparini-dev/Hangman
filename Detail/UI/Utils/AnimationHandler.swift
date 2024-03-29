//  Created by Alessandro Comparini on 27/11/23.
//

import UIKit

public struct AnimationHandler {
    
    static public func transitionImage(_ currentImageView: UIImageView, _ newImage: UIImage?, _ duration: Double = 1) {
        UIView.transition(with: currentImageView, duration: duration, options: .transitionCrossDissolve, animations: {
            currentImageView.image = newImage
        }, completion: nil)
    }
    
    static public func moveHorizontal(component: UIView, position: Double, duration: Double = 1, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            component.frame.origin.x = component.frame.origin.x + position
        })
    }
    
    static public func moveVertical(component: UIView, position: Double, duration: Double = 1, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            component.frame.origin.y = component.frame.origin.y + position
        })
    }
    
    static public func rotation(component: UIView, rotationAngle: Double, duration: Double = 1, delay: Double = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            component.transform = CGAffineTransform(rotationAngle: rotationAngle.degreesToPI)
        })
    }
    
    static public func fadeIn(components: [UIView], delay: Double = 0, duration: Double = 0.5) {
        fade(isFadeIn: true, components, delay, duration)
    }
    
    static public func fadeOut(components: [UIView], delay: Double = 0, duration: Double = 0.5) {
        fade(isFadeIn: false, components, delay, duration)
    }
    
    
//  MARK: - PRIVATE AREA
    static private func fade(isFadeIn: Bool, _ components: [UIView], _ delay: Double = 0, _ duration: Double = 0.5) {
        components.forEach({$0.alpha = (isFadeIn ? 0 : 1)})
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            components.forEach({$0.alpha = (isFadeIn ? 1 : 0)})
        })
    }
    
    
}
