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

    @IBOutlet weak var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControls.backgroundColor = UIColor.white
        
        viewGrid.frame = CGRect(x: 300, y: 300, width: 50, height: 50)
        view.addSubview(viewGrid)
        
        labelGeneration.text = "Generation:"
        labelGenerationNumber.text = "\(viewGrid.getGeneration())"
        labelGenerationNumber.textAlignment = NSTextAlignment.center;
        switchPlay.setOn(false, animated: false)
        
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
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        
        if(switchPlay.isOn){
            
        }
        else{
            let rawPoint = sender.location(in: viewGrid)
            viewGrid.pressAT(point: rawPoint)
        }
        
    }

}

