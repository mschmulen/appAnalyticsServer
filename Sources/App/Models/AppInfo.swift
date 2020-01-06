import FluentSQLite
import Vapor

/// A single entry of a AppInfo list.
final class AppInfo: SQLiteModel {
    
    /// The unique identifier for this `model`.
    var id: Int?
    
    ///  BundleIdentifier "CFBundleIdentifier" of the app example: "com.company.appName"
    var appIdentifier: String
    
    /// short version "CFBundleShortVersionString" example: "1.1"
    var appVersion:String
    
    /// deviceSystemName for apple iOS productsss: example "iOS"
    var deviceSystemName:String
    
    /// appBuild: "CFBundleVersion" example: 333
    var appBuild:String
    
    /// locally created hash of the app for identifying the same app based on
    /// appHash = deviceSystemName + appIdentifier + appVersion
    /// appHash = "iOS" + "com.corp.AnalyticsSwiftUIExample" + "1.1"
    /// it may be better not to include the appBuild "4" number
    var appHash:Int
    
    /// last time this was updated by a mobile client
    var lastUpdateTime:String
    
    /// Creates a new `model`.
    init(
        id: Int? = nil,
        appIdentifier: String,
        appVersion:String,
        deviceSystemName:String,
        appBuild:String,
        lastUpdateTime:String
    ) {
        self.id = id
        self.appIdentifier = appIdentifier
        self.appVersion = appVersion
        self.deviceSystemName = deviceSystemName
        self.appBuild = appBuild
        self.lastUpdateTime = lastUpdateTime
        let hashString = deviceSystemName + appIdentifier + appVersion
        self.appHash = hashString.hashValue
    }
}

/// Allows `AppInfo` to be used as a dynamic migration.
extension AppInfo: Migration {
    
    /// prepare migration
    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
        return Database.create(self, on: connection) { (schemaCreator) in
            try addProperties(to: schemaCreator)
            schemaCreator.unique(on: \.appHash)
        }
    }
    
}

/// Allows `AppInfo` to be encoded to and decoded from HTTP messages.
extension AppInfo: Content { }

/// Allows `AppInfo` to be used as a dynamic parameter in route definitions.
extension AppInfo: Parameter { }
