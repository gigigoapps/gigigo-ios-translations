//
//  Strings.swift
//  translations-sync
//
//  Created by José Estela on 5/6/18.
//  Copyright © 2018 jcarlosestela. All rights reserved.
//

import Foundation

struct Strings {
    
    struct Configuration {
        static let creatingFile = "Creating configuration file"
        static let insertIndexURL = "Insert the index url"
        static let configFileCreated = "The config file has been created"
    }
    
    struct Warnings {
        static let configurationFileMissed = "The configuration file is not created"
    }
    
    struct Errors {
        static let urlFormatIsNotCorrect = "The url inserted is not valid"
        static let configurationFileIsNotCorrect = "The configuration file is not correct"
    }
}
