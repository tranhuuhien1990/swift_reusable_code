//
//  Toast.swift
//

import UIKit

/**
 Toast static usage class
 */
class Toast {
    
    static let cornerRadius: CGFloat = 0
    
    static var textColor: UIColor = UIColor.black
    
    static var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.2)
    
    static var positionDisplay: NSLayoutConstraint.Attribute = .bottom
    
    enum ToastPosition {
        case top
        case bottom
    }
    
    enum ToastState {
        case normal
        case success
        case error
    }
    
    static func show(message: String, position: ToastPosition, state: ToastState, controller: UIViewController) {
        
        switch position {
        case .top:
            positionDisplay = .top
        case .bottom:
            positionDisplay = .bottom
        }
        
        switch state {
        case .normal:
            backgroundColor = UIColor.black.withAlphaComponent(0.2)
            textColor = UIColor.black
        case .success:
            backgroundColor = UIColor(red: 0.83, green: 0.92, blue: 0.85, alpha: 1.00)
            textColor = UIColor(red: 0.08, green: 0.34, blue: 0.14, alpha: 1.00)
        case .error:
            backgroundColor = UIColor(red: 0.97, green: 0.84, blue: 0.85, alpha: 1.00)
            textColor = UIColor(red: 0.45, green: 0.11, blue: 0.14, alpha: 1.00)
        }
        
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = backgroundColor
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = cornerRadius;
        toastContainer.clipsToBounds  =  true

        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = textColor
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: positionDisplay, relatedBy: .equal, toItem: controller.view, attribute: positionDisplay, multiplier: 1, constant: 0)
        controller.view.addConstraints([c1, c2, c3])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
