//
//  GridView.swift
//  GameOfLife
//
//  Created by saleh on 7/19/17.
//  Copyright © 2017 saleh. All rights reserved.
//

import UIKit

class GridView: UIView {
    
    var board: Board
    
    private var frameNumber: Int
    let MAXFRAMES = 50
    let MINFRAMES = 1
    
    private var viewWidth: CGFloat = 0
    private var cellWidth: Int = 0
    
    init(size: Int, frameNumber: Int = 1){
        
        board = Board(size: size)
        self.frameNumber = frameNumber
        
        super.init(frame: CGRect.zero)
        viewWidth = self.frame.size.width
        cellWidth = Int(viewWidth)/board.getSize()
        drawGrid()
    }
    required init?(coder decoder: NSCoder) {
        
        board = Board(size: 24)
        self.frameNumber = 1
        
        super.init(coder: decoder)
        viewWidth = self.frame.size.width
        cellWidth = Int(viewWidth)/board.getSize()
        drawGrid()
    }
    
    func getFrameNumber() -> Int {
        return frameNumber
    }
    func setFrameNumber(frames: Int) {
        if(frames <= MAXFRAMES && frames >= MINFRAMES){
            self.frameNumber = frames
        }
    }
    
    // a lot of credit goes to this answer on stack overflow
    // https://stackoverflow.com/a/34659468
    func drawGrid() {
        print("drawGrid -- viewWidth = \(viewWidth)")
        
        print("drawGrid -- cellWidth = \(cellWidth)")
        print("drawGrid -- board.getSize() = \(board.getSize())")
        
        let shapeLayer = CAShapeLayer()
        
        // The Bezier path that we made needs to be converted to
        // a CGPath before it can be used on a layer.
        shapeLayer.path = createBezierPath().cgPath
        
        // apply other properties related to the path
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 0, y: 0)
        
        // add the new layer to our custom view
        self.layer.addSublayer(shapeLayer)
    }
    func createBezierPath() -> UIBezierPath {
        
        // create a new path
        let path = UIBezierPath()
        
        //rows
        for i in 0...(board.getSize()+1){
            // starting point top left
            path.move(to: CGPoint(x: 0, y: i*cellWidth))
            path.addLine(to: CGPoint(x: viewWidth, y: CGFloat(i*cellWidth)))
        }
        
        //reset path
        path.move(to: CGPoint(x: 0, y: 0))
        
        //cols
        for i in 0...(board.getSize()+1){
            // starting point top left
            path.move(to: CGPoint(x: i*cellWidth, y: 0))
            path.addLine(to: CGPoint(x: CGFloat(i*cellWidth), y: viewWidth))
        }
        
        
        return path
    }

    
}
