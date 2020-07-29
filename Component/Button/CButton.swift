import UIKit

class CButton: UIButton
{
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let r:CGFloat = 255
        let g:CGFloat = 189
        let b:CGFloat = 105
        self.layer.backgroundColor = colorWithGradient(frame: rect, colors: [UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1), UIColor(red: r/255, green: (g + 20)/255, blue: b/255, alpha: 1), UIColor(red: r/255, green: (g + 40)/255, blue: (b + 10)/255, alpha: 1)]).cgColor
//        self.layer.backgroundColor = UIColor(red: 13/255, green: 81/255, blue: 137/255, alpha: 1).cgColor
        self.tintColor = UIColor.white
        self.layer.cornerRadius = 20
    }
    
   private func colorWithGradient(frame: CGRect, colors: [UIColor]) -> UIColor {
        
        // create the background layer that will hold the gradient
        let backgroundGradientLayer = CAGradientLayer()
        backgroundGradientLayer.frame = frame
         
        // we create an array of CG colors from out UIColor array
        let cgColors = colors.map({$0.cgColor})
        
        backgroundGradientLayer.colors = cgColors
        
        UIGraphicsBeginImageContext(backgroundGradientLayer.bounds.size)
        backgroundGradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: backgroundColorImage)
    }
}
