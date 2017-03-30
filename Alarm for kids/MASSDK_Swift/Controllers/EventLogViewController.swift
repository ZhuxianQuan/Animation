//
//  EventLogViewController.swift
//  Alarm For Children
//
//  Created by Huijing on 25/01/2017.
//  Copyright © 2017 Huijing. All rights reserved.
//

import UIKit

class EventLogViewController: BaseViewController {

    @IBOutlet weak var tblEventLog: UITableView!
    var eventLogsArray : [EventModel] = []
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imvBack: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblEventLog.separatorColor = UIColor.clear
        let clearButton = UIButton()
        clearButton.frame = CGRect(x: screenSize.width - 60, y : 2, width: 40, height: 40)
        //clearButton.backgroundColor = UIColor.black
        
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            
        clearButton.setTitle("Clear", for: .normal)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        self.navigationController?.navigationBar.addSubview(clearButton)
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
        getLogs()
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clearButtonTapped() {
        eventLogsArray = []
        tblEventLog.reloadData()
    }
    func getLogs(){
       /* eventLogsArray = []
        var event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_SOUND_START
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner stopped by user"
        event.eventType = EventModel.EVENT_SOUND_STOP
        event.eventTime = "10/28/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_SOUND_START
        event.eventTime = "12/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_SOUND_START
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner stopped by user"
        event.eventType = EventModel.EVENT_SOUND_STOP
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)*/
        eventLogsArray = GetDataFromFMDB.getEvents()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EventLogViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventLogsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventLogTableViewCell") as! EventLogTableViewCell
        let index = indexPath.row
        let event = eventLogsArray[index]
        if (event.eventType == EventModel.EVENT_SOUND_START)
        {
            cell.imvStatus.backgroundColor = Constants.COLOR_EVENT_PALY
        }
        else if(event.eventType == EventModel.EVENT_SOUND_STOP){
            cell.imvStatus.backgroundColor = Constants.COLOR_EVENT_STOP
        }
        cell.lblEventLog.text = "\(getLocalTimeString(event.eventTime)) \(event.eventContent)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

}
