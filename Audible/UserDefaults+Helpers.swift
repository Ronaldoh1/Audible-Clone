//
//  UserDefaults+Helpers.swift
//  Audible
//
//  Created by Ronald Hernandez on 1/10/17.
//  Copyright © 2017 Ronaldoh1. All rights reserved.
//

import Foundation

extension UserDefaults {

    private enum UserDefaultKeys: String {
        case isLoggedin
    }

    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultKeys.isLoggedin.rawValue)
        synchronize()
    }

    func isloggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedin.rawValue)
    }

}
