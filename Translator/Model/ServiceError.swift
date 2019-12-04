//
//  ServiceError.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation

/// Errors describer
enum ServiceError: String, CaseIterable {
    
    case noInternetConnection = "No Internet Connection"
    case remoteServer = "Remote Server"
    case wrongUrl = "Wrong URL"
}
