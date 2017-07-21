//
//  GameOfLifeVC.swift
//  GameOfLife
//
//  Created by saleh on 7/16/17.
//  Copyright © 2017 saleh. All rights reserved.
//

import UIKit



class GameOfLifeVC: UIViewController {
    
    var play: Bool = false
    var timer = Timer()
    var pressedCellState: CellState = .Empty

    @IBOutlet weak var viewGrid: GridView!
    @IBOutlet weak var viewControls: UIView!
    
    @IBOutlet weak var labelGeneration: UILabel!
    @IBOutlet weak var labelGenerationNumber: UILabel!
    @IBOutlet weak var switchPlay: UISwitch!
    @IBOutlet weak var buttonReset: UIButton!
    
    @IBOutlet weak var labelFrames: UILabel!
    @IBOutlet weak var sliderFrames: UISlider!
    @IBOutlet weak var labelFramesNumber: UILabel!
    
    @IBOutlet weak var labelSize: UILabel!
    @IBOutlet weak var sliderSize: UISlider!
    @IBOutlet weak var labelSizeNumber: UILabel!
    
    @IBOutlet weak var labelExperimental: UILabel!
    @IBOutlet weak var buttonAlive: UIButton!
    @IBOutlet weak var buttonChess: UIButton!
    @IBOutlet weak var buttonX: UIButton!
    
    
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var panGesture: UIPanGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControls.backgroundColor = UIColor.white
        
        viewGrid.frame = CGRect(x: 300, y: 300, width: 50, height: 50)
        view.addSubview(viewGrid)
        
        labelGeneration.text = "Generation:"
        labelGenerationNumber.text = "\(viewGrid.getGeneration())"
        labelGenerationNumber.textAlignment = NSTextAlignment.center;
        switchPlay.setOn(false, animated: false)
        
        buttonReset.setTitle("Reset", for: .normal)
        buttonReset.setTitleColor(.blue, for: .normal)
        buttonReset.layer.cornerRadius = 5
        buttonReset.layer.borderWidth = 0.5
        buttonReset.layer.borderColor = UIColor.black.cgColor
        
        labelFrames.text = "Frames:"
        sliderFrames.minimumValue = Float(viewGrid.MINFRAMES)
        sliderFrames.maximumValue = Float(viewGrid.MAXFRAMES)
        sliderFrames.value = Float(viewGrid.getFrameNumber())
        labelFramesNumber.text = "\(viewGrid.getFrameNumber())"
        labelFramesNumber.textAlignment = NSTextAlignment.center
        
        labelSize.text = "Size:"
        sliderSize.minimumValue = Float(viewGrid.getMinSize())
        sliderSize.maximumValue = Float(viewGrid.getMaxSize())
        sliderSize.value = Float(viewGrid.getSize())
        
        // source:
        // https://stackoverflow.com/a/9391141
        sliderSize.isContinuous = true
        
        labelSizeNumber.text = "\(viewGrid.getSize())"
        labelSizeNumber.textAlignment = NSTextAlignment.center
        
        
        // source
        // https://stackoverflow.com/a/24356906
        // and https://stackoverflow.com/a/27728516
        let multiColorString: NSString = "~~ Game of Life ~~\nby Saleh Alghusson\n■ Alive. ■ Born. ■ Died. ■ Dead."
        var coloredString = NSMutableAttributedString()

        coloredString = NSMutableAttributedString(string: multiColorString as String, attributes: [NSFontAttributeName:UIFont(name: labelInfo.font.fontName, size: 17.0)!])
        coloredString.addAttribute(NSForegroundColorAttributeName, value: viewGrid.getColor(cellState: .Alive), range: NSRange(location:38,length:1))
        coloredString.addAttribute(NSForegroundColorAttributeName, value: viewGrid.getColor(cellState: .Born), range: NSRange(location:47,length:1))
        coloredString.addAttribute(NSForegroundColorAttributeName, value: viewGrid.getColor(cellState: .Died), range: NSRange(location:55,length:1))
        coloredString.addAttribute(NSForegroundColorAttributeName, value: viewGrid.getColor(cellState: .Empty), range: NSRange(location:63,length:1))
        
        labelInfo.attributedText = coloredString
        
        
        labelExperimental.text = "Experimental:"
        
        buttonAlive.setTitle("  All Alive!  ", for: .normal)
        buttonAlive.setTitleColor(UIColor.green.darker(), for: .normal)
        buttonAlive.layer.cornerRadius = 5
        buttonAlive.layer.borderWidth = 0.5
        buttonAlive.layer.borderColor = UIColor.black.cgColor
        
