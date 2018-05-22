//
//  FollowListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class FollowListTableViewController: UserListTableViewController {
    
    var userId: String?
    
    override func getData() {
        DispatchQueue.global(qos: .userInitiated).async {
            if let userId = self.userId {
                var users: [String] = []
                FollowUtil().getFollows(user_id: userId) { (follows) in
                    for follow in follows {
                        users.append(follow.follow_id)
                    }
                }
                self.viewModel.getUsersData(userIds: users) { (result) in
                    if result == true {
                        DispatchQueue.main.async {
                            self.loadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.refreshControl?.endRefreshing()
                            self.navigationItem.prompt = "フォローデータの取得に失敗しました。"
                        }
                    }
                }
            }
        }
    }
}
