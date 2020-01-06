import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `AppEvent`s.
final class AppEventController {

    /**
     get with pagination and extended filtering
     
     GET:
     http://localhost:8080/events?limit=20&page=10
     http://localhost:8080/events?limit=20&page=10&appleIdentifierForVendor=FC92423C-64EC-406C-AAAD-9201172B5D30
     http://localhost:8080/events?limit=20&page=10&appIdentifier=com.org.AnalyticsSwiftUIExample&appVersion=1.2
     */
    func getAllPaginatedWithOptionalFilterHandler(_ req: Request) throws -> Future<[AppEvent]> {
        let appleIdentifierForVendorValue = try? req.query.get(String.self, at: "appleIdentifierForVendor")
        let appIdentifierValue = try? req.query.get(String.self, at: "appIdentifier")
        let appVersionValue = try? req.query.get(String.self, at: "appVersion")
        
        //var query = AppEvent.query(on: req)
        var query = AppEvent.query(on: req).sort(\.creationTime, .descending)
        
        if let appleIdentifierForVendorValue = appleIdentifierForVendorValue {
            query = AppEvent.query(on: req)
                .filter(\.appleIdentifierForVendor == appleIdentifierForVendorValue)
        }
        
        if let appIdentifierValue = appIdentifierValue {
            query = AppEvent.query(on: req)
                .filter(\.appIdentifier == appIdentifierValue)
            
            if let appVersionValue = appVersionValue {
                query = AppEvent.query(on: req)
                    .filter(\.appIdentifier == appIdentifierValue)
                    .filter(\.appVersion == appVersionValue)
            }
        }
        
        // return query.all()
        return try query.paginate(on: req).all()
    }
    
    /**
     events by deviceIDFA
     events\{deviceIDFA}
     test url: http://localhost:8080/events/762498C5-ED8C-4479-8577-EB84A4A1E6AB
     supports pagination
     GET http://localhost:8080/events/762498C5-ED8C-4479-8577-EB84A4A1E6AB?limit=20&page=10
     */
//    func extendedIDFAQuery(_ req: Request) throws -> Future<[AppEvent]> {
//        let deviceIDFA = try req.parameters.next(String.self)
//        return try AppEvent.query(on: req).filter(\.appleIdentifierForVendor == deviceIDFA).paginate(on: req).all()
//    }
    
    /// Returns a list of all `AppEvent`s.
//    func index(_ req: Request) throws -> Future<[AppEvent]> {
//        // return AppEvent.query(on: req).all()
//        return AppEvent.query(on: req).sort(\.creationTime, .descending).all()
//    }
    
    /// Saves a decoded `AppEvent` to the database.
    func create(_ req: Request) throws -> Future<AppEvent> {
        return try req.content.decode(AppEvent.self).flatMap { model in
            
            //drop any
            return AppEvent.query(on: req).filter(\.localDeviceEventUUID == model.localDeviceEventUUID).first().flatMap { (existingModel) -> EventLoopFuture<AppEvent> in
                
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
    
    /// Deletes a parameterized `AppEvent`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AppEvent.self).flatMap { model in
            return model.delete(on: req)
        }.transform(to: .ok)
    }
}
