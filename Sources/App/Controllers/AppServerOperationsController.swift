//
//  AppServerOperationsController.swift
//  App
//
//  Created by Matthew Schmulen on 12/16/19.
//

import Vapor
import FluentSQLite

/// Controls for App Server Operations
final class AppServerOperationsController {

    func flushAllEventsFromLocalServer(_ req: Request) throws -> Future<HTTPStatus> {
        return AppEvent.query(on: req).delete().transform(to: .ok)
    }
    
    func deletAllEvents(_ req: Request) throws -> Future<HTTPStatus> {
        return AppEvent.query(on: req).delete().transform(to: .ok)
    }
    
    func deletAllDevices(_ req: Request) throws -> Future<HTTPStatus> {
        return AppDevice.query(on: req).delete().transform(to: .ok)
    }

    func deletAllApps(_ req: Request) throws -> Future<HTTPStatus> {
        return AppInfo.query(on: req).delete().transform(to: .ok)
    }

    func deletAllCrashs(_ req: Request) throws -> Future<HTTPStatus> {
        return AppCrashEvent.query(on: req).delete().transform(to: .ok)
    }
    
    
    func flushOldEventsFromLocalServer(_ req: Request) throws -> Future<HTTPStatus> {
        
        let timeSpan:TimeSpan = TimeSpan.minute
        
        guard let filterTimeStringBefore = timeSpan.requestString else {
            throw Abort(.notFound)
        }
        print( "flushOldEvents  .creationTime < \(filterTimeStringBefore)")
        return AppEvent.query(on: req).filter(\.creationTime < filterTimeStringBefore).delete().transform(to: .ok)
    }
    


    
//    func metrics(_ req: Request) throws -> Future<View> {
//
//        // let span:TimeSpan = .day
//        var leafModel = LeafTopAppMetricModel.makeDay
//
//        // ---------------------------
//        // setup date stuff
//        let nowDate = Date()
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//
//        guard let oneDayFromNowDate = Calendar.current.date(byAdding: .day, value: -1, to: nowDate) else {
//            throw Abort(.notFound)
//        }
//
//        let filterComponentsAfter = DateComponents(
//            calendar: calendar,
//            timeZone: TimeZone(identifier: "UTC")!,
//            era: nil,
//            year: calendar.component(.year, from: oneDayFromNowDate),
//            month: calendar.component(.month, from: oneDayFromNowDate),
//            day: calendar.component(.day, from: oneDayFromNowDate),
//            hour: calendar.component(.hour, from: oneDayFromNowDate),
//            minute: calendar.component(.minute, from: oneDayFromNowDate),
//            second: calendar.component(.second, from: oneDayFromNowDate),
//            nanosecond: 0,
//            weekday: nil,
//            weekdayOrdinal: nil,
//            quarter: nil,
//            weekOfMonth: nil,
//            weekOfYear: nil,
//            yearForWeekOfYear: nil
//        )
//        let filterTimeString = "\(filterComponentsAfter.date!)"
//        // ---------------------------
//
//
//        // return AppDevice.query(on: req).all().flatMap(to: View.self) { devices in
//        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all().flatMap(to: View.self) { devices in
//
//            leafModel.activeDeviceCount = "\(devices.count)"
//
//            return AppInfo.query(on: req).all().flatMap(to: View.self) { apps in
//
//                leafModel.activeAppCount = apps.count
//                if apps.count == 0 {
//                    leafModel.appVersionList = ["~"]
//                } else {
//                    leafModel.appVersionList = []
//                }
//                for appInfo in apps {
//                    let recordInfo = " \(appInfo.deviceSystemName): \(appInfo.appVersion)(\(appInfo.appBuild)), lastUpdate: \(appInfo.lastUpdateTime)"
//                    leafModel.appVersionList.append(recordInfo)
//                }
//
//                // return AppEvent.query(on: req).all().flatMap(to: View.self) { events in
//                return AppEvent.query(on: req).filter(\.creationTime > filterTimeString).all().flatMap(to: View.self) { events in
//
//                    leafModel.activeEventCount = "\(events.count)"
//                    leafModel.dailyEvents = []
//                    leafModel.dailyEvents.append( events.count )
//                    leafModel.dailyEvents.append( 0 )
//                    leafModel.dailyEvents.append( 0 )
//
//                    // TODO break up the events based on day
//
//                    return try req.view().render( "metrics", leafModel)
//                }
//            }
//            // let context = IndexContext(title: "Home page", acronyms: modelsData)
//            // return try req.view().render("index", context)
//        }
//        // return try req.view().render("metrics", ["span": "metrics"])
//    }

}

extension AppMetricsController {
    
    /// Returns monthlyMetrics
//    func monthlyMetrics(_ req: Request) throws -> Future<[AppDevice]> {
//        
//        let nowDate = Date()
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//        
//        guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: -1, to: nowDate) else {
//            throw Abort(.notFound)
//        }
//        
//        let filterComponents = DateComponents(
//            calendar: calendar,
//            timeZone: TimeZone(identifier: "UTC")!,
//            era: nil,
//            year: calendar.component(.year, from: oneMonthFromNow),
//            month: calendar.component(.month, from: oneMonthFromNow),
//            day: calendar.component(.day, from: oneMonthFromNow),
//            hour: calendar.component(.hour, from: oneMonthFromNow),
//            minute: calendar.component(.minute, from: oneMonthFromNow),
//            second: calendar.component(.second, from: oneMonthFromNow),
//            nanosecond: 0,
//            weekday: nil,
//            weekdayOrdinal: nil,
//            quarter: nil,
//            weekOfMonth: nil,
//            weekOfYear: nil,
//            yearForWeekOfYear: nil
//        )
//        
//        let filterTimeString = "\(filterComponents.date!)"
//        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all()
//    }
    
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
    
}


//    func deviceActiveMetrics(_ req: Request) throws -> Future<[AppDevice]> {
//
//        let nowDate = Date()
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(identifier: "UTC")!
//
//        guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: -1, to: nowDate) else {
//            throw Abort(.notFound)
//        }
//
//        let filterComponents = DateComponents(
//            calendar: calendar,
//            timeZone: TimeZone(identifier: "UTC")!,
//            era: nil,
//            year: calendar.component(.year, from: oneMonthFromNow),
//            month: calendar.component(.month, from: oneMonthFromNow),
//            day: calendar.component(.day, from: oneMonthFromNow),
//            hour: calendar.component(.hour, from: oneMonthFromNow),
//            minute: calendar.component(.minute, from: oneMonthFromNow),
//            second: calendar.component(.second, from: oneMonthFromNow),
//            nanosecond: 0,
//            weekday: nil,
//            weekdayOrdinal: nil,
//            quarter: nil,
//            weekOfMonth: nil,
//            weekOfYear: nil,
//            yearForWeekOfYear: nil
//        )
//
//        let filterTimeString = "\(filterComponents.date!)"
//        return AppDevice.query(on: req).filter(\.lastUpdateTime > filterTimeString).all()
//    }
    
