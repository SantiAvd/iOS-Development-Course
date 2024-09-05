//
//  ViewController.swift
//  Chess
//
//  Created by Антон Трофимов on 03.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardView: UIView!
    
    var deltaPoint = CGPoint()
    var dragging: UIView!
    var cell = UIView()
    private var emptyCell: [CGPoint] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        boardView.backgroundColor = .white
        view.layoutIfNeeded()
        
        let side = boardView.frame.width / 8
        
        (1...8).forEach { horizontalIndex in
            (1...8).forEach { verticalIndex in
                if (horizontalIndex + verticalIndex) % 2 == 0 {
                    cell = getCell(horizontalIndex: horizontalIndex, verticalIndex: verticalIndex, width: side)
                    boardView.addSubview(cell)
                    
                    let isUp = (1...3).contains(verticalIndex)
                    let isDown = (6...8).contains(verticalIndex)
                    if isUp || isDown {
                        let checkerSide = side * 0.8
                        let checker = UIView()
                        
                        checker.tag = 1
                        checker.frame.size = CGSize(width: checkerSide, height: checkerSide)
                        
                        checker.layer.cornerRadius = checkerSide / 2
                        let color = isUp ? UIColor.green : .blue
                        checker.backgroundColor = color
                        boardView.addSubview(checker)
                        checker.center = cell.center
                    } else {
                        emptyCell.append(cell.center)
                    }
                }
            }
        }
    }
}

extension ViewController {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            let point = touch.location(in: boardView)
            if let checker = boardView.hitTest(point, with: event), checker.isChecker {
                dragging = checker
                
                boardView.bringSubviewToFront(dragging)
                
                let pointInChecker = touch.location(in: checker)
                
                deltaPoint = CGPoint(x: (checker.bounds.width / 2) - pointInChecker.x,
                                                    y: (checker.bounds.height / 2) - pointInChecker.y)
                
                emptyCell.append(checker.center)
            }
        }
    }
    
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         guard let touch = touches.first else { return }
             let movedTouchPoint = touch.location(in: boardView)
             
             let correctionPoint = CGPoint(x: movedTouchPoint.x + deltaPoint.x,
                                           y: movedTouchPoint.y + deltaPoint.y )
         if (dragging != nil) {
             self.dragging.center = correctionPoint
         } else {
             return dragging = nil
         }
    }
    
     override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
         guard let checker = dragging else { return }
         
         let targerPoint = checker.center.minDistancePoint(with: emptyCell)
         
         dragging.move(to: targerPoint)
         
         emptyCell.removeAll { $0 == targerPoint }
        
         dragging = nil
    }
}

//Cells
extension ViewController {
    
    func getCell(horizontalIndex: Int, verticalIndex: Int, width: CGFloat) -> UIView {
        let coordX = getCoordX(horizontalIndex: horizontalIndex, width: width)
        let coordY = getCoordY(verticalIndex: verticalIndex, width: width)
        let cell = UIView(frame: .init(x: coordX, y: coordY, width: width, height: width))
        cell.backgroundColor = .black
        return cell
    }

    func getCoordX(horizontalIndex: Int, width: CGFloat) -> CGFloat {
        CGFloat(horizontalIndex - 1) * width
    }
    
    func getCoordY(verticalIndex: Int, width: CGFloat) -> CGFloat {
        CGFloat(verticalIndex - 1) * width
    }
}

private extension UIView {
    
    var isChecker: Bool {
        tag == 1
    }
    
    func move(to point: CGPoint) {
        UIView.animate(withDuration: 0.3) {
            self.center = point
        }
    }
}

private extension CGPoint {
        
    func distance(to point: CGPoint) -> CGFloat {
        let difx = x - point.x
        let dify = y - point.y
        return (pow(difx, 2) + pow(dify, 2)).squareRoot()
    }
    
    func minDistancePoint(with centers: [CGPoint]) -> CGPoint {
        centers
            .reduce(into: (distance: 0, point: self)) {
                result, target in
                let distance = distance(to: target)
                if distance < result.distance || result.distance == 0 {
                    result.distance = distance
                    result.point = target
                }
            }
            .point
    }
}
