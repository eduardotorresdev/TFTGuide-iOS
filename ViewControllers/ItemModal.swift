import UIKit

class ItemModal: UIView {
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        self.isHidden = true
    }
}
