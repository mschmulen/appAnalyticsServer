import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `AppInfo`s.
final class AppInfoController {
    
    /// Returns a list of all `AppInfo`s.
//    func index(_ req: Request) throws -> Future<[AppInfo]> {
//        // return AppInfo.query(on: req).all()
//        return AppInfo.query(on: req).sort(\.lastUpdateTime, .descending).all()
//    }
    
    func getAllPaginatedHandler(_ req: Request) throws -> Future<[AppInfo]> {
        return try AppInfo.query(on: req).sort(\.lastUpdateTime, .descending).paginate(on: req).all()
    }
    
    /// Saves a decoded `AppInfo` to the database.
    func create(_ req: Request) throws -> Future<AppInfo> {
        
        return try req.content.decode(AppInfo.self).flatMap { model in
            
            let hashStringForNewModel = model.deviceSystemName + model.appIdentifier + model.appVersion
            let hashForNewModel = hashStringForNewModel.hashValue
            model.appHash = hashForNewModel
            
            return AppInfo.query(on: req).filter(\.appHash == hashForNewModel).first().flatMap { (existingModel) -> EventLoopFuture<AppInfo> in
                
                if existingModel == nil {
                    // the appInfo for this app does not exist so create it
                    return model.save(on: req)
                } else {
                    // the appInfo for this app exists so update it
                    // Update any of the transient properties of the device record
                    existingModel!.lastUpdateTime = model.lastUpdateTime
                    existingModel!.appBuild = model.appBuild
                    return existingModel!.save(on: req)
                    //return existingModel!.willRead(on: req)
                }
            }
            //return model.save(on: req)
        }
    }

    /// Deletes a parameterized `AppInfo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AppInfo.self).flatMap { model in
            return model.delete(on: req)
        }.transform(to: .ok)
    }
}
