import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `AppDevice`s.
final class AppDeviceController {
    
        /// Returns a list of all `AppDevice`s.
    //    func index(_ req: Request) throws -> Future<[AppDevice]> {
    //        // return AppDevice.query(on: req).all()
    //        return AppDevice.query(on: req).sort(\.lastDeviceUpdateTime, .descending).all()
    //    }
    
    /**
     GET http://localhost:8080/api/devices?limit=20&page=10
     */
    func getAllPaginatedHandler(_ req: Request) throws -> Future<[AppDevice]> {
        //return try AppDevice.query(on: req).paginate(on: req).all()
        return try AppDevice.query(on: req).sort(\.lastDeviceUpdateTime, .descending).paginate(on: req).all()
    }
    
    /// Saves a decoded `AppDevice` to the database.
    func create(_ req: Request) throws -> Future<AppDevice> {
        
        return try req.content.decode(AppDevice.self).flatMap { model in
            
            return AppDevice.query(on: req).filter(\.appleIdentifierForVendor == model.appleIdentifierForVendor).first().flatMap { (existingDevice) -> EventLoopFuture<AppDevice> in
                
                if existingDevice == nil {
                    // device does not exist so create it
                    return model.save(on: req)
                } else {
                    // Update any of the transient properties of the device record
                    existingDevice!.deviceName = model.deviceName
                    existingDevice!.deviceSystemVersion = model.deviceSystemVersion
                    existingDevice!.lastDeviceUpdateTime = model.lastDeviceUpdateTime
                    return existingDevice!.save(on: req)
                }
            }
            // return model.save(on: req)
        }
    }

    /// Deletes a parameterized `AppDevice`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AppDevice.self).flatMap { model in
            return model.delete(on: req)
        }.transform(to: .ok)
    }
}

extension AppDeviceController {
    
    /// devices active over the past month
    func monthlyActiveDeviceList(_ req: Request) throws -> Future<[AppDevice]> {
        
        let nowDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: -1, to: nowDate) else {
            throw Abort(.notFound)
        }
        
        let filterComponents = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(identifier: "UTC")!,
            era: nil,
            year: calendar.component(.year, from: oneMonthFromNow),
            month: calendar.component(.month, from: oneMonthFromNow),
            day: calendar.component(.day, from: oneMonthFromNow),
            hour: calendar.component(.hour, from: oneMonthFromNow),
            minute: calendar.component(.minute, from: oneMonthFromNow),
            second: calendar.component(.second, from: oneMonthFromNow),
            nanosecond: 0,
            weekday: nil,
            weekdayOrdinal: nil,
            quarter: nil,
            weekOfMonth: nil,
            weekOfYear: nil,
            yearForWeekOfYear: nil
        )
        
        let filterTimeString = "\(filterComponents.date!)"
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all()
    }
    
    /// devices active over the past day
    func dailyActiveDeviceList(_ req: Request) throws -> Future<[AppDevice]> {
        
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        guard let oneDayFromNow = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            throw Abort(.notFound)
        }
        
        let filterComponents = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(identifier: "UTC")!,
            era: nil,
            year: calendar.component(.year, from: oneDayFromNow),
            month: calendar.component(.month, from: oneDayFromNow),
            day: calendar.component(.day, from: oneDayFromNow),
            hour: calendar.component(.hour, from: oneDayFromNow),
            minute: calendar.component(.minute, from: oneDayFromNow),
            second: calendar.component(.second, from: oneDayFromNow),
            nanosecond: 0,
            weekday: nil,
            weekdayOrdinal: nil,
            quarter: nil,
            weekOfMonth: nil,
            weekOfYear: nil,
            yearForWeekOfYear: nil
        )
        
        let filterTimeString = "\(filterComponents.date!)"
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all()
    }
    
    /// devices active over the past month
    func deviceActiveMetrics(_ req: Request) throws -> Future<[AppDevice]> {
        
        let nowDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: -1, to: nowDate) else {
            throw Abort(.notFound)
        }
        
        let filterComponents = DateComponents(
            calendar: calendar,
            timeZone: TimeZone(identifier: "UTC")!,
            era: nil,
            year: calendar.component(.year, from: oneMonthFromNow),
            month: calendar.component(.month, from: oneMonthFromNow),
            day: calendar.component(.day, from: oneMonthFromNow),
            hour: calendar.component(.hour, from: oneMonthFromNow),
            minute: calendar.component(.minute, from: oneMonthFromNow),
            second: calendar.component(.second, from: oneMonthFromNow),
            nanosecond: 0,
            weekday: nil,
            weekdayOrdinal: nil,
            quarter: nil,
            weekOfMonth: nil,
            weekOfYear: nil,
            yearForWeekOfYear: nil
        )
        
        let filterTimeString = "\(filterComponents.date!)"
        return AppDevice.query(on: req).filter(\.lastDeviceUpdateTime > filterTimeString).all()
    }
    
}

// https://vaporforums-backend.herokuapp.com/viewThread/37

//func getByDate(_ request: Request) throws -> Future<[Post]> {
//    let day = 13, month = 3, year = 2018
//    let components = DateComponents(calendar: Calendar.current, timeZone: nil, era: nil, year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
//    guard let marchThirteenth = components.date else { throw Abort.init(HTTPStatus.badRequest, reason: "invalid date", identifier: nil)}
//    return Post.query(on: request).filter(\Post.created_at > marchThirteenth).all()
//}

//func sortByDate(_ request: Request) throws -> Future<[Post]> {
//    let queryField = QueryField(name: "created_at") // 1
//    let querySort = QuerySort(field: queryField, direction: QuerySortDirection.descending) // 2
//    return Post.query(on: request).sort(querySort).all() // 3
//}