        buttonChess.setTitle("  Chess  ", for: .normal)
        buttonChess.setTitleColor(UIColor.green.darker(), for: .normal)
        buttonChess.layer.cornerRadius = 5
        buttonChess.layer.borderWidth = 0.5
        buttonChess.layer.borderColor = UIColor.black.cgColor
        
        buttonX.setTitle("  X  ", for: .normal)
        buttonX.setTitleColor(UIColor.green.darker(), for: .normal)
        buttonX.layer.cornerRadius = 5
        buttonX.layer.borderWidth = 0.5
        buttonX.layer.borderColor = UIColor.black.cgColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderFramesChanged(_ sender: UISlider) {
        //https://stackoverflow.com/a/9695118
        let sliderValueFloat = Float(lroundf(sliderFrames.value))
        sender.setValue(sliderValueFloat, animated: true)
        
        let sliderValueInt = Int(sliderValueFloat)
        labelFramesNumber.text = "\(sliderValueInt)"
        viewGrid.setFrameNumber(frames: sliderValueInt)
        
        // source:
        // https://www.weheartswift.com/nstimer-in-swift/
        if(timer.isValid){
            timer.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 1.0/Double(sliderFrames.value), target: self, selector: #selector(GameOfLifeVC.countUp), userInfo: nil, repeats: true)
        }
        else{
            
        }
        
    }
    @IBAction func sliderSizeChanged(_ sender: UISlider) {
        let sliderValueFloat = Float(lroundf(sliderSize.value))
        sender.setValue(sliderValueFloat, animated: true)
        
        let sliderValueInt = Int(sliderValueFloat)
        labelSizeNumber.text = "\(sliderValueInt)"
        
    }
    @IBAction func switchPlayPressed(_ sender: UISwitch) {
        play = switchPlay.isOn
        sliderSize.isEnabled = !play
        buttonChess.isEnabled = !play
        buttonAlive.isEnabled = !play
        buttonX.isEnabled = !play
        if(play){
            timer = Timer.scheduledTimer(timeInterval: 1.0/Double(sliderFrames.value), target: self, selector: #selector(GameOfLifeVC.countUp), userInfo: nil, repeats: true)
        }
        else{
            timer.invalidate()
        }
        
        
    }
    func countUp() {
        viewGrid.play()
        labelGenerationNumber.text = "\(viewGrid.getGeneration())"
    }
    @IBAction func buttonResetPressed(_ sender: UIButton) {
        switchPlay.isOn = false
        switchPlayPressed(switchPlay)
        viewGrid.resetGrid(size: Int(Float(lroundf(sliderSize.value))))
        labelGenerationNumber.text = "\(viewGrid.getGeneration())"
        labelSizeNumber.text = "\(viewGrid.getSize())"
    }
    @IBAction func buttonAlivePressed(_ sender: UIButton) {
        buttonResetPressed(buttonReset)
        viewGrid.setAllCellsAlive()
    }
    @IBAction func buttonChessPressed(_ sender: UIButton) {
        buttonResetPressed(buttonReset)
        viewGrid.setChessBoard()

    }
    @IBAction func buttonXPressed(_ sender: UIButton) {
        buttonResetPressed(buttonReset)
        viewGrid.setXBoard()
    }
    
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        
        if(switchPlay.isOn){}
        else{
            viewGrid.pressAT(point: sender.location(in: viewGrid))
        }
        
    }
    // source
    // https://www.raywenderlich.com/76020/using-uigesturerecognizer-with-swift-tutorial
    // and https://blog.apoorvmote.com/uipangesturerecognizer-to-make-draggable-uiview-in-ios-swift/
    @IBAction func panGestureRecognizer(_ sender: UIPanGestureRecognizer) {
        print("2")
        
        if(switchPlay.isOn){}
        else{
            /*
            let translation = sender.translation(in: viewGrid)
            if let view = sender.view {
                view.center = CGPoint(x:view.center.x + translation.x,
                                      y:view.center.y + translation.y)
            }
            sender.setTranslation(CGPointZero, in: viewGrid)
            */
            if (sender.state == UIGestureRecognizerState.began){
                pressedCellState = viewGrid.getCellState(point: sender.location(in: viewGrid))
                
            }
            else if ((sender.state != UIGestureRecognizerState.ended) && (sender.state != UIGestureRecognizerState.failed)) {
                
                viewGrid.setCellAt(point: sender.location(in: viewGrid), toState: pressedCellState)
                
            }
            else{
                
            }

        }
    }
    
    

}

