import FluentSQLite
import Vapor

/// A single entry of a AppInfo list.
final class AppUser: SQLiteModel {
    
    /// The unique identifier for this `model`.
    var id: Int?
    
    /// associated UserIdentifier unique :
    var associatedAppUserIdentifier: String
    
    /// Creates a new `model`.
    init(id: Int? = nil, associatedAppUserIdentifier: String) {
        self.id = id
        self.associatedAppUserIdentifier = associatedAppUserIdentifier
    }
}

/// Allows `AppUser` to be used as a dynamic migration.
extension AppUser: Migration {
        
    // MAS NOTE: tell vapor that the associatedUserIdentifier is unique
//    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
//        return Database.create(self, on: connection) { (schemaCreator) in
//            try addProperties(to: schemaCreator)
//            schemaCreator.unique(on: \.associatedUserIdentifier)
//        }
//    }
}

/// Allows `AppUser` to be encoded to and decoded from HTTP messages.
extension AppUser: Content { }

/// Allows `AppUser` to be used as a dynamic parameter in route definitions.
extension AppUser: Parameter { }
