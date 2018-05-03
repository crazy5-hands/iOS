//
//  ProfileViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ProfileViewModelDelegate, UICollectionViewDelegateFlowLayout {
    
    private let kSectionUser = 0
    private let kSectionNote = 1
    private let kSectionOthers = 2
    private var viewModel: ProfileViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ProfileViewModel()
        self.viewModel.delegate = self
        
        let userCell = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        let labelCell = UINib(nibName: "LabelCollectionViewCell", bundle: nil)
        let squareCell = UINib(nibName: "SquareCollectionViewCell", bundle: nil)
        collectionView.register(userCell, forCellWithReuseIdentifier: "user")
        collectionView.register(labelCell, forCellWithReuseIdentifier: "note")
        collectionView.register(squareCell, forCellWithReuseIdentifier: "square")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getData()
        print("this is profileviewmodel's userdata")
        print(self.viewModel.user?.username ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setUpBind() {
    }
    
    func loadData() {
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // write segue here
        if indexPath.section == kSectionOthers {
            switch indexPath.item {
            case 0: //own
                print("segue to owner")
            case 1: //join
                print("segue to join")
            case 2:
                print("segue to follow")
            case 3:
                print("segue to follower")
            default:
                break
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case kSectionUser:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "user", for: indexPath) as! UserCollectionViewCell
            cell.usernameLabel.text = self.viewModel.user?.username
            return cell
            
        case kSectionNote:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "note", for: indexPath) as! LabelCollectionViewCell
            cell.textLabel.text = self.viewModel.user?.note
            return cell
        case kSectionOthers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! SquareCollectionViewCell
            
            switch indexPath.item {
            case 0: //own
                cell.titleLabel.text = "Own"
                cell.contentLabel.text = String(describing: self.viewModel.user?.own.count)
            case 1: //join
                cell.titleLabel.text = "Join"
                cell.contentLabel.text = String(describing: self.viewModel.user?.own.count)
            case 2: //follow
                cell.titleLabel.text = "Follow"
                cell.contentLabel.text = String(describing: self.viewModel.user?.follow.count)
            case 3: //follower
                cell.titleLabel.text = "Follower"
                cell.contentLabel.text = String(describing: self.viewModel.user?.follower.count)
            default: break
            }
            return cell
            
        default:
            let cell = UICollectionViewCell()
            cell.sizeThatFits(.zero)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case kSectionUser:
            return 1
        case kSectionNote:
            return 1
        case kSectionOthers:
            return 4
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case kSectionUser:
            return CGSize(width: self.view.frame.size.width, height: 160.0)
        case kSectionNote:
            return CGSize(width: self.view.frame.size.width, height: 60.0)
        case kSectionOthers:
            let width = (self.view.frame.size.width - 10)/2
            let height = width
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: self.view.frame.size.width, height: 60.0)
        }
    }
}
