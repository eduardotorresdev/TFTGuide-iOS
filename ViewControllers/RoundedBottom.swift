import UIKit

class RoundedBottom: UIVisualEffectView {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
