//
//  AppCrashEventController.swift
//  App
//
//  Created by Matthew Schmulen on 12/16/19.
//

import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `AppCrashEvent`s.
final class AppCrashEventController {
    
    /**
     get with pagination
     GET:
     http://localhost:8080/crashs?limit=20&page=10
     http://localhost:8080/crashs?limit=20&page=10&appleIdentifierForVendor=FC92423C-64EC-406C-AAAD-9201172B5D30
     http://localhost:8080/crashs?limit=20&page=10&appIdentifier=com.corp.AnalyticsSwiftUIExample&appVersion=1.2
     
     */
    func getAllPaginatedWithOptionalFilterHandler(_ req: Request) throws -> Future<[AppCrashEvent]> {
        let appleIdentifierForVendorValue = try? req.query.get(String.self, at: "appleIdentifierForVendor")
        let appIdentifierValue = try? req.query.get(String.self, at: "appIdentifier")
        let appVersionValue = try? req.query.get(String.self, at: "appVersion")
        
        //var query = AppCrashEvent.query(on: req)
        var query = AppCrashEvent.query(on: req).sort(\.creationTime, .descending)
        
        if let appleIdentifierForVendorValue = appleIdentifierForVendorValue {
            query = AppCrashEvent.query(on: req)
                .filter(\.appleIdentifierForVendor == appleIdentifierForVendorValue)
        }
        
        if let appIdentifierValue = appIdentifierValue {
            query = AppCrashEvent.query(on: req)
                .filter(\.appIdentifier == appIdentifierValue)
            
            if let appVersionValue = appVersionValue {
                query = AppCrashEvent.query(on: req)
                    .filter(\.appIdentifier == appIdentifierValue)
                    .filter(\.appVersion == appVersionValue)
            }
        }
        return try query.paginate(on: req).all()
    }
    
    //    func getAllPaginatedHandler(_ req: Request) throws -> Future<[AppCrashEvent]> {
    //      return try AppCrashEvent.query(on: req).paginate(on: req).all()
    //        // return try AppCrashEvent.query(on: req).sort(\.creationTime, .descending).paginate(on: req).all()
    //    }
    
    /**
     events by deviceIDFA
     events\{deviceIDFA}
     test url: http://localhost:8080/crashs/762498C5-ED8C-4479-8577-EB84A4A1E6AB
     supports pagination
     GET http://localhost:8080/crashs/762498C5-ED8C-4479-8577-EB84A4A1E6AB?limit=20&page=10
     */
    //    func extendedIDFAQuery(_ req: Request) throws -> Future<[AppCrashEvent]> {
    //        let deviceIDFA = try req.parameters.next(String.self)
    //        return try AppCrashEvent.query(on: req).filter(\.appleIdentifierForVendor == deviceIDFA).paginate(on: req).all()
    //    }
    
//    func extendedAppIdentifierQuery(_ req: Request) throws -> Future<[AppCrashEvent]> {
//        let appIdentifier = try req.parameters.next(String.self)
//        return try AppCrashEvent.query(on: req).filter(\.appIdentifier == appIdentifier).paginate(on: req).all()
//    }
    
    
    /// Returns a list of all `AppEvent`s.
    func index(_ req: Request) throws -> Future<[AppCrashEvent]> {
        // return AppEvent.query(on: req).all()
        return AppCrashEvent.query(on: req).sort(\.creationTime, .descending).all()
    }
    
    /// Saves a decoded `AppCrashEvent` to the database.
    func create(_ req: Request) throws -> Future<AppCrashEvent> {
        return try req.content.decode(AppCrashEvent.self).flatMap { model in
            
            //drop any
            return AppCrashEvent.query(on: req).filter(\.localDeviceEventUUID == model.localDeviceEventUUID).first().flatMap { (existingModel) -> EventLoopFuture<AppCrashEvent> in
                
                if existingModel == nil {
                    // event does not exist so create it
                    return model.save(on: req)
                } else {
                    // Update any of the transient properties of the device record
                    return existingModel!.save(on: req)
                    //return existingModel!.willRead(on: req)
                }
            }
            //return model.save(on: req)
        }
    }
    
    /// Deletes a parameterized `AppCrashEvent`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AppCrashEvent.self).flatMap { model in
            return model.delete(on: req)
        }.transform(to: .ok)
    }
}

