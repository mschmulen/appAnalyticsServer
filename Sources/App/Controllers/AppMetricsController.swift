//
//  AppMetricsController.swift
//  App
//
//  Created by Matthew Schmulen on 12/11/19.
//

import Vapor
import FluentSQLite
// import Leaf

struct LeafTopAppMetricModel: Codable {
    var appName: String
    var timeSpan: String
    var activeAppCount: Int
    var activeDeviceCount: String
    var activeEventCount: String
    var activeCrashCount: String
    
    var dailyActiveDevices:[Int]
    var dailyNewDevices:[Int]
    var dailyEvents:[Int]
    var dailyCrashs:[Int]
    var appVersionList:[String]

    init(
        appName:String,
        timeSpan:String,
        fromTimeString:String,

        activeAppCount:Int,
        activeDeviceCount:String,
        activeEventCount:String,
        activeCrashCount:String,
        
        dailyActiveDevices:[Int],
        dailyNewDevices:[Int],
        dailyEvents:[Int],
        dailyCrashs:[Int],
        
        appVersionList:[String]
    ) {
        self.appName = appName
        self.timeSpan = timeSpan
        self.activeAppCount = activeAppCount
        self.activeDeviceCount = activeDeviceCount
        self.activeEventCount = activeEventCount
        self.activeCrashCount = activeCrashCount
        
        self.dailyActiveDevices = dailyActiveDevices
        self.dailyNewDevices = dailyNewDevices
        self.dailyEvents = dailyEvents
        self.dailyCrashs = dailyCrashs
        self.appVersionList = appVersionList
    }
    
    static func make(timeSpan: TimeSpan, fromTimeString:String ) -> LeafTopAppMetricModel {
        
        return LeafTopAppMetricModel(
            appName: "",
            timeSpan: timeSpan.description,
            fromTimeString: fromTimeString,
            activeAppCount: 0,
            activeDeviceCount: "\(0)",
            activeEventCount: "\(0)",
            activeCrashCount: "\(0)",
            
            dailyActiveDevices: [11, 12, 13, 14, 15, 16, 17],
            dailyNewDevices: [1, 2, 3, 4, 5, 6, 7],
            dailyEvents: [1, 22, 23, 24, 25, 26, 27],
            dailyCrashs: [1, 22, 23, 24, 25, 26, 27],
            appVersionList:[
                "com.corp.app v1.3 (123)",
                "com.corp.app v1.4 (123)",
                "com.corp.app v1.5 (123)"
            ]
        )
    }
}

/// Controls for AppMetrics
final class AppMetricsController {
    
    // work in progress https://www.hackingwithswift.com/articles/156/vapor-leaf-templating-cheat-sheet
    
    func metricsMinute(_ req: Request) throws -> Future<View> {
        
        let timeSpan:TimeSpan = TimeSpan.minute
        
        guard let filterTimeString = timeSpan.requestString else {
            throw Abort(.notFound)
        }
        var leafModel = LeafTopAppMetricModel.make(
            timeSpan: timeSpan,
            fromTimeString:filterTimeString
        )
        
        print("filterTimeString \(filterTimeString)")
        
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all().flatMap(to: View.self) { devices in
            
            leafModel.activeDeviceCount = "\(devices.count)"
            
            return AppInfo.query(on: req).all().flatMap(to: View.self) { apps in
                
                leafModel.activeAppCount = apps.count
                if apps.count == 0 {
                    leafModel.appVersionList = ["~"]
                } else {
                    leafModel.appVersionList = []
                }
                for appInfo in apps {
                    let recordInfo = " \(appInfo.deviceSystemName): \(appInfo.appVersion)(\(appInfo.appBuild)), lastUpdate: \(appInfo.lastUpdateTime)"
                    leafModel.appVersionList.append(recordInfo)
                }
                
                // return AppEvent.query(on: req).all().flatMap(to: View.self) { events in
                return AppEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { events in
                    
                    leafModel.activeEventCount = "\(events.count)"
                    leafModel.dailyEvents = []
                    leafModel.dailyEvents.append( events.count )
                    leafModel.dailyEvents.append( 0 )
                    leafModel.dailyEvents.append( 0 )
                    
                    // AppCrashEvent
                    return AppCrashEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { crashEvents in
                        
                        leafModel.activeCrashCount = "\(crashEvents.count)"
                        leafModel.dailyCrashs = []
                        leafModel.dailyCrashs.append( crashEvents.count )
                        leafModel.dailyCrashs.append( 0 )
                        leafModel.dailyCrashs.append( 0 )
                        
                        return try req.view().render( "metrics", leafModel)
                    }
                }
            }
            // let context = IndexContext(title: "Home page", acronyms: modelsData)
            // return try req.view().render("index", context)
        }
        // return try req.view().render("metrics", ["span": "metrics"])
    }

}

extension AppMetricsController {

