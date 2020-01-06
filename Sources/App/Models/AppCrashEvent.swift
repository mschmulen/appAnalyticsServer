//
//  AppCrashEvent.swift
//  App
//
//  Created by Matthew Schmulen on 12/16/19.
//

import FluentSQLite
import Vapor

/// A single entry of a AppEvent list.
final class AppCrashEvent: SQLiteModel {
    
    /// The unique identifier for this `AppEvent`.
    var id: Int?
    
    /// crashType
    var crashType: String
    
    /// name
    var name: String
    
    /// reason
    var reason: String
    
    /// appInfo
    var appInfo: String
    
    /// callStack
    var callStack: String
    
    /// the date time string of when the event was initially created on the device
    var creationTime:String
    
    /// local device UUID to prevent app from sending duplicate events
    var localDeviceEventUUID: UUID
    
    /// local apple device IDFV
    var appleIdentifierForVendor: String
    
    var appIdentifier: String
    
    var appVersion: String
    
    var appBuildNumber: String

    var appUserIdentifier: String
    
    /// Creates a new `AppEvent`.
    init(id: Int? = nil,
         crashType: String,
         name: String,
         reason: String,
         appInfo: String,
         callStack: String,
         creationTime: String,
         localDeviceEventUUID: UUID,
         appleIdentifierForVendor: String,
         appIdentifier: String,
         appVersion: String,
         appBuildNumber: String,
         appUserIdentifier: String
    ) {
        self.id = id
        self.crashType = crashType
        self.name = name
        self.reason = reason
        self.appInfo = appInfo
        self.callStack = callStack
        self.creationTime = creationTime
        self.localDeviceEventUUID = localDeviceEventUUID
        self.appleIdentifierForVendor = appleIdentifierForVendor
        self.appIdentifier = appIdentifier
        self.appVersion = appVersion
        self.appBuildNumber = appBuildNumber
        self.appUserIdentifier = appUserIdentifier
    }
}

/// Allows `AppCrashEvent` to be used as a dynamic migration.
extension AppCrashEvent: Migration {
    
//    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
//        return Database.create(self, on: connection) { (schemaCreator) in
//            try addProperties(to: schemaCreator)
//            schemaCreator.unique(on: \.localDeviceEventUUID)
//        }
//    }
    
}

/// Allows `AppCrashEvent` to be encoded to and decoded from HTTP messages.
extension AppCrashEvent: Content { }

/// Allows `AppCrashEvent` to be used as a dynamic parameter in route definitions.
extension AppCrashEvent: Parameter { }
