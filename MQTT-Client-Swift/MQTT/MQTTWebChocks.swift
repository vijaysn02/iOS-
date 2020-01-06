//
//  MQTTWebChocksON.swift
//  MQTT-Client-Swift
//
//  Created by Digital Testing on 11/06/19.
//  Copyright © 2019 Digital Testing. All rights reserved.
//

import Foundation

// MARK: - MqttWebChocksOn
class MqttWebChocksOn: Codable {
    let flightSchedulesID, userID, actualStartTime: Int
    
    enum CodingKeys: String, CodingKey {
        case flightSchedulesID = "flightSchedulesId"
        case userID = "userId"
        case actualStartTime
    }
    
    init(flightSchedulesID: Int, userID: Int, actualStartTime: Int) {
        self.flightSchedulesID = flightSchedulesID
        self.userID = userID
        self.actualStartTime = actualStartTime
    }
}

// MARK: - MqttWebChocksOff
class MqttWebChocksOff: Codable {
    let flightSchedulesID, userID, actualEndTime: Int
    
    enum CodingKeys: String, CodingKey {
        case flightSchedulesID = "flightSchedulesId"
        case userID = "userId"
        case actualEndTime
    }
    
    init(flightSchedulesID: Int, userID: Int, actualEndTime: Int) {
        self.flightSchedulesID = flightSchedulesID
        self.userID = userID
        self.actualEndTime = actualEndTime
    }
}
