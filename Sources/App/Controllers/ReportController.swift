//
//  ReportController.swift
//  App
//
//  Created by Matthew Schmulen on 12/18/19.
//

import Vapor
import FluentSQLite

// MAS TOOD Reports

// newDevices : devices created in the activeTimeSpan
// activeDevices : devices udpated in the activeTimeSpan

// activeApps : apps with an update in the activeTimeSpan

// activeCrashs : crashes created in the activeTimeSpan
// activeDevicesWithACrash: active devices that have a crash : devices with a crash in the activeTimeSpan

// crashFreeUsers = activeDevices/activeDevicesWithACrash

/// Repor Controller
final class ReportController {
    
    let activeTimeSpan:TimeSpan = .day
    
    /// devices active over the past day
    func dailyActiveDeviceList(_ req: Request) throws -> Future<[AppDevice]> {
        guard let filterTimeString = activeTimeSpan.requestString else {
            throw Abort(.notFound)
        }
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all()
    }
    
}
