//
//  UserListTableViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/05/03.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class UserListTableViewController: UITableViewController {

    var followed: Bool?
    var id: String?
    private let db = Firestore.firestore()
    private var follows: [Follow?] = []
    private var photos: [UIImage?] = []
    private var usernames: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "UserTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "user")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var title = ""
        db.collection("users").whereField("id", isEqualTo: self.id!).getDocuments { (snapshot, error) in
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    title = document.data()["username"] as! String
                }
            }
        }
        self.navigationItem.title = title
        self.loadData()
        
    }
    
    private func loadData() {
        if let followed = self.followed, let id = self.id {
            if followed == true { // get which user follows
                db.collection("follows").whereField("follow_id", isEqualTo: id).getDocuments { (snapshot, error) in
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            self.follows.append(Follow(dictionary: document.data()))
                        }
                    }else {
                        print(error?.localizedDescription ?? "error to get follow_id follows")
                    }
                }
                for follow in follows {
                    if followed == true {
                        db.collection("users").whereField("id", isEqualTo: follow!.user_id).getDocuments { (snapshot, error) in
                            if let snapshot = snapshot {
                                for document in snapshot.documents {
                                    self.usernames.append(document.data()["username"] as? String)
                                    self.photos.append(UIImage())
                                }
                            }
                        }
                    }
                }
            }else { // get which user is followed
                db.collection("follows").whereField("user_id", isEqualTo: id).getDocuments { (snapshot, error) in
                    if let snapshot = snapshot {
                        for document in snapshot.documents {
                            self.follows.append(Follow(dictionary: document.data()))
                        }
                    }else {
                        print(error?.localizedDescription ?? "error to get follow_id follows")
                    }
                }
                for follow in follows {
                    if followed == false {
                        db.collection("users").whereField("id", isEqualTo: follow!.follow_id).getDocuments { (snapshot, error) in
                            if let snapshot = snapshot {
                                for document in snapshot.documents {
                                    self.usernames.append(document.data()["username"] as? String)
                                    self.photos.append(UIImage())
                                }
                            }
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.follows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath) as! UserTableViewCell
        cell.nameLabel.text = self.usernames[indexPath.row]
        cell.profileImageView.image = self.photos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(60.0)
    }
}
