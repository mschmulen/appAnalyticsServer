import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
//    router.get("hello") { req -> String in
//        let model = MetricModel(span: "yack", activeDevices: 22, activeApps: 33)
//
////        return try JSON(node: [
////            "span" : model.span,
////            "activeDevices" : model.activeDevices,
////            "activeApps" : model.activeApps
////        ])
//
//        return "Hello, world! \(model.span) \(model.activeApps) \(model.activeDevices)"
//    }
    
    // leaf rendering
    router.get("hello") { req -> Future<View> in
        return try req.view().render("hello", ["name": "Leaf"])
    }
    
//    router.get("yack", Int.parameter) { req -> String in
//        let id = try req.parameters.next(Int.self)
//        return "yack #\(id)"
//    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    let appUserController = AppUserController()
    // router.get("users", use: appUserController.index)
    router.get("users", use: appUserController.getAllPaginatedHandler)
    router.post("users", use: appUserController.create)
    router.delete("users", AppUser.parameter, use: appUserController.delete)
    
    let appEventController = AppEventController()
    // router.get("events", use: appEventController.index)
    router.get("events", use: appEventController.getAllPaginatedWithOptionalFilterHandler)
    router.post("events", use: appEventController.create)
    router.delete("events", AppEvent.parameter, use: appEventController.delete)
    //    events\{deviceIDFA}
    //router.get("events", String.parameter, use: appEventController.extendedIDFAQuery)
    
    // App Event Controller
    let appCrashEventController = AppCrashEventController()
    // router.get("crashs", use: appCrashEventController.index)
    router.get("crashs", use: appCrashEventController.getAllPaginatedWithOptionalFilterHandler)
    router.post("crashs", use: appCrashEventController.create)
    router.delete("crashs", AppCrashEvent.parameter, use: appCrashEventController.delete)
    //    crashs\{deviceIDFA}
    
    // App Info Controller
    let appInfoController = AppInfoController()
    // router.get("apps", use: appInfoController.index)
    router.get("apps", use: appInfoController.getAllPaginatedHandler)
    router.post("apps", use: appInfoController.create)
    router.delete("apps", AppInfo.parameter, use: appInfoController.delete)
    // router.get("oldApps", use: appDeviceController.dailyActiveDevices)
    // router.get("currentApps", use: appDeviceController.monthlyActiveDevices)
    
    // App Devices Controller
    let appDeviceController = AppDeviceController()
    // router.get("devices", use: appDeviceController.index)
    router.get("devices", use: appDeviceController.getAllPaginatedHandler)
    router.post("devices", use: appDeviceController.create)
    router.delete("devices", AppDevice.parameter, use: appDeviceController.delete)
//    router.get("dailyActiveDevices", use: appDeviceController.dailyActiveDeviceList)
//    router.get("monthlyActiveDevices", use: appDeviceController.monthlyActiveDeviceList)
    
    // Metrics , overview dashboard and main web interaface
    let appMetricsController = AppMetricsController()
    router.get("metricsMinute", use: appMetricsController.metricsMinute)
    router.get("metricsDay", use: appMetricsController.metricsDay)
    router.get("metricsMonth", use: appMetricsController.metricsMonth)
    
    // AppServerOperationsController
//    let appServerCommandController = AppServerOperationsController()
//    router.get("flushOldEvents", use: appServerCommandController.flushOldEventsFromLocalServer)
//    router.get("flushAllEvents", use: appServerCommandController.flushAllEventsFromLocalServer)
//
//    router.get("deleteAllEvents", use: appServerCommandController.deletAllEvents)
//    router.get("deletAllDevices", use: appServerCommandController.deletAllDevices)
//    router.get("deletAllApps", use: appServerCommandController.deletAllApps)
//    router.get("deletAllCrashs", use: appServerCommandController.deletAllCrashs)
    
}
