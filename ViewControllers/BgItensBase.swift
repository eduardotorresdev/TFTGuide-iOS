import UIKit

class BgItensBase: UIVisualEffectView {
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}
