//
//  RepositoryTableViewCell.swift
//  NaPopravkuTestTask(API GIT)
//
//  Created by Sunrise on 17.08.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    var cellModel: RepositoryViewModel? {
        didSet {
            bindViewModel()
            config()
        }
    }
    
    func bindViewModel() {
        textLabel?.text = "repository: \(cellModel?.repositoryName ?? "") "
        detailTextLabel?.text = "by \(cellModel?.loginAuthor ?? "")"
        imageView?.image = cellModel?.avatarAuthor
    }
    
    func config() {
        imageView?.layer.borderWidth = 2
        imageView?.layer.borderColor = UIColor.black.cgColor
        imageView?.layer.cornerRadius = 10
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
}
