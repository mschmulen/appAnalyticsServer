//
//  TimeSpan.swift
//  App
//
//  Created by Matthew Schmulen on 12/16/19.
//

import Foundation

public enum TimeSpan {
    
    case minute
    case hour
    case day
    case week
    case month
    
    var description:String {
        switch self {
        case .minute : return "Minute"
        case .hour : return "Hour"
        case .day : return "Day"
        case .week : return "Week Day"
        case .month : return "Month"
        }
    }
    
    var requestString:String? {
        let nowDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        switch self {
        case .minute:
            guard let oneMinuteFromNow = Calendar.current.date(byAdding: .minute, value: -1, to: nowDate) else {
                return nil
            }
            let filterComponents = DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC")!,
                era: nil,
                year: calendar.component(.year, from: oneMinuteFromNow),
                month: calendar.component(.month, from: oneMinuteFromNow),
                day: calendar.component(.day, from: oneMinuteFromNow),
                hour: calendar.component(.hour, from: oneMinuteFromNow),
                minute: calendar.component(.minute, from: oneMinuteFromNow),
                second: calendar.component(.second, from: oneMinuteFromNow),
                nanosecond: 0,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil
            )
            let filterTimeString = "\(filterComponents.date!)"
            return filterTimeString
            
        case .hour:
            guard let oneHourFromNow = Calendar.current.date(byAdding: .hour, value: -1, to: nowDate) else {
                return nil
            }
            let filterComponents = DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC")!,
                era: nil,
                year: calendar.component(.year, from: oneHourFromNow),
                month: calendar.component(.month, from: oneHourFromNow),
                day: calendar.component(.day, from: oneHourFromNow),
                hour: calendar.component(.hour, from: oneHourFromNow),
                minute: calendar.component(.minute, from: oneHourFromNow),
                second: calendar.component(.second, from: oneHourFromNow),
                nanosecond: 0,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil
            )
            let filterTimeString = "\(filterComponents.date!)"
            return filterTimeString
            
        case .day:
            guard let oneDayFromNow = Calendar.current.date(byAdding: .day, value: -1, to: nowDate) else {
                return nil
            }
            let filterComponents = DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC")!,
                era: nil,
                year: calendar.component(.year, from: oneDayFromNow),
                month: calendar.component(.month, from: oneDayFromNow),
                day: calendar.component(.day, from: oneDayFromNow),
                hour: calendar.component(.hour, from: oneDayFromNow),
                minute: calendar.component(.minute, from: oneDayFromNow),
                second: calendar.component(.second, from: oneDayFromNow),
                nanosecond: 0,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil
            )
            let filterTimeString = "\(filterComponents.date!)"
            return filterTimeString
        case .week:
            guard let oneWeekFromNow = Calendar.current.date(byAdding: .day, value: -7, to: nowDate) else {
                return nil
            }
            let filterComponents = DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC")!,
                era: nil,
                year: calendar.component(.year, from: oneWeekFromNow),
                month: calendar.component(.month, from: oneWeekFromNow),
                day: calendar.component(.day, from: oneWeekFromNow),
                hour: calendar.component(.hour, from: oneWeekFromNow),
                minute: calendar.component(.minute, from: oneWeekFromNow),
                second: calendar.component(.second, from: oneWeekFromNow),
                nanosecond: 0,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil
            )
            let filterTimeString = "\(filterComponents.date!)"
            return filterTimeString
        case .month:
            guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: -1, to: nowDate) else {
                return nil
            }
            let filterComponents = DateComponents(
                calendar: calendar,
                timeZone: TimeZone(identifier: "UTC")!,
                era: nil,
                year: calendar.component(.year, from: oneMonthFromNow),
                month: calendar.component(.month, from: oneMonthFromNow),
                day: calendar.component(.day, from: oneMonthFromNow),
                hour: calendar.component(.hour, from: oneMonthFromNow),
                minute: calendar.component(.minute, from: oneMonthFromNow),
                second: calendar.component(.second, from: oneMonthFromNow),
                nanosecond: 0,
                weekday: nil,
                weekdayOrdinal: nil,
                quarter: nil,
                weekOfMonth: nil,
                weekOfYear: nil,
                yearForWeekOfYear: nil
            )
            let filterTimeString = "\(filterComponents.date!)"
            return filterTimeString
        }
    }//end requestString
    
}// end TimeSpan
