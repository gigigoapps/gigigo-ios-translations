//
//  main.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation


do {
    try App().run(args: CommandLine.arguments)
} catch(let error) {
    if let error = error as? Abort {
        LogError(error.reason)
        exit(1)
    } else {
        LogError(error.localizedDescription)
    }
}
