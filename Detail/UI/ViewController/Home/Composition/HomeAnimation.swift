//  Created by Alessandro Comparini on 12/01/24.
//

import UIKit

struct HomeAnimation {
    
    func hideDropdownAnimation(dropdown: UIView) {
        dropdown.alpha = 1
        UIView.animate(withDuration: 0.3, animations: {
            dropdown.alpha = 0
        }, completion: { bool in
            if bool { dropdown.isHidden = true }
        })
    }
    
    func showDropdownAnimation(dropdown: UIView) {
        dropdown.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            dropdown.alpha = 1
        })
    }
    
    func pulseAnimationRevealingImage(_ revealingImage: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            revealingImage.alpha = 1
            let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
            pulseAnimation.duration = 0.5
            pulseAnimation.fromValue = NSNumber(value: 1.0)
            pulseAnimation.toValue = NSNumber(value: 1.2)
            pulseAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            pulseAnimation.autoreverses = true
            pulseAnimation.repeatCount = .greatestFiniteMagnitude
            revealingImage.layer.add(pulseAnimation, forKey: nil)
        })
    }
    
    func stopPulseAnimationRevealingImage(_ revealingImage: UIView) {
        if revealingImage.alpha == 0 { return }
        UIView.animate(withDuration: 0.5, animations: {
            revealingImage.alpha = 0
        }) { bool in
            if bool {revealingImage.layer.removeAllAnimations()}
        }
    }
    
    func minusRevelation(_ count: String, minusOneRevealLabel: UIView, revealLabel: UILabel) {
        let posOri = getPosOriginalMinusOneReveal(minusOneRevealLabel)
        let newPos = makeNewPositionMinusOneReveal(minusOneRevealLabel)
        
        UIView.animate(withDuration: 1.5, delay: 0.3, options: .curveEaseInOut , animations: {
            minusOneRevealLabel.alpha = 1
            minusOneRevealLabel.layer.frame.origin.y = newPos.y
            minusOneRevealLabel.layer.frame.origin.x = newPos.x
            minusOneRevealLabel.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                minusOneRevealLabel.transform = .identity
                minusOneRevealLabel.alpha = 0
            }) { bool in
                if bool {
                    revealLabel.text = count
                    minusOneRevealLabel.layer.frame.origin.y = posOri.y
                    minusOneRevealLabel.layer.frame.origin.x = posOri.x
                }
            }
        }
    }
    
    func minusHeart(_ count: String, minusHeartImage: UIView, lifeLabel: UILabel) {
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseInOut , animations: {
            minusHeartImage.alpha = 1
            minusHeartImage.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                minusHeartImage.transform = .identity
                minusHeartImage.alpha = 0
                lifeLabel.text = count
            })
        }
    }
    
    func showNextWord(_ nextWordButton: UIView) {
        UIView.animate(withDuration: 2, delay: 1, options: .curveEaseInOut , animations: {
            nextWordButton.alpha = 1
            nextWordButton.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
        }) { bool in
            if bool {
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                    nextWordButton.transform = .identity
                })
            }
        }
    }
    
//  MARK: - PRIVATE AREA
    
    private func getPosOriginalMinusOneReveal(_ minusOneRevealLabel: UIView) -> CGPoint {
        return CGPoint(x: minusOneRevealLabel.layer.frame.origin.x,
                       y: minusOneRevealLabel.layer.frame.origin.y )
    }
    
    private func makeNewPositionMinusOneReveal(_ minusOneRevealLabel: UIView) -> CGPoint {
        return CGPoint(x: minusOneRevealLabel.layer.frame.origin.x + 50,
                       y: minusOneRevealLabel.layer.frame.origin.y - 80 )
    }
    
}
