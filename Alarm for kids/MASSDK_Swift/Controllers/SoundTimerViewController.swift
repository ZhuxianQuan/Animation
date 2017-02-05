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

    @IBOutlet weak var imvBack: UIImageView!
    @IBOutlet weak var btnBack: UIButton!

    var finishTime = 0
    var currentHour = 0
    var currentMinute = 0


    var targetTime: Int64 = 0



    var timer = Timer()

    var remainTime = 0
    var timerValidate = false

    override func viewDidLoad() {
        super.viewDidLoad()

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
            segmentItem.selectedSegmentIndex = 1
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
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        var result = 0
        if component == 0{
            result = 24
        }
        else{
            result = 60
        }
        return result
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var result = ""
        result = "\(row)"
        return result
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0
        {
            currentHour = row
        }
        else{
            currentMinute = row
        }

        remainTime = currentMinute * 60 + currentHour * 3600
    }


}
