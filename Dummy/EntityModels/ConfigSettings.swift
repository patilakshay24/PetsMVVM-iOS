//
//  ConfigSettings.swift
//  Dummy
//
//  Created by Akshay Patil on 28/06/22.
//

import Foundation

struct ConfigSettings {
    let isChatEnabled: Bool
    let isCallEnabled: Bool
    let workHours: String
    init(_ isChatEnabled: Bool, _ isCallEnabled: Bool, _ workHours: String) {
        self.isChatEnabled = isChatEnabled
        self.isCallEnabled = isCallEnabled
        self.workHours = workHours
    }
    
    public func checkTimeIsInWorkHours() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "(\\d+(\\.\\d+)?)|(\\.\\d+)")
            let results = regex.matches(in: workHours,
                                        range: NSRange(workHours.startIndex..., in: workHours))
            let startAndEndTime = results.map {
                String(workHours[Range($0.range, in: workHours)!])
            }
            print(startAndEndTime)
            
            let startTime = startAndEndTime.map { Int($0)! }
            print(startTime)
            let startHr = startTime[0]
            let startMin = startTime[1]
            let endtHr = startTime[2]
            let endtMin = startTime[3]
            
            return CheckTime(startHr, startMin, endtHr, endtMin)
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }
        return false
    }
    
    private func CheckTime(_ startHrTime: Int, _ startMinTime: Int,_ endHrTime: Int, _ endMinTime: Int)->Bool{
        var timeExist:Bool
        let calendar = Calendar.current
        let startTimeComponent = DateComponents(calendar: calendar, hour:startHrTime, minute: startMinTime)
        let endTimeComponent   = DateComponents(calendar: calendar, hour: endHrTime, minute: endMinTime)

        let now = Date()
        let startOfToday = calendar.startOfDay(for: now)
        let startTime    = calendar.date(byAdding: startTimeComponent, to: startOfToday)!
        let endTime      = calendar.date(byAdding: endTimeComponent, to: startOfToday)!

        if startTime <= now && now <= endTime {
            print("in between")
            timeExist = true
        } else {
            print("not in between")
            timeExist = false
        }
        return timeExist
    }
}
