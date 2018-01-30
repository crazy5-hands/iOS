//
//  MemberTableViewCell.swift
//  hands
//
//  Created by 山浦功 on 2018/01/28.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MemberTableViewCell{
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row : Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)
        collectionView.reloadData()
    }
    
    var collectionViewOffSet: CGFloat{
        set {collectionView.contentOffset.x = newValue}
        get { return collectionView.contentOffset.x }
    }
}
