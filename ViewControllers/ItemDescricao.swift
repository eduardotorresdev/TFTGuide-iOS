import UIKit

class ItemDescricao: UILabel {
    override func draw(_ rect: CGRect, for formatter: UIViewPrintFormatter) {
        sizeToFit()
        textAlignment = .center
    }
}
