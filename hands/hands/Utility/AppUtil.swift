//
//  AppUtil.swift
//  hands
//
//  Created by 山浦功 on 2018/05/30.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import Foundation
import UIKit


enum Version {
    case needUpdate
    case same
    case oldVersion
    case error
}

class AppUtil {
    
    let appId = "109102102"
    
    func adjustVersion() -> Version {
        guard let currentVersion = self.getCurrentVersion() else { return .error }
        guard let appstoreVersion = self.getAppStoreAppVersion() else { return .error }
        return .same
    }
    
    //使用してるアプリのバージョンを取得
    func getCurrentVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    //Appstoreのアプリのバージョンを取得
    func getAppStoreAppVersion() -> String? {
        if let info = Bundle.main.infoDictionary {
            if let identifier = info["CFBundleIdentifier"] as? String {
                guard let url = URL(string: "http://itunes.apple.com/lookup?bundleId=\(identifier)") else { return nil }
                let data = try! Data(contentsOf: url)
                guard let json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] else {
                    return nil
                }
                if let result = (json!["results"] as? [Any])?.first as? [String: Any], let version = result["version"] as? String {
                    return version
                }
            }
        }
        return nil
    }
    
    //このアプリのAppStoreに飛ぶ
    func openAppStore() {
        let urlString = "itms-apps://itunes.apple.com/app/id\(self.appId)"
        let url = URL(string: urlString)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}
