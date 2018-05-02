//
//  ProfileViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/04/26.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    private let kSectionUser = 0
    private let kSectionNote = 1
    private let kSectionOthers = 2
    private var viewModel: ProfileViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ProfileViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("this is profileviewmodel's userdata")
        print(self.viewModel.user?.username)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
            return cell
            
        case kSectionNote:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "label", for: indexPath) as! LabelCollectionViewCell
            cell.textLabel.text = self.viewModel.user?.note
            return cell
        case kSectionOthers:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "square", for: indexPath) as! LabelCollectionViewCell
            var text: String?
            switch indexPath.item {
            case 0: //own
                text = String(describing: self.viewModel.user?.own.count)
            case 1: //join
                text = String(describing: self.viewModel.user?.join.count)
            case 2: //follow
                text = String(describing: self.viewModel.user?.follow.count)
            case 3: //follower
                text = String(describing: self.viewModel.user?.follower.count)
            default: break
            }
            cell.textLabel.text = text
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
}
