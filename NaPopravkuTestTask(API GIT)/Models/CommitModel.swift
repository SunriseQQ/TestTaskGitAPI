//
//  Commit.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 16.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

struct CommitModel: Codable {
    let commit:  Commit
    let parents: [Parent]
    
}

struct Commit: Codable {
    let author: AuthorCommit
    let message: String
}

struct Parent: Codable {
    let sha: String
}

struct AuthorCommit: Codable {
    let name: String
    let date: String
    var dateFormatted: String? {return formatDate(date) }
    
     func formatDate(_ dte: String) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        df.locale = Locale(identifier: "en_US_POSIX")
        if let date = df.date(from: dte) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d/MM/yyyy     HH:mm"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            let dateStr = dateFormatter.string(from: date)
            return dateStr
        } else {
            return "problem with date formate"
        }
    }
}
