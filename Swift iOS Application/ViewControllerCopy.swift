//
//  ViewController.swift
//  Weather Application
//
//  Created by Christopher Stump on 8/4/17.
//  Copyright © 2017 Christopher Stump. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UISearchBarDelegate, NSURLConnectionDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var tempReading: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var radarImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        print("Search Text: \(String(describing: searchBar.text))")
        
        var weather: [String:String] = [:]
        
        let urlString = getURL(enteredText: searchBar.text!)
        print(urlString)
        
        if urlString != "" {
            let url = URL(string: urlString)
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print("Error")
                }
                else {
                    if let mydata = data {
                        do {
                            let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            print(myJson)
                            if let currentWeather = myJson["current_observation"]! as AnyObject? {
                                if let temp = currentWeather["temp_f"] as AnyObject?{
                                    let myInt:Int = Int(round(temp as! Double))
                                    weather["temperature"] = String(myInt)
                                }
                                if let desc = currentWeather["weather"] as AnyObject?{
                                    weather["description"] = (desc as! String)
                                }
                                if let iconurl = currentWeather["icon_url"] as AnyObject?{
                                    weather["iconURL"] = (iconurl as! String)
                                }
                                if let windDirection = currentWeather["wind_dir"] as AnyObject?{
                                    weather["windDir"] = (windDirection as! String)
                                }
                                if let windSpeeds = currentWeather["wind_mph"] as AnyObject?{
                                    weather["windSpeed"] = "\(windSpeeds)"
                                }
                                if let humidity = currentWeather["relative_humidity"] as AnyObject?{
                                    weather["humidity"] = "\(humidity)"
                                }
                            }
                            DispatchQueue.global(qos: .default).async {
                                DispatchQueue.main.async {
                                    if weather.isEmpty {
                                        self.clearAll()
                                        self.displayErrorToast()
                                        
                                    } else {
                                        self.updateUI(weatherDictionary: weather)
                                    }
                                    weather.removeAll()
                                }
                            }
                        }
                        catch {
                            //Catch Error
                        }
                    }
                }
            }
            task.resume()
        } else {
            DispatchQueue.global(qos: .default).async {
                DispatchQueue.main.async {
                    self.clearAll()
                    self.displayErrorToast()
                }
            }
        }
    }
    
    func updateUI(weatherDictionary: Dictionary<String, String>){
        weatherDescription.text = weatherDictionary["description"]
        get_image(weatherDictionary["iconURL"]!, conditionImage)
        tempReading.text = weatherDictionary["temperature"]
        windLabel.text = "Wind: \(weatherDictionary["windDir"] ?? "NA") \(weatherDictionary["windSpeed"] ?? "NA") mph"
        humidityLabel.text = "Humidity: \(weatherDictionary["humidity"] ?? "NA")"
        let radarURL = getRadarURL(enteredText: searchBar.text!)
        get_image(radarURL, radarImage)
    }
    
    func displayErrorToast() {
        let alertController = UIAlertController(title: "Invalid Input", message: "Please enter a valid city and state.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func clearAll() {
        weatherDescription.text = ""
        conditionImage.image = nil
        tempReading.text = ""
        windLabel.text = ""
        humidityLabel.text = ""
        searchBar.text = ""
        radarImage.image = nil
    }

    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            if data != nil
            {
                let image = UIImage(data: data!)
                if(image != nil)
                {
                    DispatchQueue.main.async(execute: {
                        imageView.image = image
                        imageView.alpha = 0
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                    })
                }
            }
        })
        task.resume()
    }
    
    func getURL(enteredText: String) -> String {
        var temp:[String] = enteredText.components(separatedBy: ", ")
        temp[0] = temp[0].replacingOccurrences(of: " ", with: "_")
        if temp.count == 2 {
            return "http://api.wunderground.com/api/3794b5a5c9a02a51/conditions/q/\(temp[1])/\(temp[0]).json"
        } else {
            displayErrorToast()
        }
        return ""
    }
    
    func getRadarURL(enteredText: String) -> String {
        var temp:[String] = enteredText.components(separatedBy: ", ")
        temp[0] = temp[0].replacingOccurrences(of: " ", with: "_")
        if temp.count == 2 {
            return "http://api.wunderground.com/api/3794b5a5c9a02a51/animatedradar/q/\(temp[1])/\(temp[0]).gif?newmaps=1&timelabel=1&timelabel.y=10&num=5&delay=50"
        } else {
            displayErrorToast()
        }
        return ""
    }
}

