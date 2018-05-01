//
//  ProfileViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    private let kSectionPhoto = 0
    private let kSectionUsername = 1
    private let kSectionNote = 2
    private let kSectionOthers = 3
    private var userRef: DatabaseReference!
    private var uid = ""
    private var user = User()
    private var refHandle: DatabaseHandle?
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uid = (Auth.auth().currentUser?.uid)!
        self.userRef = Database.database().reference().child("users").child(uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refHandle = self.userRef.observe(.value, with: { (snapshot) in
            print(snapshot.value as! String)
        }, withCancel: { (error) in
            print(error.localizedDescription)
        })
//        self.refHandle = self.userRef.observe(DataEventType.value, with: { (snapshot) in
//            let dict = snapshot.value(forKey: "username") as! String
//            print(dict)
////            self.user.
//        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let handle = self.refHandle {
            self.userRef.removeObserver(withHandle: handle)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // write segue here
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photo", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case kSectionPhoto:
            return 1
        case kSectionUsername:
            return 1
        case kSectionNote:
            return 1
        case kSectionOthers:
            return 4
        default:
            return 0
        }
    }
}
