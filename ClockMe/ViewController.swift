//
//  ViewController.swift
//  ClockMe
//
//  Created by Curran Family Computer on 3/8/15.
//  Copyright (c) 2015 LukeCurran. All rights reserved.
//

import UIKit

//MARK: UIPickerView DataSource Protocol
extension ViewController : UIPickerViewDataSource {
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
}

//MARK: UIPickerView Delegate Protocol
extension ViewController : UIPickerViewDelegate {
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    timeDisplay.text = pickerData[row]
    secondsTime = pickerData[row].toInt()!
    myDoneIndicator.hidden = true
    
  }
  
  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    return pickerData[row]
    
  }
  
  func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    
    let titleData = pickerData[row]
    var myTitle = NSAttributedString(string: titleData, attributes: [NSForegroundColorAttributeName:UIColor.whiteColor()])
    return myTitle

  }
  
}

//MARK: ViewController Class
class ViewController: UIViewController {
  
  //MARK: Variables
  var isTimerSelected = true
  var isCountdownSelected = false
  var isPlaying = false
  var count = 0
  var timer = NSTimer()
  var millisecondTime = 0.00
  var secondsTime = 1
  let pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
  
  //MARK: Outlets
  @IBOutlet var countDown: UIButton!
  @IBOutlet var timerButton: UIButton!
  @IBOutlet var timeDisplay: UILabel!
  @IBOutlet var playPauseImage: UIImageView!
  @IBOutlet var countDownImage: UIImageView!
  @IBOutlet var timerImage: UIImageView!
  @IBOutlet var countdownPickerView: UIPickerView!
  @IBOutlet var myDoneIndicator: UIImageView!
  
  //MARK: Actions
  @IBAction func myPlayPauseButton(sender: UIButton) {
    count += 1
    
    if isTimerSelected == true {
      // Timer Selected
      if count % 2 == 1 {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("startTimer"), userInfo: nil, repeats: true)
        playPauseImage.image = UIImage(named: "rounded57")
        isPlaying = true
      } else {
        timer.invalidate()
        playPauseImage.image = UIImage(named: "play43")
        isPlaying = false
      }
    } else {
      // Countdown Selected
      isCountdownSelected == true
      if count % 2 == 1 {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("countdownTimer"), userInfo: nil, repeats: true)
        playPauseImage.image = UIImage(named: "rounded57")
        isPlaying = true
      } else {
        timer.invalidate()
        playPauseImage.image = UIImage(named: "play43")
        isPlaying = false
      }
    }
  }
  
  @IBAction func myResetButton(sender: UIButton) {
    
    // Check if timer is playing and if not, reset like normal
    if isPlaying == true {
      return
    } else {
      millisecondTime = 0.00
      myDoneIndicator.hidden = true
      
      if isTimerSelected == true {
        timeDisplay.text = "0.00"
      } else {
        timeDisplay.text = "1"
        countdownPickerView.selectRow(0, inComponent: 0, animated: true)
      }
    }
  }
  
  @IBAction func myCountdownButton(sender: UIButton) {
    
    //Check if timer is running or not
    if isPlaying == true {
      return
    } else {
      timeDisplay.text = "1"
      countdownPickerView.hidden = false
      isTimerSelected = false
      isCountdownSelected = true
      countDownImage.image = UIImage(named: "Countdown-Selected")
      timerImage.image = UIImage(named: "Timer")
    }
  }
  
  @IBAction func myTimerButton(sender: UIButton) {
    
    //Check if timer is running or not
    if isPlaying == true {
      return
    } else {
      timeDisplay.text = "0.00"
      countdownPickerView.hidden = true
      isTimerSelected = true
      timerImage.image = UIImage(named: "Timer-Selected")
      countDownImage.image = UIImage(named: "Countdown")
      myDoneIndicator.hidden = true
    }
  }
  
  //MARK: Functions/Selectors
  //Timer Selector
  func startTimer() {
    
    isPlaying = true
    millisecondTime += 0.01
    timeDisplay.text = String(format:"%.2f", millisecondTime)
  }
  
  //Countdown Selector
  func countdownTimer() {
    
    if secondsTime == 0 {
      timer.invalidate()
      isPlaying = false
      myDoneIndicator.hidden = false
      playPauseImage.image = UIImage(named: "play43")
    } else {
      secondsTime -= 1
      timeDisplay.text = "\(secondsTime)"
    }
  }
  
  //MARK: ViewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set up time label when view first loads
    timeDisplay.text = "0.00"
    
    // Set up pickerView
    countdownPickerView.hidden = true
    countdownPickerView.dataSource = self
    countdownPickerView.delegate = self
    
    // Done Indicator hidden when view loads
    myDoneIndicator.hidden = true
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
}