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
    handleThrow(error)
}
