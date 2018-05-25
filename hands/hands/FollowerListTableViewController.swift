//
//  FollowerTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/22.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class FollowerListTableViewController: UserListTableViewController {
    
    var userId: String?
    
    override func getData() {
        self.startLoading()
        DispatchQueue.global(qos: .userInitiated).async {
            if let userId = self.userId {
                FollowUtil().getFollowers(follow_id: userId, complition: { (follows) in
                    var followers: [String] = []
                    for follow in follows {
                        followers.append(follow.user_id)
                    }
                    self.viewModel.getUsersData(userIds: followers, complition: { (result) in
                        if result == true {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                self.endLaoding()
                                self.reloadData()
                            })
                        } else {
                            DispatchQueue.main.async {
                                self.endLaoding()
                                self.navigationItem.prompt = "フォロワーデータの取得できませんでした。"
                            }
                        }
                    })
                })
            }
        }
    }
}
