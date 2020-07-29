import UIKit

class SelectionButton: UIButton {
    static let ACTION_SELECTED = 1
    static let ACTION_DESELECTED = 0

    // Allows developer to edit what colors are shown in each state
    @IBInspectable var borderColorSelected:UIColor = UIColor.purple
    @IBInspectable var borderColorDeselected:UIColor = UIColor.purple
    
    @IBInspectable var borderWidth:CGFloat = 3
    @IBInspectable var cornerRadius:CGFloat = 10
    
    // The color of text shown in each state
    @IBInspectable var textColorDeselected:UIColor = UIColor.lightGray
    @IBInspectable var textColorSelected:UIColor = UIColor.black
    
    // The backgound in each stat
    @IBInspectable var fillColorDeselected:UIColor = UIColor.white
    @IBInspectable var fillColorSeleted:UIColor = UIColor.red
    
    // Sets the Active/Inactive State
    @IBInspectable var active:Bool = false
    
    // Custom Border to the UIButton
    private let ca = CAShapeLayer()
    
    // Callback when clicked
    var callback:((Int) -> ())?
    
    override func draw(_ rect: CGRect) {
        
        // Setup CAShape Layer (Dashed/Solid Border)
        ca.lineWidth = borderWidth
        ca.frame = self.bounds
        ca.fillColor = fillColorDeselected.cgColor
        ca.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
//        self.layer.addSublayer(ca)
        self.layer.insertSublayer(ca, below: self.titleLabel?.layer)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        // Setup the Button Depending on What State it is in
        if active {
            setSelected()
        } else {
            setDeselected()
        }
        
        // Respond to touch events by user
        self.addTarget(self, action: Selector("onPress"), for: .touchUpInside)
    }
    
    @objc func onPress() {
        active = !active
        
        if active {
            setSelected()
            self.callback?(SelectionButton.ACTION_SELECTED)
        } else {
            setDeselected()
            self.callback?(SelectionButton.ACTION_DESELECTED)
        }
    }
    
    // Set the selected properties
    func setSelected() {
        ca.lineDashPattern = nil
        ca.strokeColor = borderColorSelected.cgColor
        ca.fillColor = fillColorSeleted.cgColor
//        border.fillColor = nil
        self.setTitleColor(textColorSelected, for: .normal)
    }
    
    // Set the deselcted properties
    func setDeselected() {
        ca.lineDashPattern = nil
        ca.strokeColor = borderColorDeselected.cgColor
        ca.fillColor = fillColorDeselected.cgColor
//        border.fillColor = nil
//        border.strokeColor = UIColor.red.cgColor
        self.setTitleColor(textColorDeselected, for: .normal)
    }

}
