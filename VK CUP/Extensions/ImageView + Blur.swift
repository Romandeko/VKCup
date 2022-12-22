import UIKit

extension UIImageView {
    func makeBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.4
        blurEffectView.tag = 1
        addSubview(blurEffectView)
    }
}
