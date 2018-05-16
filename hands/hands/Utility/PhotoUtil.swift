//
//  PhotoUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/06.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import Firebase

class PhotoUtil {
    
    func getPhoto(path: String) -> UIImage? {
        var image: UIImage? = nil
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child(path)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
            if let data = data {
                image =  UIImage(data: data)
            }else {
                print(error!.localizedDescription)
            }
        }
        return image
    }
    
    func putPhoto(path: String, image: UIImage, complition: @escaping (String?) -> Void) {
        let imageRef = Storage.storage().reference().child(path)
        let imageData = UIImageJPEGRepresentation(image, CGFloat(0.7))!
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let metadata = metadata {
                complition(metadata.downloadURL()?.absoluteString)
            }else {
                print(error!.localizedDescription + "put Photo")
                complition(nil)
            }
            }.observe(.progress) { (snapshot) in
                print("\(snapshot.progress?.fileCompletedCount)")
        }
    }
    
    func putPhotoWithURL(path: String, imageURL: URL , complition: @escaping (String?) -> Void) {
        let imageRef = Storage.storage().reference().child(path)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        imageRef.putFile(from: imageURL, metadata: metaData) { (snapshot, error) in
            if let snapshot = snapshot {
                complition(snapshot.downloadURL()?.absoluteString)
            }else {
                complition(nil)
            }
        }
    }
}
