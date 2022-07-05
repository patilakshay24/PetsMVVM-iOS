//
//  WorkHourUtil.swift
//  PetsDummy
//
//  Created by Akshay Patil on 04/07/22.
//

import Foundation

/**
 Used to handle work hours bussiness logic.
 */
class WorkHourUtil {
    
    public static func checkTimeIsInWorkHours(_ workHours: String,_ onDate: Date) -> String {
        if (isTimeInWorkHours(workHours, onDate)) {
            return NSLocalizedString("Thank you for getting in touch with us", comment: "")
        } else {
            return NSLocalizedString("Work hours has ended", comment: "")
        }
    }
    
    public static func isTimeInWorkHours(_ workHours: String,_ onDate: Date) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+(\\.\\d+)?)|(\\.\\d+)")
            let results = regex.matches(in: workHours,
                                        range: NSRange(workHours.startIndex..., in: workHours))
            let startAndEndTime = results.map {
                String(workHours[Range($0.range, in: workHours)!])
            }
            
            let startTime = startAndEndTime.map { Int($0)! }
            let startHr = startTime[0]
            let startMin = startTime[1]
            let endtHr = startTime[2]
            let endtMin = startTime[3]
            
            return CheckTime(startHr, startMin, endtHr, endtMin, onDate)
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }
        return false
    }
    
    private static func CheckTime(_ startHrTime: Int, _ startMinTime: Int,_ endHrTime: Int, _ endMinTime: Int, _ onDate: Date)->Bool{
        var timeExist:Bool
        let calendar = Calendar.current
        let startTimeComponent = DateComponents(calendar: calendar, hour:startHrTime, minute: startMinTime)
        let endTimeComponent   = DateComponents(calendar: calendar, hour: endHrTime, minute: endMinTime)

        let startOfToday = calendar.startOfDay(for: onDate)
        let startTime    = calendar.date(byAdding: startTimeComponent, to: startOfToday)!
        let endTime      = calendar.date(byAdding: endTimeComponent, to: startOfToday)!

        if startTime <= onDate && onDate <= endTime {
            timeExist = true
        } else {
            timeExist = false
        }
        return timeExist
    }
}
