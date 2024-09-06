//
//  ViewController.swift
//  GestureHome
//Собственно урок был долгим, но я показал все что вам нужно для создания классных интерфейсов. Ученик
//1. Добавьте квадратную картинку на вьюху вашего контроллера 
//2. Если хотите, можете сделать ее анимированной

//Студент

//3. По тачу анимационно передвигайте картинку со ее позиции в позицию тача
//4. Если я вдруг делаю тач во время анимации, то картинка должна двигаться в новую точку без рывка (как будто она едет себе и все)

//Мастер

//5. Если я делаю свайп вправо, то давайте картинке анимацию поворота по часовой стрелке на 360 градусов
//6. То же самое для свайпа влево, только анимация должна быть против часовой (не забудьте остановить предыдущее кручение)
//7. По двойному тапу двух пальцев останавливайте анимацию

//Супермен

//8. Добавьте возможность зумить и отдалять картинку используя пинч 
//9. Добавьте возможность поворачивать картинку используя ротейшн

//  Created by Alexandr on 07.05.2024.
//

import UIKit

final class ViewController: UIViewController, UIGestureRecognizerDelegate {
    private enum Constants {
        static let animationDuration: Double = 3
        static let pi = 3.14
        static let imageRect = UIImageView()
        static let nameImage = "myIMG"
    }

    private var rectScale = CGFloat()
    private var rectRotate = CGFloat()

    override func viewDidLoad() {
        super.viewDidLoad()
        createView()
        makeConstraint()
        gestureSettings()
    }
    
    private func gestureSettings() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGest(_:)))
        addRecognize(tapGesture)
        
        let doublTapDoubleTouchGesture = UITapGestureRecognizer(target: self, action: #selector(doublTapDoubleTouchGest(_:)))
        doublTapDoubleTouchGesture.numberOfTapsRequired = 2
        doublTapDoubleTouchGesture.numberOfTouchesRequired = 2
        addRecognize(doublTapDoubleTouchGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeGest))
        leftSwipeGesture.direction = .left
        addRecognize(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeGest))
        rightSwipeGesture.direction = .right
        addRecognize(rightSwipeGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGest(_:)))
        pinchGesture.delegate = self
        addRecognize(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGest(_:)))
        rotationGesture.delegate = self
        addRecognize(rotationGesture)
    }
    
    private func createView() {
        Constants.imageRect.image = UIImage(named: Constants.nameImage)
        view.addSubview(Constants.imageRect)
    }
    
    private func makeConstraint() {
        Constants.imageRect.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            Constants.imageRect.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            Constants.imageRect.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            Constants.imageRect.widthAnchor.constraint(equalToConstant: 250),
            Constants.imageRect.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func addRecognize(_ add: UIGestureRecognizer) {
        self.view.addGestureRecognizer(add)
    }
}

extension ViewController {
    @objc func tapGest(_ tapSender: UITapGestureRecognizer) {
        let pointTap: CGPoint = tapSender.location(in: self.view)
        UIView.animate(withDuration: 4,
                       delay: 0,
                       options: [.curveEaseOut, .beginFromCurrentState]) {
            ViewController.Constants.imageRect.center = pointTap
        }
    }
    
    @objc func leftSwipeGest(_ swipeSender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: Constants.animationDuration) {
            Constants.imageRect.transform = Constants.imageRect.transform.rotated(by: -Constants.pi)
            Constants.imageRect.transform = Constants.imageRect.transform.rotated(by: -Constants.pi)
        }
    }
    
    @objc func rightSwipeGest(_ swipeSender: UISwipeGestureRecognizer) {
        UIView.animate(withDuration: Constants.animationDuration) {
            Constants.imageRect.transform = Constants.imageRect.transform.rotated(by: Constants.pi)
            Constants.imageRect.transform = Constants.imageRect.transform.rotated(by: Constants.pi)
        }
    }
    
    @objc func doublTapDoubleTouchGest(_ tapSender: UITapGestureRecognizer) {
        ViewController.Constants.imageRect.layer.removeAllAnimations()
    }
    
    @objc func pinchGest(_ pinchSender: UIPinchGestureRecognizer) {
        if pinchSender.state == .began {
            rectScale = 1
        }
        
        let newScale = 1.0 + pinchSender.scale - rectScale
        let currentTransform = Constants.imageRect.transform
        let newTransofm = CGAffineTransformScale(currentTransform, newScale, newScale)
        Constants.imageRect.transform = newTransofm
        rectScale = pinchSender.scale
    }
    
    @objc func rotationGest(_ rotateSender: UIRotationGestureRecognizer) {

        if rotateSender.state == .began {
            rectRotate = .zero
        }
        
        let newRotate = rotateSender.rotation - rectRotate
        let currentTransform = Constants.imageRect.transform
        let newTransform = CGAffineTransformRotate(currentTransform, newRotate)
        
        Constants.imageRect.transform = newTransform
        rectRotate = rotateSender.rotation
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
      return true
  }
}
