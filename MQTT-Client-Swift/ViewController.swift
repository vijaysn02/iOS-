//
//  ViewController.swift
//  MQTT-Client-Swift
//
//  Created by Digital Testing on 02/04/19.
//  Copyright © 2019 Digital Testing. All rights reserved.
//

import UIKit
import MQTTClient

class ViewController: UIViewController, MQTTSessionDelegate,UITableViewDataSource {
    
    
 
    //MQTT - Variables
    
    //let MQTT_HOST = "wss://digital-mrkt.tpfsoftware.com"
    let MQTT_HOST = "spicejet.rapidturnaround.flights"
    let MQTT_PORT: UInt32 = 8884
    let MQTT_USERNAME : String = "backend"
    let MQTT_PASSWORD : String = "backend"
    var MQTT_CLIENTID : String = "mob_vij_"
    
    var TOPICNAME_1 : String = "MAA/TS/CHOCKS_ON"
    var TOPICNAME_2 : String = "MAA/TS/CHOCKS_OFF"
    var TOPICNAME_3 : String = "MAA/FS/BAY_CHANGE_NOTIFY"
    var TOPICNAME_4 : String = "MAA/TS/WEB_CHOCKS_ON"
    var TOPICNAME_5 : String = "MAA/TS/WEB_CHOCKS_OFF"
    var TOPICNAME_6 : String = "MAA/FS/ETA_ETD_CHANGE"
    var TOPICNAME_7 : String = "MAA/TA/TASK_ASSIGN"
    var TOPICNAME_8 : String = "SERVER_STATUS"
    
    
    var sessionConnected = false
    var sessionError = false
    var sessionReceived = false
    var sessionSubAcked = false
    
    private var transportWebSocket = MQTTWebsocketTransport()
    fileprivate var session = MQTTSession()
    fileprivate var completion: (()->())?
    
    
    
    
    //MQTT - Variables
    
    var sampleArray = Array<Any>()
    
    @IBOutlet weak var tblSample: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectMQTT()
        tblSample.dataSource = self
    }
}

//MARK: - SetUp
extension ViewController {
    func connectMQTT() {
        //MQTT - Session Set up
        
        self.session?.delegate = self
        transportWebSocket.host = "spicejet.rapidturnaround.flights"
        //transport.allowUntrustedCertificates = true;
        transportWebSocket.port = 8884;
        transportWebSocket.tls = true;
        
        session?.transport = transportWebSocket;
        
        
        session?.userName = MQTT_USERNAME
        session?.password = MQTT_PASSWORD
        session?.cleanSessionFlag = true
        session?.clientId = MQTT_CLIENTID + String(Date().millisecondsSince1970)
        session?.keepAliveInterval = 60
        
        session?.connect() { error in
            print("connection completed with status \(String(describing: error))")
            
            self.session?.subscribe(toTopic: self.TOPICNAME_1, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_2, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_3, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_4, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_5, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_6, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_7, at: .atMostOnce)
            self.session?.subscribe(toTopic: self.TOPICNAME_8, at: .atMostOnce)
            
            if error == nil {
                print("Connection -Connected")
            } else {
                print("Connection -Error")
            }
        }
        
        //MQTT - Session Set up
        
        
    }
}

//MARK: - MQTT Delegates
extension ViewController
{
    func handleEvent(_ session: MQTTSession!, event eventCode: MQTTSessionEvent, error: Error!) {
        switch eventCode {
        case .connected:
            sessionConnected = true
        case .connectionClosed:
            sessionConnected = false
           // connectMQTT()
        default:
            sessionError = true
        }
    }
    
    func newMessage(_ session: MQTTSession!, data: Data!, onTopic topic: String!, qos: MQTTQosLevel, retained: Bool, mid: UInt32) {
       
        DispatchQueue.global(qos: .background).async {
            var sampleString = String(data: data!, encoding: String.Encoding.utf8) as String!
            
            switch topic {
            case self.TOPICNAME_1:
                self.chocks(data: data)
            case self.TOPICNAME_2:
                self.chocks(data: data)
            case self.TOPICNAME_3:
                self.changeinBayInformation(data: data)
            case self.TOPICNAME_4:
                self.webChocksOn(data: data)
            case self.TOPICNAME_5:
                self.webChocksOff(data: data)
            case self.TOPICNAME_6:
                self.changeinEtaEtd(data: data)
            case self.TOPICNAME_7:
                //self.taskAssign(data:data)
                print("Task Assign")
                
            default:
                sampleString  = "SERVER_STATUS"
            }
            
            
        }
        
        //sampleArray.removeAll()
        //sampleArray.append(sampleString)

        //tblSample.reloadData()
        
        sessionReceived = true;
        
    }
    
    func subAckReceived(_ session: MQTTSession!, msgID: UInt16, grantedQoss qoss: [NSNumber]!) {
        sessionSubAcked = true;
    }
}

extension ViewController {
    func chocks(data:Data) {
        do {
            let chocksResponse = try JSONDecoder().decode(MqttChocks.self, from: data)
            if chocksResponse.data.userID == 540 {
                //TODO: Process - Change Chocks Information for Flight
            }
            print(chocksResponse)
        } catch let jsonError {
            print(jsonError)
        }
    }
    func webChocksOn(data:Data) {
        do {
            let webChocksOnResponse = try JSONDecoder().decode(MqttWebChocksOn.self, from: data)
            
            if webChocksOnResponse.userID == 540 {
                //TODO: Process - Change Chocks Information for Flight
            }
            print(webChocksOnResponse)
        } catch let jsonError {
            print(jsonError)
        }
    }
    func webChocksOff(data:Data) {
        do {
            let webChocksOffResponse = try JSONDecoder().decode(MqttWebChocksOff.self, from: data)
            if webChocksOffResponse.userID == 540 {
                //TODO: Process - Change Chocks Information for Flight
            }
            print(webChocksOffResponse)
        } catch let jsonError {
            print(jsonError)
        }
    }
    func changeinEtaEtd(data:Data) {
        do {
            let changeinEtaEtdwebChocksOffResponse = try JSONDecoder().decode(MqttEtaEtdChange.self, from: data)
            print(changeinEtaEtdwebChocksOffResponse)
        } catch let jsonError {
            print(jsonError)
        }
    }
    func changeinBayInformation(data:Data) {
        do {
            let changeinBayInformation = try JSONDecoder().decode(MqttBayChange.self, from: data)
            //TODO: Process - Change Bay Code
            print(changeinBayInformation)
        } catch let jsonError {
            print(jsonError)
        }
    }
}

//MARK: - Table View Delegates
extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SampleCell")
        cell?.textLabel?.text = sampleArray[indexPath.row] as! String
        return cell!
    }
}

//MARK: - Date Extensin
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
