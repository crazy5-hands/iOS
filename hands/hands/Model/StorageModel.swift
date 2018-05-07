////
////  StrageModel.swift
////  hands
////
////  Created by 山浦功 on 2018/04/12.
////  Copyright © 2018年 KoYamaura. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//
//class StorageModel {
//
//    // 写真のアップロード
//    func uplodeImage(_ image: UIImage, url: String) -> URL? {
//        var downloadURL: URL?
//        let strageRef = Storage.storage().reference(forURL: "gs://hands-8efa5.appspot.com/") //参照先
//        let imageRef = strageRef.child(url)
//        let imageData = UIImageJPEGRepresentation(image, 1.0)
//        imageRef.putData(imageData!, metadata: nil){ metadata, error in
//            if (error != nil){
//                print(error.debugDescription)
//                print("fail to upload image")
//            }else {
//                downloadURL = (metadata?.downloadURL())!
//            }
//        }
//        return downloadURL
//    }
//}
