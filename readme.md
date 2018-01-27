[![MIT license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/qirh/gameoflife/master/LICENSE)
* License: MIT License

# Conway's Game of Life
	A small project that I worked on while learning iOS and Swift. Has drawing and threads.

## Notes:
	As far as I know, everything working well, nut need to double check these items:
		* Not sure if this code is an example of MVC, I need to look that up.
		* Added three experimental configurations in the shape of buttons.
		* Variable board size from 8 until 70. (Arbitrary values).

## Known Bugs:
		* It does get a bit laggy when the simulation runs for a while, I think it has something to do with how I handle drawing, since it probably is just drawing over the canvas over and over. *Comment from Daniel:* "You should be using UIBezierPath instead of CAShapeLayer. With each updateUI call, you are actually adding sublayers on top of the old layers. After just a few generations there's thousands of unused sublayers, which is why you're experiencing major slow-down as the app continues to run"
		* *Comment from Daniel:* "When the app is launched, and after the 1st tap, the grid layout is messed up (as if there's two overlapping grids now), and the user must hit reset for it to work again"
		* *Comment from Daniel:* "Constants should be CamelCase, not all caps, ie  let MAXFRAMES should be just let MaxFrames"
		* *Comment from Daniel:* "Missing the pan gesture implementation"
		* *Comment from Daniel:* "You should be using override func draw(_ rect: CGRect) and call self.setNeedsDisplay(), instead of func drawGrid()"
		* *Comment from Daniel:* "Ok, but you don't need to do var timer = NSTimer(), then if self.timer.isValid.  Instead, just declare an optional timer variable, and helper functions, start/stop timer.  You have several places where you do timer.invalidate() which is a recipe for potential bugs"

## To be Added (Ojalá):
		* Force touch, still working on it.
		* Landscape orientation.
		* Support different screens e.g iPad
