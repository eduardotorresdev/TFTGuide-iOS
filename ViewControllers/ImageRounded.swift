import UIKit

class ImageRounded: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
