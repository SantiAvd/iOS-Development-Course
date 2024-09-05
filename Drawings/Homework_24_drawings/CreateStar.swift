//
//  CreateStar.swift
//  Homework_24_drawings
//
//  Created by Alexandr on 12.05.2024.
//

import UIKit

extension DrawingView {
    func createStar(x: CGPoint, y: CGPoint) {
        let rect = drawing
        let starPath = UIBezierPath()
        
        let numberOfPoints = 5
        let radius = min(rect.width, rect.height) / 4
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        
        var angle: CGFloat = -CGFloat.pi / 2
        let angleIncrement = CGFloat.pi * 2 / CGFloat(numberOfPoints)
        
        for _ in 1...numberOfPoints {
            let pointX = center.x + radius * cos(angle)
            let pointY = center.y + radius * sin(angle)
            let point = CGPoint(x: pointX, y: pointY)
//                centerPeaks.append(point)
            
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
        starPath.fill()
    }
}
