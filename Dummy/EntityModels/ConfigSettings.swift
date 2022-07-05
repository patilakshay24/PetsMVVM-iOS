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
}
