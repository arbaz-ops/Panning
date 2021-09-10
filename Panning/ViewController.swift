//
//  ViewController.swift
//  Panning
//
//  Created by Mac on 28/03/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myView: UIView!
    var old_distance:CGFloat = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanningFromBottom))
        panGesture.maximumNumberOfTouches = 1
        myView.isUserInteractionEnabled = true
        myView.layer.cornerRadius = 30
        myView.addGestureRecognizer(panGesture)
        
    }
    @objc func didPanningFromBottom(recognizer: UIPanGestureRecognizer){
        let yPosition = recognizer.translation(in: view).y
        let yVelocity = recognizer.velocity(in: view).y
        print(yPosition)
        if recognizer.state == .began {

        } else if recognizer.state == .changed {

            // Scale down a small amount
            let scale: CGFloat = 1.0 - abs(yPosition / 2000)
            
            myView.transform = CGAffineTransform.identity
                .translatedBy(x: 0, y: yPosition)
                .scaledBy(x: scale, y: scale)
            
        } else if recognizer.state == .ended {
            
            // If either have a minimum velocity or release beyond a fixed point
            if yVelocity < -200 || (yVelocity <= 0 && yPosition < 400) {
                
                UIView.animate(withDuration: 0.25) {
                    self.myView.transform = CGAffineTransform.identity.translatedBy(x: 0, y: -self.view.bounds.size.height / 2 - self.myView.bounds.size.height / 2)
                    self.myView.alpha = 0
                }
            } else {
                // Move it back to start
                UIView.animate(withDuration: 0.25) {
                    self.myView.transform = CGAffineTransform.identity
                }
            }
        }
    }
}

