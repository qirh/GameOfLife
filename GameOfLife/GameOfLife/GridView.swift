//
//  GridView.swift
//  GameOfLife
//
//  Created by saleh on 7/19/17.
//  Copyright © 2017 saleh. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    private var board: Board
    
    private var frameNumber: Int
    let MAXFRAMES = 50
    let MINFRAMES = 1
    
    private var viewWidth: CGFloat = 0
    private var cellWidth: Double = 0
    
    private var first = true

    required init?(coder decoder: NSCoder) {
        
        board = Board(size: 10)
        self.frameNumber = 1
        
        super.init(coder: decoder)
        
        drawHelper()
    }
    
    func getFrameNumber() -> Int {
        return frameNumber
    }
    func setFrameNumber(frames: Int) {
        if(frames <= MAXFRAMES && frames >= MINFRAMES){
            self.frameNumber = frames
        }
    }
    func drawHelper(){
        if(first){
            drawGrid()
        }
        else if(!board.compareBoards()){
            
            drawGrid()
        }
        first = false
    }
    
    // src:
    // https://stackoverflow.com/a/34659468
    func drawGrid() {
        
        viewWidth = self.frame.size.width
        cellWidth = Double(viewWidth) / Double(getSize())
        
        self.backgroundColor = UIColor.lightGray
        
        let shapeLayerLines = CAShapeLayer()
        shapeLayerLines.path = createBezierPathLines().cgPath
        shapeLayerLines.strokeColor = UIColor.blue.cgColor
        shapeLayerLines.lineWidth = 1.0
        shapeLayerLines.position = CGPoint(x: 0, y: 0)
        self.layer.addSublayer(shapeLayerLines)
        
        let paths = createBezierPathRect()
        let cellStates = board.getStates()
        
        for i in 0..<paths.count {
            
            let shapeLayerRect = CAShapeLayer()
            shapeLayerRect.path = paths[i].cgPath
            
            if(cellStates[i] == .Alive){
                shapeLayerRect.fillColor = board.getColor(cellState: .Alive).cgColor
            }
            else if (cellStates[i] == .Born){
                shapeLayerRect.fillColor = board.getColor(cellState: .Born).cgColor
            }
            else if (cellStates[i] == .Died){
                shapeLayerRect.fillColor = board.getColor(cellState: .Died).cgColor
            }
            else{
                shapeLayerRect.fillColor = board.getColor(cellState: .Empty).cgColor
            }
            
            shapeLayerRect.lineWidth = 1.0
            shapeLayerRect.position = CGPoint(x: 0, y: 0)
            self.layer.addSublayer(shapeLayerRect)
        }
        
        
    }
    func createBezierPathLines() -> UIBezierPath {
        
        // create a new path
        let path = UIBezierPath()
        
        //rows
        for i in 0..<(getSize()+1){
            // starting point top left
            path.move(to: CGPoint(x: 0, y: Double(i)*cellWidth))
            path.addLine(to: CGPoint(x: viewWidth, y: CGFloat(Double(i)*cellWidth)))
        }
        
        //reset path
        path.move(to: CGPoint(x: 0, y: 0))
        
        //cols
        for i in 0..<(getSize()+1){
            // starting point top left
            path.move(to: CGPoint(x: Double(i)*cellWidth, y: 0))
            path.addLine(to: CGPoint(x: CGFloat(Double(i)*cellWidth), y: viewWidth))
        }
        return path
    }
    func createBezierPathRect() -> [UIBezierPath] {
        
        var paths: [UIBezierPath] = [UIBezierPath]()
        
        for i in 0..<(getSize()){
            for j in 0..<(getSize()){
                var cellRect: CGRect
            
                cellRect = CGRect(x: Double(i)*cellWidth + cellWidth*0.15, y: Double(j)*cellWidth + cellWidth*0.15, width: cellWidth*0.70, height: cellWidth*0.70)
                let path = UIBezierPath(rect: cellRect)
                paths.append(path)
            }
        }
        return paths
    }
    func getViewWidth() -> Double {
        return Double(viewWidth)
    }
    func getCellWidth() -> Double {
        return Double(cellWidth)
    }
    func getMinSize() -> Int {
        return board.MINSIZE
    }
    func getMaxSize() -> Int {
        return board.MAXSIZE
    }
    func getSize() -> Int {
        return board.getSize()
    }
    func setSize(size: Int) {
        board.setSize(size: size)
    }
    func getGeneration() -> Int {
        return board.getGeneration()
    }
    
    func resetGrid(size: Int){
        first = true
        board = Board(size: size)
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        drawHelper()
    }
    func play(){
        board.moveToNextGeneration()
        drawHelper()
    }
    func getColor(cellState: CellState) -> UIColor {
        return board.getColor(cellState: cellState)
    }
    func setAllCellsAlive() {
        board.setAllCells(toState: .Born)
        drawHelper()
    }
    func setChessBoard() {
        board.setChess()
        drawHelper()
    }
    func setXBoard() {
        board.setX()
        drawHelper()
    }
    func getCellState(point: CGPoint) -> CellState {
        var x = 0, y = 0
        
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.x)){
                x = i-1
                break
            }
        }
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.y)){
                y = i-1
                break
            }
        }
        let point: CellPoint = CellPoint(x,y)
        
        return board.cellStateAt(point: point)
    }
    func pressAT(point: CGPoint) {
        
        var x = 0, y = 0
        
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.x)){
                x = i-1
                break
            }
        }
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.y)){
                y = i-1
                break
            }
        }
        board.pressedCell(point: CellPoint(row: y, col: x))
        drawHelper()
    }
    func setCellAt(point: CGPoint, toState: CellState) {
        
        
        var x = 0, y = 0
        
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.x)){
                x = i-1
                break
            }
        }
        for i in 0..<(getSize()+1){
            if(Double(i)*cellWidth > Double(point.y)){
                y = i-1
                break
            }
        }
        if(board.cellStateAt(point: CellPoint(row: y, col: x)) == toState){}
            
        else{
            board.setCellAt(point: CellPoint(row: y, col: x), toState: toState)
            drawHelper()
        }
        
    }
}
