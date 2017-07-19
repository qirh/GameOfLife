//
//  GameOfLifeVC.swift
//  GameOfLife
//
//  Created by saleh on 7/16/17.
//  Copyright © 2017 saleh. All rights reserved.
//

import UIKit

class GameOfLifeVC: UIViewController {

    @IBOutlet weak var viewGrid: GridView!
    @IBOutlet weak var viewControls: UIView!
    
    @IBOutlet weak var labelGeneration: UILabel!
    @IBOutlet weak var labelGenerationNumber: UILabel!
    @IBOutlet weak var switchPlay: UISwitch!
    @IBOutlet weak var buttonReset: UIButton!
    
    @IBOutlet weak var labelFrames: UIView!
    @IBOutlet weak var sliderFrames: UIView!
    @IBOutlet weak var labelFramesNumber: UIView!
    
    @IBOutlet weak var labelSize: UIView!
    @IBOutlet weak var sliderSize: UIView!
    @IBOutlet weak var labelSizeNumber: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewGrid.backgroundColor = UIColor.lightGray
        viewControls.backgroundColor = UIColor.white
        
        buttonReset.setTitleColor(.blue, for: .normal)
        buttonReset.layer.cornerRadius = 5
        buttonReset.layer.borderWidth = 0.5
        buttonReset.layer.borderColor = UIColor.black.cgColor

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

