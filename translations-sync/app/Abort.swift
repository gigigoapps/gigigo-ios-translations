//
//  AppError.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

struct Abort: Error {
    let reason: String
}

func handleThrow(_ error: Error) {
    if let error = error as? Abort {
        LogError(error.reason)
    } else {
        LogError(error.localizedDescription)
    }
    exit(1)
}
