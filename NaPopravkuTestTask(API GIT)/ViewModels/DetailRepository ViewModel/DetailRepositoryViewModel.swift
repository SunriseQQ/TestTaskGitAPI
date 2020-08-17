//
//  DetailRepositoryViewModel.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 17.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import UIKit

struct DetailRepositoryViewModel {
    var loginAuthor: String = ""
    var avatarAuthor: UIImage = defaultImage
    var repositoryName: String = ""
    var nameAuthorCommit: String = ""
    var parents: [String] = []
    var date: String = ""
    var message: String = ""
}
