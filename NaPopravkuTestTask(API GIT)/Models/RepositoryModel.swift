//
//  Repository.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 16.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

struct RepositoryModel: Codable {
    let name: String
    //let commit: CommitModel?
    let author: AuthorModel
    let commitsURL: String
    var fixedCommitsURL: String {return fixCommitsUrl(commitsURL)}
    
    private enum CodingKeys: String, CodingKey {
        case name
        case author = "owner"
        case commitsURL = "commits_url"
    }
    
    func fixCommitsUrl(_ url: String) -> String {
        if let index = url.range(of: "{")?.lowerBound {
            return String(url[..<index])
        }else{
            return url}
    }
}

struct AuthorModel: Codable {
    let login: String
    let avatarURL: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
