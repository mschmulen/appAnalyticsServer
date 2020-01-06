import FluentSQLite
import Vapor

/// A single entry of a AppDevice list.
final class AppDevice: SQLiteModel {
    
    /// The unique identifier for this `model`.
    var id: Int?
    
    /// apple identifierForVendor
    ///  https://developer.apple.com/documentation/uikit/uidevice/1620059-identifierforvendor
    ///  example: "6295E1E9-BA0D-4531-A2E9-08D3BD45B884"
    var appleIdentifierForVendor: String
    
    /// apple identifierForAdvertiser
    /// Note: when a user enables “Limit Ad Tracking,” the OS will send along the advertising identifier with a new value of “00000000-0000-0000-0000-000000000000”
    /// https://developer.apple.com/documentation/adsupport/asidentifiermanager
    var appleIdentifierForAdvertiser: String
    
    /// device system version example: "13.2.2"
    var deviceSystemVersion:String
    
    /// device model example: "iPhone"
    var deviceModel:String
    
    /// localized device model name example: "iPhone"
    var deviceLocalizedModel:String
    
    /// local name of the device something like "Matts iPhone8"
    var deviceName:String
    
    /// device system name example : "iOS"
    var deviceSystemName:String
    
    /// example : "0"
    var deviceUserInterfaceIdiom:Int
    
    /// last time this was updated by a mobile client
    var lastDeviceUpdateTime:String
    
    var deviceCreationTime:String
    
    var appUserIdentifier:String
    
    /// Creates a new `model`.
    init(id: Int? = nil,
         identifierForVendor: String,
         identifierForAdvertiser: String,
         deviceSystemVersion:String,
         deviceModel:String,
         deviceLocalizedModel:String,
         deviceName:String,
         deviceSystemName:String,
         deviceUserInterfaceIdiom:Int,
         lastDeviceUpdateTime:String,
         deviceCreationTime:String,
         appUserIdentifier:String
    ) {
        self.id = id
        self.appleIdentifierForVendor = identifierForVendor
        self.appleIdentifierForAdvertiser = identifierForAdvertiser
        self.deviceSystemVersion = deviceSystemVersion
        self.deviceModel = deviceModel
        self.deviceLocalizedModel = deviceLocalizedModel
        self.deviceName = deviceName
        self.deviceSystemName = deviceSystemName
        self.deviceUserInterfaceIdiom = deviceUserInterfaceIdiom
        self.lastDeviceUpdateTime = lastDeviceUpdateTime
        self.deviceCreationTime = deviceCreationTime
        self.appUserIdentifier = appUserIdentifier
    }
}

/// Allows `AppDevice` to be used as a dynamic migration.
extension AppDevice: Migration {
    
    /// prepare migration
    /// MAS NOTE: tell vapor that the identifierForVendor is unique
    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
        return Database.create(self, on: connection) { (schemaCreator) in
            try addProperties(to: schemaCreator)
            schemaCreator.unique(on: \.appleIdentifierForVendor)
        }
    }
}

/// Allows `AppDevice` to be encoded to and decoded from HTTP messages.
extension AppDevice: Content { }

/// Allows `AppDevice` to be used as a dynamic parameter in route definitions.
extension AppDevice: Parameter { }
