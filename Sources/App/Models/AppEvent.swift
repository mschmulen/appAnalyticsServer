import FluentSQLite
import Vapor

/// A single entry of a AppEvent list.
final class AppEvent: SQLiteModel {
    
    /// The unique identifier for this `AppEvent`.
    var id: Int?
    
    /// A name describing what this `AppEvent` entails.
    var name: String
    
    /// when the event was created on the device
    var creationTime: String
    
    /// local device UUID to prevent app from sending duplicate events
    var localDeviceEventUUID: UUID
    
    /// local apple device IDFV
    // var deviceIDFV: String
    var appleIdentifierForVendor: String
    
    /// appIdentifier example com.org.appName
    var appIdentifier: String
    
    /// appVersion example: 3.12
    var appVersion: String
    
    /// appBuildNumber incrimenting build number for a given appVersion example: 333
    var appBuildNumber: String
    
    /// app provided meta data
    var appMetaData: [String: String]
    
    /// internal protected meta data inserted by the framework
    var protectedMetaData: [String: String]
    
    var appUserIdentifier: String
    
    /// Creates a new `AppEvent`.
    init(id: Int? = nil,
         name: String,
         creationTime: String,
         localDeviceEventUUID: UUID,
         appleIdentifierForVendor:String,
         appIdentifier:String,
         appVersion:String,
         appBuildNumber:String,
         protectedMetaData:[String:String],
         appMetaData:[String:String],
         appUserIdentifier: String
    ) {
        self.id = id
        self.name = name
        self.creationTime = creationTime
        self.localDeviceEventUUID = localDeviceEventUUID
        self.appleIdentifierForVendor = appleIdentifierForVendor
        self.appIdentifier = appIdentifier
        self.appVersion = appVersion
        self.appBuildNumber = appBuildNumber
        self.protectedMetaData = protectedMetaData
        self.appMetaData = appMetaData
        self.appUserIdentifier = appUserIdentifier
    }
}

/// Allows `AppEvent` to be used as a dynamic migration.
extension AppEvent: Migration {
    
    /// prepare migration
    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
        return Database.create(self, on: connection) { (schemaCreator) in
            try addProperties(to: schemaCreator)
            schemaCreator.unique(on: \.localDeviceEventUUID)
        }
    }
}

/// Allows `AppEvent` to be encoded to and decoded from HTTP messages.
extension AppEvent: Content { }

/// Allows `AppEvent` to be used as a dynamic parameter in route definitions.
extension AppEvent: Parameter { }
