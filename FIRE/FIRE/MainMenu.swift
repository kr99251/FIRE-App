//
//  ViewController.swift
//  FIRE
//
//  Created by Kelly Robinett on 10/11/22.
//

import UIKit

class MainMenu: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    // Function to facilitate unwinding back to main menu
    @IBAction func unwindToMain(_ segue : UIStoryboardSegue){}


}

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
            get { return layer.cornerRadius }
            set {
                  layer.cornerRadius = newValue

                  // If masksToBounds is true, subviews will be
                  // clipped to the rounded corners.
                  layer.masksToBounds = (newValue > 0)
            }
    }
}
