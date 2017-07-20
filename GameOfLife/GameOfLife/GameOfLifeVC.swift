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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControls.backgroundColor = UIColor.white
        
        viewGrid.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        viewGrid.backgroundColor = UIColor.yellow
        view.addSubview(viewGrid)
        
        labelGeneration.text = "Generation:"
        labelGenerationNumber.text = "0"
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
        sliderSize.minimumValue = Float(viewGrid.board.MINSIZE)
        sliderSize.maximumValue = Float(viewGrid.board.MAXSIZE)
        sliderSize.value = Float(viewGrid.board.getSize())
        sliderSize.isEnabled = false
        labelSizeNumber.text = "\(viewGrid.board.getSize())"
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
    }
    @IBAction func sliderSizeChanged(_ sender: UISlider) {
        let sliderValueFloat = Float(lroundf(sliderSize.value))
        sender.setValue(sliderValueFloat, animated: true)
        
        let sliderValueInt = Int(sliderValueFloat)
        labelSizeNumber.text = "\(sliderValueInt)"
        viewGrid.board.setsize(size: sliderValueInt)
    }
    @IBAction func switchPlayPressed(_ sender: UISwitch) {
        play = switchPlay.isOn
        print("ISON = \(play)")
    }
    @IBAction func buttonResetPressed(_ sender: UIButton) {
        viewGrid.board.reset()
    }
    
    
    

}

