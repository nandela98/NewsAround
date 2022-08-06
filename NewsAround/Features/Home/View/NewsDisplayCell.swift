//
//  NewsDisplayCell.swift
//  NewsAround
//
//  Created by Sanjeeva Reddy Nandela on 8/5/22.
//

import Foundation
import UIKit

class NewsDisplayCell: BaseTableViewCell<Article> {
    
    override var item: Article? {
        didSet {
            setLabelSettings([self.textLabel, detailTextLabel])
            textLabel?.text = item?.title
            detailTextLabel?.text = item?.description ?? "NA"
            imageView?.image = UIImage(named: item?.image ?? "")
        }
    }
    
    func setLabelSettings(_ labels: [UILabel?]) {
        labels.forEach { label in
            label?.numberOfLines = 0
            label?.lineBreakMode = .byWordWrapping
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "\(NewsDisplayCell.self)")
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
