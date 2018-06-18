//
//  main.swift
//  localizable-constants-generator
//
//  Created by José Estela on 18/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

// !!! Setup here your index json file
let url = URL(string: "http://translations-q.woah.com/translations/app/index.json")!
do {
    try LocalizablesGenerator(indexURL: url).generate()
} catch (let error) {
    handleThrow(error)
}
RunLoop.main.run()

