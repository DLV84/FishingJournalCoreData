//
//  DateFormatter.swift
//  FishingJournalCoreData
//
//  Created by Daniel Villedrouin on 3/1/21.
//

import Foundation

extension DateFormatter {
    
    static let catchTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d, h:mm a"
        return formatter
    }()
}// end of extension

//extension Date {
//
////    Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
////    09/12/2018                        --> MM/dd/yyyy
////    09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
////    Sep 12, 2:11 PM                   --> MMM d, h:mm a
////    September 2018                    --> MMMM yyyy
////    Sep 12, 2018                      --> MMM d, yyyy
////    Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
////    2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
////    12.09.18                          --> dd.MM.yy
////    10:41:02.112                      --> HH:mm:ss.SSS
//
//    func dateToString() -> String {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "MMM d, yyyy"
//        return formatter.string(from: self)
//    }
