//
//  Board.swift
//  GameOfLife
//
//  Created by saleh on 7/19/17.
//  Copyright © 2017 saleh. All rights reserved.
//

import Foundation

//a lot of the structure of this model was copied from the helper code provided by the instructor of this course
typealias CellPoint = (col: Int, row: Int)
enum CellState {
    case Alive
    case Born   //just lived this generation
    
    case Empty  // = dead
    case Died   //just died this generation
    
    var isAlive: Bool {
        get {
            return self == .Alive || self == .Born
        }
    }
}
protocol LifeDataSource {
    func moveToNextGeneration()
    func setCellAt(point: CellPoint, toState : CellState)
    func cellStateAt(point: CellPoint) -> CellState
    func reset()
    var generation: Int { get }
    var size: Int { get }
}
class Board: LifeDataSource{
    
    //private var board: [[String]] = Array(repeating: Array(repeating: 0, count: 24), count: 24)
    
    //  information about multi-dimenonsonal arryas obtained from here:
    //  http://dev.iachieved.it/iachievedit/multidimensional-arrays-in-swift/
    let generation: Int
    let size: Int
    private var previousGrid: [[CellState]]
    private var grid: [[CellState]]
    
    
    init(generation: Int = 0, size: Int = 24, defaultState: CellState = .Empty){
        self.generation = generation
        self.size = size
        grid = [[CellState]](repeating: [CellState](repeating: defaultState, count: self.size), count: self.size)
        previousGrid = [[CellState]](repeating: [CellState](repeating: defaultState, count: self.size), count: self.size)
    }
    
    func countNeighborsWithToroidTopology(p: CellPoint) -> Int {
        var count = 0
        
        for neighborXOffset in -1...1 {
            for neighborYOffset in -1...1 {
                guard !(neighborXOffset == 0 && neighborYOffset == 0) else {
                    continue // self isn't a neighbor
                }
                let neighbor: CellPoint = (col: p.col + neighborXOffset, row: p.row + neighborYOffset)
                // TODO FOR YOU: fix the index bugs to use toroid wraparound
                if grid[neighbor.col][neighbor.row].isAlive {
                    count += 1
                }
            }
        }
        return count
    }
    
    func reset() {
        previousGrid.removeAll()
        grid.removeAll()
    }
    
    func cellStateAt(point: CellPoint) -> CellState {
        return grid[point.col][point.row]
    }
    
    func setCellAt(point: CellPoint, toState: CellState) {
        grid[point.col][point.row] = toState
    }
    func moveToNextGeneration() {
        //add game of life
    }

}