    func metricsDay(_ req: Request) throws -> Future<View> {
        
        let timeSpan:TimeSpan = TimeSpan.day
        
        guard let filterTimeString = timeSpan.requestString else {
            throw Abort(.notFound)
        }
        var leafModel = LeafTopAppMetricModel.make(
            timeSpan: timeSpan,
            fromTimeString:filterTimeString
        )
        
        print("filterTimeString \(filterTimeString)")
        
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all().flatMap(to: View.self) { devices in
            
            leafModel.activeDeviceCount = "\(devices.count)"
            
            return AppInfo.query(on: req).all().flatMap(to: View.self) { apps in
                
                leafModel.activeAppCount = apps.count
                if apps.count == 0 {
                    leafModel.appVersionList = ["~"]
                } else {
                    leafModel.appVersionList = []
                }
                for appInfo in apps {
                    let recordInfo = " \(appInfo.deviceSystemName): \(appInfo.appVersion)(\(appInfo.appBuild)), lastUpdate: \(appInfo.lastUpdateTime)"
                    leafModel.appVersionList.append(recordInfo)
                }
                
                // return AppEvent.query(on: req).all().flatMap(to: View.self) { events in
                return AppEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { events in
                    
                    leafModel.activeEventCount = "\(events.count)"
                    leafModel.dailyEvents = []
                    leafModel.dailyEvents.append( events.count )
                    leafModel.dailyEvents.append( 0 )
                    leafModel.dailyEvents.append( 0 )
                    
                    // AppCrashEvent
                    return AppCrashEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { crashEvents in
                        
                        leafModel.activeCrashCount = "\(crashEvents.count)"
                        leafModel.dailyCrashs = []
                        leafModel.dailyCrashs.append( crashEvents.count )
                        leafModel.dailyCrashs.append( 0 )
                        leafModel.dailyCrashs.append( 0 )
                        
                        return try req.view().render( "metrics", leafModel)
                    }
                }
            }
        }
    }
}

extension AppMetricsController {
    
    func metricsMonth(_ req: Request) throws -> Future<View> {
        
        let timeSpan:TimeSpan = TimeSpan.month
        
        guard let filterTimeString = timeSpan.requestString else {
            throw Abort(.notFound)
        }
        var leafModel = LeafTopAppMetricModel.make(
            timeSpan: timeSpan,
            fromTimeString:filterTimeString
        )
        
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all().flatMap(to: View.self) { devices in
            
            leafModel.activeDeviceCount = "\(devices.count)"
            
            return AppInfo.query(on: req).all().flatMap(to: View.self) { apps in
                
                leafModel.activeAppCount = apps.count
                if apps.count == 0 {
                    leafModel.appVersionList = ["~"]
                } else {
                    leafModel.appVersionList = []
                }
                for appInfo in apps {
                    let recordInfo = " \(appInfo.deviceSystemName): \(appInfo.appVersion)(\(appInfo.appBuild)), lastUpdate: \(appInfo.lastUpdateTime)"
                    leafModel.appVersionList.append(recordInfo)
                }
                
                // return AppEvent.query(on: req).all().flatMap(to: View.self) { events in
                return AppEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { events in
                    
                    leafModel.activeEventCount = "\(events.count)"
                    leafModel.dailyEvents = []
                    
                    // TODO break up the events based on day
                    leafModel.dailyEvents.append( events.count )
                    leafModel.dailyEvents.append( 0 )
                    leafModel.dailyEvents.append( 0 )
                    
                    
                    // AppCrashEvent
                    return AppCrashEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { crashEvents in
                        
                        leafModel.activeCrashCount = "\(crashEvents.count)"
                        leafModel.dailyCrashs = []
                        // TODO break up the events based on day
                        leafModel.dailyCrashs.append( crashEvents.count )
                        leafModel.dailyCrashs.append( 0 )
                        leafModel.dailyCrashs.append( 0 )
                        
                        return try req.view().render( "metrics", leafModel)
                    }
                }
            }
        }
    }
}

    
    // get all the events for a specific day
//    func eventsForSpecificDay(_ req: Request, day:Date) throws -> Future<[AppEvent]> {
//
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//
//        guard let calendarDayBefore = Calendar.current.date(byAdding: .day, value: 0, to: day) else {
//            throw Abort(.notFound)
//        }
//        let filterComponentsBefore = DateComponents(
//            calendar: calendar,
//            timeZone: TimeZone(identifier: "UTC")!,
//            era: nil,
//            year: calendar.component(.year, from: calendarDayBefore),
//            month: calendar.component(.month, from: calendarDayBefore),
//            day: calendar.component(.day, from: calendarDayBefore),
//            hour: calendar.component(.hour, from: calendarDayBefore),
//            minute: calendar.component(.minute, from: calendarDayBefore),
//            second: calendar.component(.second, from: calendarDayBefore),
//            nanosecond: 0,
//            weekday: nil,
//            weekdayOrdinal: nil,
//            quarter: nil,
//            weekOfMonth: nil,
//            weekOfYear: nil,
//            yearForWeekOfYear: nil
//        )
//
//        guard let calendarDayAfter = Calendar.current.date(byAdding: .day, value: -1, to: day) else {
//            throw Abort(.notFound)
//        }
//        let filterComponentsAfter = DateComponents(
//            calendar: calendar,
//            timeZone: TimeZone(identifier: "UTC")!,
//            era: nil,
//            year: calendar.component(.year, from: calendarDayAfter),
//            month: calendar.component(.month, from: calendarDayAfter),
//            day: calendar.component(.day, from: calendarDayAfter),
//            hour: calendar.component(.hour, from: calendarDayAfter),
//            minute: calendar.component(.minute, from: calendarDayAfter),
//            second: calendar.component(.second, from: calendarDayAfter),
//            nanosecond: 0,
//            weekday: nil,
//            weekdayOrdinal: nil,
//            quarter: nil,
//            weekOfMonth: nil,
//            weekOfYear: nil,
//            yearForWeekOfYear: nil
//        )
//
//        let filterTimeStringBefore = "\(filterComponentsBefore.date!)"
//        let filterTimeStringAfter = "\(filterComponentsAfter.date!)"
//        // TODO incorporate the filterTimeStringAfter component
//        return AppEvent.query(on: req).filter(\.creationTime > filterTimeStringBefore).all()
//    }
    

