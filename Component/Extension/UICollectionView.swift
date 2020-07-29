import UIKit

extension UICollectionView {
    func reloadWithoutAnimation() {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        self.reloadData()
        CATransaction.commit()
    }
}