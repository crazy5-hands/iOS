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
    
    func putPhoto(path: String, image: UIImage, imageURL: URL, handler: (String?) -> Void){
        var urlString: String? = nil
        let imageRef = Storage.storage().reference().child(path)
        let imageData = UIImageJPEGRepresentation(image, CGFloat(0.5))!
        let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let metadata = metadata {
                urlString = metadata.downloadURL()?.absoluteString
            }else {
                print(error!.localizedDescription)
            }
        }
//        let uploadTask = imageRef.putFile(from: imageURL, metadata: nil) { metadata, error in
//            if let metadata = metadata {
//                urlString = metadata.downloadURL()?.absoluteString
//            }else {
//                print(error!.localizedDescription)
//            }
//        }
        uploadTask.resume()
        handler(urlString)
    }
}
