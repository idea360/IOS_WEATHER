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
    let splitByTopText = "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
    let splitByBottomText = "</span></span></span></p>"
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var displayResultsLabel: UILabel!
    
    @IBAction func searchButton(sender: AnyObject) {
        if cityTextField.text?.characters.count > 1 {
            self.view.endEditing(true)
            getWeather(cityTextField.text!.stringByReplacingOccurrencesOfString(" ", withString: "-"))
        }
        else {
            displayResultsLabel.text = "Please enter a valid city."
        }
    }
    
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
    
    func getWeather(cityName: String){
        if let url = NSURL(string: "http://www.weather-forecast.com/locations/" + cityName + "/forecasts/latest") {
            let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
                if let urlContent = data {
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                    let websiteArray = webContent!.componentsSeparatedByString(self.splitByTopText)
                
                    if websiteArray.count > 1 {
                        let weatherArray = websiteArray[1].componentsSeparatedByString(self.splitByBottomText)
                    
                        if weatherArray.count > 1 {
                            let weatherSummary = weatherArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "˚")
                        
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.displayResultsLabel.text = weatherSummary
                            })
                        }
                    }
                    else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.displayResultsLabel.text = "City not found."
                        })
                    }
                }
            }
            task.resume()
        }
        else {
            displayResultsLabel.text = "Please Enter a valid city."
        }
    }
    
    //closed keyboard on touch!
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool{
        textField.resignFirstResponder()
        
        return true
    }

}

