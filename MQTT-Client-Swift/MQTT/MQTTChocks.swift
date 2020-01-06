//
//  MQTTChocks.swift
//  MQTT-Client-Swift
//
//  Created by Digital Testing on 11/06/19.
//  Copyright © 2019 Digital Testing. All rights reserved.
//

import Foundation

// MARK: - MqttChocks
class MqttChocks: Codable {
    let status: Bool
    let successMessage: String
    let data: DataClass
    
    init(status: Bool, successMessage: String, data: DataClass) {
        self.status = status
        self.successMessage = successMessage
        self.data = data
    }
}

// MARK: - DataClass
class DataClass: Codable {
    let flightSchedulesID, userID, resourceMappingID: Int
    let taskActualStartTime, taskActualEndTime: String
    let delayCodeMaster: DelayCodeMaster
    let taskName: String
    let delayStartTime, delayEndTime: Int
    let latitude, longitude: Double
    let flightType: Int
    let completed: Bool
    let taskCompletedCount: String?
    
    enum CodingKeys: String, CodingKey {
        case flightSchedulesID = "flightSchedulesId"
        case userID = "userId"
        case resourceMappingID = "resourceMappingId"
        case taskActualStartTime, taskActualEndTime, delayCodeMaster, taskName
        case delayStartTime = "delay_start_time"
        case delayEndTime = "delay_end_time"
        case latitude, longitude, flightType, completed, taskCompletedCount
    }
    
    init(flightSchedulesID: Int, userID: Int, resourceMappingID: Int, taskActualStartTime: String, taskActualEndTime: String, delayCodeMaster: DelayCodeMaster, taskName: String, delayStartTime: Int, delayEndTime: Int, latitude: Double, longitude: Double, flightType: Int, completed: Bool, taskCompletedCount: String?) {
        self.flightSchedulesID = flightSchedulesID
        self.userID = userID
        self.resourceMappingID = resourceMappingID
        self.taskActualStartTime = taskActualStartTime
        self.taskActualEndTime = taskActualEndTime
        self.delayCodeMaster = delayCodeMaster
        self.taskName = taskName
        self.delayStartTime = delayStartTime
        self.delayEndTime = delayEndTime
        self.latitude = latitude
        self.longitude = longitude
        self.flightType = flightType
        self.completed = completed
        self.taskCompletedCount = taskCompletedCount
    }
}

// MARK: - DelayCodeMaster
class DelayCodeMaster: Codable {
    let id: Int?
    
    init(id: Int?) {
        self.id = id
    }
}

