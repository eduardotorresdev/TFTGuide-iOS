import UIKit

class BgRecentes: UIVisualEffectView {
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
    }
}
