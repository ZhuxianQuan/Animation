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

    @IBOutlet weak var slider: UISlider!

    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var imvBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!

    @IBOutlet weak var imvPointerPositionConstraint: NSLayoutConstraint!
    var finishTime = 0
    var currentHour = 0
    var currentMinute = 0
    
    var sliderSelectedValue: CGFloat = 0.0

    @IBOutlet weak var imvPointer: UIImageView!

    var targetTime: Int64 = 0
    
    var maxNoiseValue = UIScreen.main.bounds.size.width - 70
    
    var timer = Timer()

    var remainTime = 0
    var timerValidate = false
    
    var threshold:CGFloat = 0.0
    var shouldDragX = false
    var snapX : CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        imvBack.isHidden = false
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

    }
    
    
    
    
    
    func initView(){
        
        // Do any additional setup after loading the view.
        imvBack.setImageWith(color: UIColor.white)
        
        remainTimeLabel.text = getRemainTimeString(remainTime)
        
        guard let finishlasttime = userDefault.value(forKey: "FinishTime") else {
            return
        }
        targetTime = Int64(finishlasttime as! Int64 / 1000)
        remainTime = Int((getGlobalTime() - targetTime) / 1000)
        if (remainTime < 0){
            userDefault.removeObject(forKey: "FinishTime")
        }
        else{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
        }
        
        remainTimeLabel.text = getRemainTimeString(remainTime)
        targetTimeLabel.text = getLocalTimeString(getTimeFromGMTTimeMillis(time: finishlasttime as! Int64))
        
        
        if Settings.baby_mode_status == Constants.BABY_MODE_ON{
            switchMonitor.isOn = true
        }
        else{
            
            switchMonitor.isOn = false
        }
        
        imvPointerPositionConstraint.constant = maxNoiseValue * Settings.baby_noise_value
        
        
        setupGustures()
    }
    
    //Mark - Add Pan Gesture Recognizer
    
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




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func timerItemSelected(_ sender: UISegmentedControl) {
        changeStatus(sender.selectedSegmentIndex)
    }

    @IBAction func backButtonTapped(_ sender: Any) {
        if segmentItem.selectedSegmentIndex == 0{
            _ = self.navigationController?.popViewController(animated: true)
        }
        else{
            segmentItem.selectedSegmentIndex = 0
        }
        changeStatus(segmentItem.selectedSegmentIndex)
    }

    @IBAction func startButtonTapped(_ sender: UIButton) {

        remainTime = currentHour * 3600 + 60 * currentMinute
        targetTime = getGlobalTime() / 1000 + remainTime
        userDefault.set(targetTime * 1000, forKey: "FinishTime")
        setTimeStrings()
        if timer.isValid{
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerUpdated), userInfo: nil, repeats: true)
        changeStatus(1)
    }

    @IBAction func stopButtonTapped(_ sender: UIButton) {

        if (remainTime > 0){
            userDefault.removeObject(forKey: "FinishTime")
            timer.invalidate()
        }
    }

    @IBAction func toggleBabyMonitor(_ sender: UISwitch) {
        /*if Settings.baby_mode_status == Constants.BABY_MODE_ON{
            Settings.baby_mode_status = Constants.BABY_MODE_OFF
        }
        else{
            Settings.baby_mode_status = Constants.BABY_MODE_ON
        }*/
        Settings.baby_monitor = sender.isOn
        
    }
    func changeStatus(_ selected: Int){
        if selected == 0
        {
            clockView.isHidden = true
            imvBack.isHidden = true
            btnBack.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
        }
        else{
            clockView.isHidden = false
            imvBack.isHidden = false
            btnBack.isHidden = false
            self.navigationController?.isNavigationBarHidden = true
        }
    }

    func getRemainTimeString(_ remainTime: Int) -> String{
        let hours = Int(remainTime / 3600)
        let minutes = Int((remainTime - 3600 * hours) / 60)
        let seconds = remainTime % 60
        return String.localizedStringWithFormat("%d:%02d:%02d", hours, minutes, seconds)
    }

    func timerUpdated(){
        if remainTime == 0
        {
            timer.invalidate()
        }
        else
        {
            remainTime -= 1
            setTimeStrings()
        }
    }

    func setTimeStrings()
    {
        remainTimeLabel.text = getRemainTimeString(remainTime)
        targetTime = getGlobalTime() / 1000 + remainTime
        targetTimeLabel.text = getLocalTimeString(getTimeFromGMTTimeMillis(time: targetTime))
    }


}

extension SoundTimerViewController : UIPickerViewDelegate, UIPickerViewDataSource{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        var result = 0
        if component == 0{
            result = 24
        }
        else if component == 2{
            result = 60
        }
        else{
            result = 1
        }
        
        return result
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        
        var result = ""
        if component == 1{
            result = "hours"
        }
        else if component == 3{
            result = "mins"
        }
        else{
            result = "\(row)"
        }
        return result
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            currentHour = row
        }
        else if component == 2{
            currentMinute = row
        }

        remainTime = currentMinute * 60 + currentHour * 3600
    }

}
