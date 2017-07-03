//
//  HomeTableViewCell.swift
//  CNoder
//
//  Created by Fussa on 2017/7/3.
//  Copyright © 2017年 fussa. All rights reserved.
//

import UIKit
class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var replyVisitCountLabel: UILabel!
    @IBOutlet weak var tabLabel: UILabel!
    @IBOutlet weak var good: UILabel!
    @IBOutlet weak var creatTimeLabel: UILabel!
    @IBOutlet weak var top: UILabel!

    var topic: Topics? {
        willSet(newTopic) {
            self.titleLabel.text = newTopic?.title
            self.replyVisitCountLabel.text = String(describing: (newTopic?.reply_count)!) + "/" + String(describing: (newTopic?.visit_count)!)
            if let tab = newTopic?.tab {
                switch tab  {
                case "ask":
                    self.tabLabel.text = "问答"
                case "share":
                    self.tabLabel.text = "分享"
                case "job":
                    self.tabLabel.text = "招聘"
                case "good":
                    self.tabLabel.text = "精华"
                default:
                    self.tabLabel.text = ""
                }
            }
            let auther = newTopic?.author
            let imgUrl = URL(string: (auther?.avatar_url)!)
            self.headImageView.sd_setImage(with: imgUrl, placeholderImage: #imageLiteral(resourceName: "header_image"))
            self.good.isHidden = !(newTopic?.good)!
            self.creatTimeLabel.text = newTopic?.create_at
            self.top.isHidden = !(newTopic?.top)!
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.cornerRadius = self.headImageView.width * 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
