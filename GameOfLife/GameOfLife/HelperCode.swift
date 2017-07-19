//  HelperCode.swift
//  For Assignment 4: Game of Life Simulation
//
//  Created by Daniel Bromberg on 7/13/16.
//  Last modified 7/13/17
//  Copyright © 2016. All rights reserved.

/*
import UIKit

/* CGPoint is floating point and not appropriate for a LOGICAL grid value */
// col means 'x' value, and is more natural in typical Cartesian notation
typealias CellPoint = (col: Int, row: Int)



// Convenience method to see how to count neighbors. You may copy this
// into your solution. Node 'grid' is a 2-D array of 'CellState's.

// Count the neighbors of a cell, treating the grid as a if it were
// wrapped around both the X and Y axes, so it becomes effectively a
// doughnut. Effectively, a cell at the leftmost boundary has as its
// neighbor the cell on the same row at the rightmost
// boundary. Similar for top and bottom.
let grid = [[CellState]]
let gridXDim = 10
let gridYDim = 10



// Capture both Pan and Tap gestures here

// Challenge here is to translate a raw point value (say, for
// the x component, from 0 to myCustomView.bounds.width) into a
// logical grid value, in order to correctly mutate the model.
// For now we'll just use debugging prints to demonstrate the API.

// Note that we're using the parent class because it might be a UITapGR or a UIPanGR
func gestureRecognized(gest: UIGestureRecognizer) {
        let rawPoint = gest.locationInView(myCustomView)
        
        switch gest.state {
            
        case .Began:
            Util.log("Pan began at \(rawPoint)")

        case .Changed:
            Util.log("Pan moved to \(rawPoint)")
            
        case .Ended:
            if let _ = gest as? UITapGestureRecognizer {
                // Tap *only* generates a .Ended event
                Util.log("Tapped at \(rawPoint), number of touches: \(gest.numberOfTouches())")
            }
            else {
                Util.log("Pan ended at \(rawPoint)")
            }
            
        case .Cancelled: return
        case .Failed: return
        case .Possible: return
        }
}
 */
