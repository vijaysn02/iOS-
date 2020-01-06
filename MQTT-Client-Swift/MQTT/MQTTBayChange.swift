//
//  MQTTBayChange.swift
//  MQTT-Client-Swift
//
//  Created by Digital Testing on 11/06/19.
//  Copyright © 2019 Digital Testing. All rights reserved.
//

import Foundation

// MARK: - MQTTBayChange
class MqttBayChange: Codable {
    let data: BayDataClass?
    let status: Bool?
    
    init(data: BayDataClass?, status: Bool?) {
        self.data = data
        self.status = status
    }
}

// MARK: - BayDataClass
class BayDataClass: Codable {
    let id, estimatedArrivalTime, estimatedDepartureTime, actualArrivalTime: Int?
    let actualDepartureTime: Int?
    let taskScheduleID, bayID, equipmentID, equipmentTypeID: ID?
    let modifiedBy: Int?
    let active: String?
    let etaChanged, ataChanged, etdChanged, atdChanged: Bool?
    let etaFlag, ataWeb, atdWeb, bayChanged: Bool?
    let airport: String?
    let from, to, station: Int?
    let bayObj, previousBay: BayObj?
    
    enum CodingKeys: String, CodingKey {
        case id, estimatedArrivalTime, estimatedDepartureTime, actualArrivalTime, actualDepartureTime
        case taskScheduleID = "taskScheduleId"
        case bayID = "bayId"
        case equipmentID = "equipmentId"
        case equipmentTypeID = "equipmentTypeId"
        case modifiedBy, active, etaChanged, ataChanged, etdChanged, atdChanged
        case etaFlag = "eta_flag"
        case ataWeb, atdWeb
        case bayChanged = "bay_changed"
        case airport, from, to, station, bayObj
        case previousBay = "previous_bay"
    }
    
    init(id: Int?, estimatedArrivalTime: Int?, estimatedDepartureTime: Int?, actualArrivalTime: Int?, actualDepartureTime: Int?, taskScheduleID: ID?, bayID: ID?, equipmentID: ID?, equipmentTypeID: ID?, modifiedBy: Int?, active: String?, etaChanged: Bool?, ataChanged: Bool?, etdChanged: Bool?, atdChanged: Bool?, etaFlag: Bool?, ataWeb: Bool?, atdWeb: Bool?, bayChanged: Bool?, airport: String?, from: Int?, to: Int?, station: Int?, bayObj: BayObj?, previousBay: BayObj?) {
        self.id = id
        self.estimatedArrivalTime = estimatedArrivalTime
        self.estimatedDepartureTime = estimatedDepartureTime
        self.actualArrivalTime = actualArrivalTime
        self.actualDepartureTime = actualDepartureTime
        self.taskScheduleID = taskScheduleID
        self.bayID = bayID
        self.equipmentID = equipmentID
        self.equipmentTypeID = equipmentTypeID
        self.modifiedBy = modifiedBy
        self.active = active
        self.etaChanged = etaChanged
        self.ataChanged = ataChanged
        self.etdChanged = etdChanged
        self.atdChanged = atdChanged
        self.etaFlag = etaFlag
        self.ataWeb = ataWeb
        self.atdWeb = atdWeb
        self.bayChanged = bayChanged
        self.airport = airport
        self.from = from
        self.to = to
        self.station = station
        self.bayObj = bayObj
        self.previousBay = previousBay
    }
}

// MARK: - ID
class ID: Codable {
    let id: Int?
    
    init(id: Int?) {
        self.id = id
    }
}

// MARK: - BayObj
class BayObj: Codable {
    let id: Int?
    let bayCode: String?
    let bayType: Int?
    let airportID: ID?
    
    enum CodingKeys: String, CodingKey {
        case id, bayCode, bayType
        case airportID = "airportId"
    }
    
    init(id: Int?, bayCode: String?, bayType: Int?, airportID: ID?) {
        self.id = id
        self.bayCode = bayCode
        self.bayType = bayType
        self.airportID = airportID
    }
}
