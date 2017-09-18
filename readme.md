## Notes:
	As far as I know, I have implemented everything except:
		* Not sure if this statement is true for my code "The Model/View/Controller pattern shown in the sample code must be followed".
		* Not sure if this statement is true for my code "To implement the cells, you must override drawRect and use UIBezierPath drawn shapes and not internal UIViews".

## Known Bugs:
		Nothing as of now.
		Lag when simulation goes on for a while.

## Extras (* = done, ** = not done):
		* Added three experimental configurations in the shape of buttons.
		** Force touch, still working on it

## Graduate Credit (* = done, ** = not done):
		* Variable size from 8 until 70. (Arbitrary values).

## Insane (* = done, ** = working on it):
		I started working on optimization and improved the speed of my program significantly, however, it is still hogging memory. these are the improvements that I wanted to work on, but couldn't do them in time:
			** Implement a landscape orientation as well.
			** Look up NSCoder, use it to persist the current state of your simulation to disk, and bring it back on startup.
			** Optimize calculation by avoiding recalculation of dead zones.
