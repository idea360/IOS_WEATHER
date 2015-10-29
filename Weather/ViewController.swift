//
//  ViewController.swift
//  Weather
//
//  Created by Christopher on 10/29/15.
//  Copyright © 2015 Idea360. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let backgroundImages = ["background1", "background2", "background3", "background4"]

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let randomNum: Int = Int( arc4random_uniform(UInt32(backgroundImages.count) - 1))
        print(randomNum)
        
        backgroundImageView.image = UIImage(named: backgroundImages[randomNum])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

