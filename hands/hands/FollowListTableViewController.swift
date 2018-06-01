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
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            if let userId = self.userId {
                FollowUtil().getFollows(user_id: userId) { (follows) in
                    var users: [String] = []
                    for follow in follows {
                        users.append(follow.follow_id)
                    }
                    self.viewModel.getUsersData(userIds: users) { (result) in
                        if result == true {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
                                self.endLaoding()
                                self.reloadData()
                            })
                        } else {
                            DispatchQueue.main.async {
                                self.endLaoding()
                                self.navigationItem.prompt = "フォローデータの取得に失敗しました。"
                            }
                        }
                    }
                }
            }
        }
    }
}
