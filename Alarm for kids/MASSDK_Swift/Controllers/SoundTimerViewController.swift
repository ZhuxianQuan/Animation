//
//  SoundTimerViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class SoundTimerViewController: BaseViewController {

    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var remainTimeLabel: UILabel!
    @IBOutlet weak var targetTimeLabel: UILabel!

    @IBOutlet weak var segmentItem: UISegmentedControl!
    @IBOutlet weak var switchMonitor: UISwitch!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timePickerView: UIPickerView!

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var imvBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!

    @IBOutlet weak var imvPointerPositionConstraint: NSLayoutConstraint!
    
    
    var currentHour = 0
    var currentMinute = 0
    
    var targetHour = 0
    var targetMin = 0
    var targetM = 0
    
    var sliderSelectedValue: CGFloat = 0.0

    @IBOutlet weak var imvPointer: UIImageView!
    
    var maxNoiseValue = UIScreen.main.bounds.size.width - 70

    var timerValidate = false
    
    var threshold:CGFloat = 0.0
    var shouldDragX = false
    var snapX : CGFloat = 1
    
    let pickerViewStopwatchHours = Array(0...23)
    let pickerViewStopwatchMins = Array(0...59)
    let pickerViewClockHours = Array(1...12)
    let pickerViewClockMins = Array(0...59)
    
    let pickerViewRows = 60000
    let pickerViewMiddle = 30000
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imvBack.isHidden = false
        notificationCenter.addObserver(self, selector: #selector(setTimeStrings), name: Notification.Name(rawValue: Constants.ORDER_REMAINTIME_CHANGED), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.navigationController?.viewControllers.count == 1
        {
            btnBack.isHidden = true
            imvBack.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        else{
            self.navigationController?.isNavigationBarHidden = true
            btnBack.isHidden = false
            imvBack.isHidden = false
            imvBack.setImageWith(color: UIColor.white)
        }
        initView()
        initTimePicker()

    }
    
    func initView(){
        
        // Do any additional setup after loading the view.
        imvBack.setImageWith(color: UIColor.white)
        switchMonitor.isOn = Settings.baby_monitor
        imvPointerPositionConstraint.constant = maxNoiseValue * Settings.baby_noise_value
        
        setupGustures()
        if AppDelegate.remainTime > 0 {
            changeStatus(1)
        }
        else {
            changeStatus(0)
        }
        setTargetTime(AppDelegate.remainTime)
        setTimeStrings()
        
    }
    
    
    func initTimePicker() {
        if segmentItem.selectedSegmentIndex == 0 {
            timePickerView.selectRow(pickerViewMiddle, inComponent: 0, animated: false)
            timePickerView.selectRow(pickerViewMiddle, inComponent: 2, animated: false)
        }
        else{
            timePickerView.selectRow(pickerViewMiddle, inComponent: 0, animated: false)
            timePickerView.selectRow(pickerViewMiddle, inComponent: 1, animated: false)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func timerItemSelected(_ sender: UISegmentedControl) {
        timePickerView.reloadAllComponents()
        initTimePicker()
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        
            clockView.isHidden = true
            imvBack.isHidden = true
            btnBack.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        _ = self.navigationController?.popViewController(animated: true)
        
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {

        if segmentItem.selectedSegmentIndex == 0{
            AppDelegate.remainTime = currentHour * 3600 + 60 * currentMinute
            changeStatus(1)
            let time = getCurrentTime()
            NSLog("current time === \(time.hour): \(time.minute) : \(time.second)")
            notificationCenter.post(name: Notification.Name(rawValue: Constants.ORDER_TIMER_START), object: nil)
            setTimeStrings()
            setTargetTime(AppDelegate.remainTime)
        }
        else {
            AppDelegate.remainTime = getRemainTimeTo(getMyTimeFrom(hour: targetHour, minute: targetMin, second: 0, m: targetM))
            changeStatus(1)
            let time = getCurrentTime()
            NSLog("current time === \(time.hour): \(time.minute) : \(time.second)")
            notificationCenter.post(name: Notification.Name(rawValue: Constants.ORDER_TIMER_START), object: nil)
            setTimeStrings()
            setTargetTime(AppDelegate.remainTime)
        }
    }

    @IBAction func stopButtonTapped(_ sender: UIButton) {
        
        changeStatus(0)
        notificationCenter.post(name: Notification.Name(rawValue: Constants.ORDER_TIMER_STOP), object: nil)
    }

    @IBAction func toggleBabyMonitor(_ sender: UISwitch) {
        Settings.baby_monitor = sender.isOn
    }
    
    func changeStatus(_ selected: Int){
        if selected == 0
        {
            clockView.isHidden = true
            imvBack.isHidden = true
            //btnBack.isHidden = true
            //self.navigationController?.isNavigationBarHidden = false
        }
        else{
            clockView.isHidden = false
            imvBack.isHidden = false
            //btnBack.isHidden = false
            //self.navigationController?.isNavigationBarHidden = true
            
        }
    }

    func getRemainTimeString(_ remainTime: Int) -> String{
        let hours = Int(remainTime / 3600)
        let minutes = Int((remainTime - 3600 * hours) / 60)
        let seconds = remainTime % 60
        return String.localizedStringWithFormat("%d:%02d:%02d", hours, minutes, seconds)
    }
    
    func setTargetTime(_ remainTime: Int){
        let targetTime = getTargetTime(remainTime)
        targetTimeLabel.text = String.localizedStringWithFormat("Sound stop at %d:%d", targetTime.hour, targetTime.minute)
        
    }
   
    func setTimeStrings()
    {
        remainTimeLabel.text = getRemainTimeString(AppDelegate.remainTime)
    }


}

extension SoundTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if segmentItem.selectedSegmentIndex == 0{
            return 4
        }
        else {
            return 3
        }
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var result = 0
        if segmentItem.selectedSegmentIndex == 0{
            
            if component == 0 || component == 2{
                result = pickerViewRows
            }
            else{
                result = 1
            }
        }
        else{
            if component == 0 || component == 1
            {
                 result = pickerViewRows
            }
            else {
                result = 2
            }
        }
        
        return result
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        var result = ""
        if segmentItem.selectedSegmentIndex == 0 {
            if component == 1{
                result = "hours"
            }
            else if component == 3{
                result = "min"
            }
            else if component == 0{
                result = "\(pickerViewStopwatchHours[row % pickerViewStopwatchHours.count])"
            }
            else{
                result = "\(pickerViewStopwatchMins[row % pickerViewStopwatchMins.count])"
            }
        }
        else{
            if component == 0{
                result = "\(pickerViewClockHours[row % pickerViewClockHours.count])"
            }
            else if component == 1{
                result = String.init(format: "%02d", pickerViewClockMins[row % pickerViewClockMins.count])
            }
            else{
                if row == 0{
                    result = "AM"
                }
                else{
                    result = "PM"
                }
            }
        }
        return result
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if segmentItem.selectedSegmentIndex == 0{
            if component == 0
            {
                currentHour = pickerViewStopwatchHours[row % pickerViewStopwatchHours.count]
            }
            else if component == 2{
                currentMinute = pickerViewStopwatchMins[row % pickerViewStopwatchMins.count]
            }
        }
        else{
            if component == 0
            {
                targetHour = pickerViewClockHours[row % pickerViewClockHours.count]
            }
            else if component == 1{
                targetMin = pickerViewClockMins[row % pickerViewClockMins.count]
            }
            else{
                targetM = row
            }
        }

        //AppDelegate.remainTime = currentMinute * 60 + currentHour * 3600
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
       
        if segmentItem.selectedSegmentIndex == 0 {
            if component == 0 || component == 2 {
                return 40
            }
            else{
                return 70
            }
        }
        else{
            return 70
        }
    }

}

extension SoundTimerViewController{
    
    //MARK: - Add Pan Gesture Recognizer
    
    func setupGustures(){
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SoundTimerViewController.pan(_:)))
        pan.maximumNumberOfTouches = 1
        pan.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(pan)
    }
    
    func pan(_ rec: UIPanGestureRecognizer){
        
        let p:CGPoint = rec.location(in: self.sliderView)
        let rect = imvPointer.frame
        
        if (rect.contains(p))
        {
            sliderSelectedValue = imvPointerPositionConstraint.constant
            threshold = p.x
            shouldDragX = true
        }
        
        switch rec.state {
        case .began:
            print("began")
            
        case .changed:
            if shouldDragX{
                NSLog("\(threshold) == \(p.x)")
                let delta = p.x - threshold
                if (delta > 0){
                    if (sliderSelectedValue + delta > maxNoiseValue)
                    {
                        imvPointerPositionConstraint.constant = maxNoiseValue
                    }
                    else{
                        imvPointerPositionConstraint.constant = sliderSelectedValue + delta
                    }
                    
                }
                else{
                    if (sliderSelectedValue + delta < 0)
                    {
                        imvPointerPositionConstraint.constant = 0
                    }
                    else{
                        imvPointerPositionConstraint.constant = sliderSelectedValue + delta
                    }
                }
            }
            
        case .ended:
            print("ended")
            threshold = 0
            shouldDragX = false
            
            
        case .possible:
            print("possible")
        case .cancelled:
            print("cancelled")
        case .failed:
            print("failed")
            shouldDragX = false
        }
        Settings.baby_noise_value = imvPointerPositionConstraint.constant / maxNoiseValue
        if Settings.baby_noise_value < 1.0 / 3.0
        {
            Settings.baby_crying_status = Constants.BABY_CRYING_SLEEPING
        }
        else if Settings.baby_noise_value < 2.0 / 3.0
        {
            Settings.baby_crying_status = Constants.BABY_CRYING_CRYING
        }
        else {
            Settings.baby_crying_status = Constants.BABY_CRYING_MORECRYING
        }
    }
    

}
