//
//  Date+Extension.swift
//  GIGTranslations
//
//  Created by José Estela on 6/6/18.
//  Copyright © 2018 Gigigo. All rights reserved.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        return dateFormatter.string(from: self)
    }
    
    func isSameDate(that date: Date) -> Bool {
        return self.toString(withFormat: "dd/MM/yyyy HH:mm") == date.toString(withFormat: "dd/MM/yyyy HH:mm")
    }
    
    init?(from string: String?, withFormat format: String) {
        guard let string = string else { return nil }
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        dateFormat.timeZone = TimeZone(abbreviation: "CET")
        if let date =  dateFormat.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
}
