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

    func getLogs(){
        eventLogsArray = []
        var event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_TYPE_START
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner stopped by user"
        event.eventType = EventModel.EVENT_TYPE_STOP
        event.eventTime = "10/28/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_TYPE_START
        event.eventTime = "12/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner started by user"
        event.eventType = EventModel.EVENT_TYPE_START
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)
        event = EventModel()
        event.eventContent = "Air conditioner stopped by user"
        event.eventType = EventModel.EVENT_TYPE_STOP
        event.eventTime = "10/22/16, 10:12 AM"
        eventLogsArray.append(event)

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
        if (event.eventType == EventModel.EVENT_TYPE_START)
        {
            cell.imvStatus.backgroundColor = UIColor(colorLiteralRed: 72.0 / 255.0, green: 142.0 / 255.0 , blue: 42.0 / 255.0, alpha: 1)
        }
        else if(event.eventType == EventModel.EVENT_TYPE_STOP){
            cell.imvStatus.backgroundColor = UIColor(colorLiteralRed: 173.0 / 255.0, green: 37.0 / 255.0 , blue: 36.0 / 255.0, alpha: 1)
        }
        cell.lblEventLog.text = "\(event.eventTime):\(event.eventContent)"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }

}
