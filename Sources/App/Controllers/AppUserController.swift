import Vapor
import FluentSQLite

/// Controls basic CRUD operations on `AppUser`s.
final class AppUserController {
    
    /**
     get with pagination
     GET http://localhost:8080/events?limit=20&page=10
     */
    func getAllPaginatedHandler(_ req: Request) throws -> Future<[AppUser]> {
      return try AppUser.query(on: req).paginate(on: req).all()
    }
    
    /// Returns a list of all `AppUser`s.
//    func index(_ req: Request) throws -> Future<[AppUser]> {
//        return AppUser.query(on: req).all()
//    }

    /// Saves a decoded `AppUser` to the database.
    func create(_ req: Request) throws -> Future<AppUser> {
        return try req.content.decode(AppUser.self).flatMap { model in
            return model.save(on: req)
        }
    }

    /// Deletes a parameterized `AppUser`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(AppUser.self).flatMap { model in
            return model.delete(on: req)
        }.transform(to: .ok)
    }
}
