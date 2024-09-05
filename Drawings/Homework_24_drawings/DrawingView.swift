//
//  DrawingView.swift
//  Homework_24_drawings
//
//  Created by Alexandr on 11.05.2024.

//Ученик.

//1. Нарисуйте пятиконечную звезду :)
//2. Добавьте окружности на концах звезды 
// 3. Соедините окружности линиями

//Студент.

//4. Закрасте звезду любым цветом цветом оО
//5. При каждой перерисовке рисуйте пять таких звезд (только мелких) в рандомных точках экрана

//Мастер

//6. После того как вы попрактиковались со звездами нарисуйте что-то свое, проявите творчество :)

//Супермен

//7. Сделайте простую рисовалку - веду пальцем по экрану и рисую :)

import UIKit

@IBDesignable

class DrawingView: UIView {
    
    private var lines: [Line] = []
    private var strokeColor: UIColor = .black
    private (set) var path: UIBezierPath?
    private let lineWidth: CGFloat = 3
    
    var objectsToDraw = [UIBezierPath]()
    var currentIndex = 0
    var counter = 1
    var isTapToClearArea = false
    var numOfColor = 0
    
    override func draw(_ rect: CGRect) {
       
        switch numOfColor {
        case 1: strokeColor = .black
        case 2: strokeColor = .yellow
        case 3: strokeColor = .green
        case 4: strokeColor = .blue
        case 5: strokeColor = .red
        default:
            numOfColor = 0
        }
       
        let insetRect = CGRectInset(rect, lineWidth / 2, lineWidth / 2)
        path = UIBezierPath(roundedRect: insetRect, cornerRadius: 10 )
        
        var randomXCoord: CGFloat {
            let randomX = Int.random(in: 35...Int(rect.maxX))
            return CGFloat(randomX)
        }
        
        var randomYCoord: CGFloat {
            let randomY = Int.random(in: 35...Int(rect.maxX))
            return CGFloat(randomY)
        }

        UIColor.cyan.setFill()
        path?.fill()
        path?.lineWidth = lineWidth
        
        UIColor.clear.setFill()
        path?.stroke()
        
        print("x - \(randomXCoord) : y - \(randomYCoord) ")
        print("currentIndex - \(currentIndex)")
        print("counter - \(counter)")
        
        if currentIndex != 0 {
            if (currentIndex == counter) {
                for _ in 1...counter {
                    let star = createStar(rect: rect, x: CGFloat(randomXCoord), y: CGFloat(randomYCoord))
                    objectsToDraw.append(star)
                }
                
                print("item in array - \(objectsToDraw.count)")
                counter += 1
                
                objectsToDraw.forEach { star in
                    path?.append(star)
                }
                
                if currentIndex == 10 {
                    currentIndex = 0
                    counter = 1
                    objectsToDraw.removeAll()
                }
            }
        }
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
            
        lines.forEach { line in
            context.setStrokeColor(line.strokeColor.cgColor)
            context.setLineWidth(line.strokeWidth)
            context.setLineCap(.round)
                
            line.points
                .enumerated()
                .forEach { (index, point) in
                    if index == 0 {
                        context.move(to: point)
                    } else {
                        context.addLine(to: point)
                    }
                }
            context.strokePath()
        }
        
        if isTapToClearArea {
            path?.removeAllPoints()
            lines.removeAll()
            isTapToClearArea = false
            currentIndex = 0
            counter = 1
            objectsToDraw.removeAll()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        let newLine = Line(points: [point], strokeColor: strokeColor, strokeWidth: Constants.strokeWidth)
        lines.append(newLine)
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

// MARK: Add random Color function

extension DrawingView {
    
    var random: UIColor {
        let red = Float(Int.random(in: 1...255) % 256) / 255
        let green =  Float(Int.random(in: 1...256) % 256) / 255
        let blue = Float(Int.random(in: 1...255) % 256) / 255

        let  result = UIColor(cgColor: CGColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))

        return result
    }
}

// MARK: Add create star function

extension DrawingView {
    
    func createStar(rect: CGRect, x: CGFloat, y: CGFloat) -> UIBezierPath {
        let starPath = UIBezierPath()
        
        let numberOfPoints = 5
        let radius = min(rect.width, rect.height) / 10
        let center = CGPoint(x: x , y:  y )
        var angle: CGFloat = -CGFloat.pi / 2
        let angleIncrement = CGFloat.pi * 2 / CGFloat(numberOfPoints)
        
        (1...numberOfPoints).forEach { _ in
            let pointX = center.x + radius * cos(angle)
            let pointY = center.y + radius * sin(angle)
            let point = CGPoint(x: pointX, y: pointY)
            
            if starPath.isEmpty {
                starPath.move(to: point)
            } else {
                starPath.addLine(to: point)
            }
            
            angle += angleIncrement
            
            let innerPointX = center.x + radius / 2 * cos(angle)
            let innerPointY = center.y + radius / 2 * sin(angle)
            let innerPoint = CGPoint(x: innerPointX, y: innerPointY)
            
            starPath.addLine(to: innerPoint)
            
            angle += angleIncrement
        }
        
        starPath.close()
        random.setFill()
        starPath.stroke()
        starPath.fill()
        
        return starPath
    }
}

// MARK: Constants

extension DrawingView {
    
    enum Constants {
        static let strokeWidth: CGFloat = 5.0
    }
}

// MARK: Line

extension DrawingView {
    
    struct Line {
        var points = [CGPoint]()
        var strokeColor = UIColor()
        var strokeWidth = CGFloat()
    }
}
