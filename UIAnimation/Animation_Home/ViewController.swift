//
//  ViewController.swift
//  Animation_Home
//
//  Created by Alexandr on 07.04.2024.
//

import UIKit

final class ViewController: UIViewController {

    let firstRect = UIView()
    let secondRect = UIView()
    let thirdRect = UIView()
    let fourthRect = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var topConstraint: NSLayoutConstraint!
    var bottomConstraint2: NSLayoutConstraint!
    
    var randomColor: UIColor {
            let red = Float(Int.random(in: 1...255) % 256) / 255
            let green =  Float(Int.random(in: 1...256) % 256) / 255
            let blue = Float(Int.random(in: 1...255) % 256) / 255
            
            let  result = UIColor(cgColor: CGColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))

            return result
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        makeConstr()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animationView()
    }
    
   private func createViews() {
        firstRect.backgroundColor = .blue
        secondRect.backgroundColor = .brown
        thirdRect.backgroundColor = .green
        fourthRect.backgroundColor = .orange
        
        [firstRect, secondRect, thirdRect, fourthRect].forEach { rect in
            view.addSubview(rect)
        }
    }
    
    private func makeConstr() {
        [firstRect, secondRect, thirdRect, fourthRect].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        leadingConstraint = firstRect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50)
        topConstraint = secondRect.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        trailingConstraint = thirdRect.rightAnchor.constraint(equalTo:  view.rightAnchor, constant: -50)
        bottomConstraint2 =  fourthRect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        
        NSLayoutConstraint.activate([
            leadingConstraint,
            firstRect.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            firstRect.widthAnchor.constraint(equalToConstant: 100),
            firstRect.heightAnchor.constraint(equalToConstant: 100),
            
            topConstraint,
            secondRect.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            secondRect.widthAnchor.constraint(equalToConstant: 100),
            secondRect.heightAnchor.constraint(equalToConstant: 100),
            
            trailingConstraint,
            thirdRect.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            thirdRect.heightAnchor.constraint(equalToConstant: 100),
            thirdRect.widthAnchor.constraint(equalToConstant: 100),
            
           bottomConstraint2 ,
            fourthRect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            fourthRect.widthAnchor.constraint(equalToConstant: 100),
            fourthRect.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func animationView() {
        
        let options1: UIView.AnimationOptions = [.curveEaseInOut, .autoreverse, .repeat]
        let options2: UIView.AnimationOptions = [.curveEaseInOut, .autoreverse, .repeat]
        let options3: UIView.AnimationOptions = [.curveLinear, .autoreverse, .repeat]
        let options4: UIView.AnimationOptions = [.curveEaseIn, .autoreverse, .repeat]
        
        
        UIView.animate(withDuration: 4,
                       delay: 0,
                       options: options1,
                       animations: { [self] in
            leadingConstraint.constant = view.frame.width - 150
            firstRect.backgroundColor = .brown
            
            topConstraint.constant = view.frame.height  - 150
            secondRect.backgroundColor = .green
            
            trailingConstraint.constant = -view.frame.width + 150
            thirdRect.backgroundColor = .orange
            
            bottomConstraint2.constant = -view.frame.height  + 150
            fourthRect.backgroundColor = .blue
            
            [firstRect, secondRect, thirdRect, fourthRect].forEach {
                $0.backgroundColor = randomColor
                $0.transform = .init(rotationAngle: .pi / 2)
            }
            
            self.view.layoutIfNeeded()
            }
        )
    }
}

