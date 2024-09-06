//
//  ViewController.swift
//  Home_19
/*
1. В цикле создавайте квадратные UIView с черным фоном и расположите их в виде шахматной доски
2. доска должна иметь столько клеток, как и настоящая шахматная
Студент
3. Доска должна быть вписана в максимально возможный квадрат, т.е. либо бока, либо верх или низ должны касаться границ экрана
4. Применяя соответствующие маски сделайте так, чтобы когда устройство меняет ориентацию, то все клетки растягивались соответственно и ничего не вылетало за пределы экрана.
Мастер
5. При повороте устройства все черные клетки должны менять цвет :) 6.Сделайте так, чтобы доска при поворотах всегда строго находилась по центру
Супермен
8. Поставьте белые и красные шашки (квадратные вьюхи) так как они стоят на доске. Они должны быть сабвьюхами главной вьюхи (у них и у клеток один супервью)
9. После каждого переворота шашки должны быть перетасованы используя соответствующие методы иерархии UIView*/
//  Created by Alexandr on 28.03.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var boardSideHeight: CGFloat = {
        let screen = UIScreen.main.bounds
        let screenHeight = screen.size.height
        
        return screenHeight
    }()
    
    var boardSideWidth: CGFloat = {
        let screen = UIScreen.main.bounds
        let screenWidth = screen.size.width

        return screenWidth
    }()
    
    var cellSide: CGFloat =  {

        return 400 / 8
    }()
    
    let viewForBoard = UIView()
    var cell = UIView()
    var cells = [UIView()]
    var board = UIView()
    
    override func viewDidLoad() {
        view.backgroundColor = .lightGray
        createViews()
        createCels()
        makeConstraintForBoard()
        setNeedsUpdateOfSupportedInterfaceOrientations()
    }
    
    func createViews() {
        board.backgroundColor = .black
        view.addSubview(board)
        
        viewForBoard.backgroundColor = .yellow.withAlphaComponent(0)
        view.addSubview(viewForBoard)
    }
    
    func CoordX(horizontalIndex: Int, width: CGFloat) -> CGFloat {
        let coord: CGFloat
        coord = (width * CGFloat(horizontalIndex)) - width
        
        return coord
    }
    
    func CoordY(verticallIndex: Int, width: CGFloat) -> CGFloat {
        let coord: CGFloat
        coord = (width * CGFloat(verticallIndex)) - width
        
        return coord
    }
    
    var random: UIColor {
        let red = Float(Int.random(in: 1...255) % 256) / 255
        let green =  Float(Int.random(in: 1...256) % 256) / 255
        let blue = Float(Int.random(in: 1...255) % 256) / 255
        
        let  result = UIColor(cgColor: CGColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1))

        return result
    }
    
    func createCels() {
        (1...8).forEach { horizontalIndex in
            (1...8).forEach { verticalIndex in
                if (horizontalIndex + verticalIndex) % 2 == 0 {
                    let x = CoordX(horizontalIndex: horizontalIndex, width: cellSide)
                    let y = CoordY(verticallIndex: verticalIndex, width: cellSide)
                    cell = UIView(frame: CGRect(x: y, y: x, width: cellSide, height: cellSide))
                    cell.backgroundColor = .white
                    board.addSubview(cell)
                    cells.append(cell)
                }
            }
        }
    }

    func makeConstraintForBoard() {
        board.translatesAutoresizingMaskIntoConstraints = false
        viewForBoard.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            
            viewForBoard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForBoard.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            viewForBoard.widthAnchor.constraint(equalToConstant: boardSideWidth),
            viewForBoard.heightAnchor.constraint(equalToConstant: boardSideHeight),
            
            board.centerXAnchor.constraint(equalTo: viewForBoard.centerXAnchor),
            board.centerYAnchor.constraint(equalTo: viewForBoard.centerYAnchor),
            board.widthAnchor.constraint(equalToConstant: 400),
            board.topAnchor.constraint(equalTo: viewForBoard.topAnchor, constant: 100),
            board.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
    override func setNeedsUpdateOfSupportedInterfaceOrientations() {
        board.backgroundColor = random
    }
}
