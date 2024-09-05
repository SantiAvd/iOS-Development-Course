//
//  ViewController.swift
//  Homework_24_drawings
//
//  Created by Alexandr on 11.05.2024.
//

//Ученик.

//1. Нарисуйте пятиконечную звезду :)
//2. Добавьте окружности на концах звезды 3. Соедините окружности линиями

//Студент.

//4. Закрасте звезду любым цветом цветом оО
//5. При каждой перерисовке рисуйте пять таких звезд (только мелких) в рандомных точках экрана

//Мастер

//6. После того как вы попрактиковались со звездами нарисуйте что-то свое, проявите творчество :)

//Супермен

//7. Сделайте простую рисовалку - веду пальцем по экрану и рисую :)

import UIKit

class ViewController: UIViewController {
    
    private let drawingView = DrawingView()
    private let addStarButton = UIButton()
    private let setColorButton  = UIButton()
    private let clearAreaButton = UIButton()
    private let colorPreview = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }
    
    override func setNeedsUpdateOfSupportedInterfaceOrientations() {
        drawingView.setNeedsDisplay()
    }
}

// MARK: Add configuration and buttons function

extension ViewController {
    
    func configure() {
        let titleColor: UIColor = .cyan
        let textColor: UIColor = .darkText
        let whiteCollor: UIColor = .white
        let borderWidth = 1.0
        let borderColor: CGColor = UIColor.black.cgColor
        
        drawingView.backgroundColor = whiteCollor
        view.addSubview(drawingView)
        
        colorPreview.backgroundColor = .black
        colorPreview.layer.cornerRadius = 10
        colorPreview.layer.borderWidth = borderWidth
        colorPreview.layer.borderColor = borderColor
        view.addSubview(colorPreview)
        
        addStarButton.setTitle("Add Star", for: .normal)
        addStarButton.setTitleColor(textColor, for: .normal)
        addStarButton.layer.cornerRadius = 10
        addStarButton.layer.borderWidth = borderWidth
        addStarButton.layer.borderColor = borderColor
        addStarButton.backgroundColor = titleColor
        addStarButton.addTarget(self, action: #selector(TapButtonAddStar), for: .touchUpInside)
        view.addSubview(addStarButton)
        
        clearAreaButton.setTitle("Clear Area", for: .normal)
        clearAreaButton.setTitleColor(textColor, for: .normal)
        clearAreaButton.layer.cornerRadius = 10
        clearAreaButton.layer.borderWidth = borderWidth
        clearAreaButton.layer.borderColor = borderColor
        clearAreaButton.backgroundColor = titleColor
        clearAreaButton.addTarget(self, action: #selector(clearArea), for: .touchUpInside)
        view.addSubview(clearAreaButton)
        
        setColorButton.setTitle("Set color", for: .normal)
        setColorButton.setTitleColor(textColor, for: .normal)
        setColorButton.layer.cornerRadius = 10
        setColorButton.layer.borderWidth = borderWidth
        setColorButton.layer.borderColor = borderColor
        setColorButton.backgroundColor = titleColor
        setColorButton.addTarget(self, action: #selector(setColor), for: .touchUpInside)
        view.addSubview(setColorButton)
    }
    
    func makeConstraint() {
        
        [drawingView, addStarButton, setColorButton, clearAreaButton, colorPreview].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        NSLayoutConstraint.activate([
            drawingView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            drawingView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            drawingView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            drawingView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            
            addStarButton.topAnchor.constraint(equalTo: drawingView.bottomAnchor, constant: 20),
            addStarButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addStarButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            
            clearAreaButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            clearAreaButton.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -30),
            clearAreaButton.topAnchor.constraint(equalTo: drawingView.bottomAnchor, constant: 20),
            
            setColorButton.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -30),
            setColorButton.topAnchor.constraint(equalTo: drawingView.bottomAnchor, constant: 20),
            setColorButton.leftAnchor.constraint(equalTo: clearAreaButton.leftAnchor, constant: 100),
            
            colorPreview.topAnchor.constraint(equalTo: drawingView.bottomAnchor, constant: 20),
            colorPreview.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -30),
            colorPreview.leftAnchor.constraint(equalTo: setColorButton.leftAnchor, constant: 100),
            colorPreview.rightAnchor.constraint(equalTo: addStarButton.rightAnchor, constant: -100)
        ])
    }
    
    @objc func TapButtonAddStar() {
        
        if drawingView.currentIndex < 10 {
            drawingView.currentIndex  += 1
        }
        
        drawingView.setNeedsDisplay()
    }
    
    @objc func clearArea() {
        
        drawingView.isTapToClearArea = true
        
        drawingView.setNeedsDisplay()
    }
    
    @objc func setColor() {
        
        drawingView.numOfColor += 1
        
        switch drawingView.numOfColor {
        case 1: colorPreview.backgroundColor = .black
        case 2: colorPreview.backgroundColor = .yellow
        case 3: colorPreview.backgroundColor = .green
        case 4: colorPreview.backgroundColor = .blue
        case 5: colorPreview.backgroundColor = .red
        default: break
        }
        
        drawingView.setNeedsDisplay()
    }
}
