//
//  PresenterInterface.swift
//  hands
//
//  Created by 山浦功 on 2018/08/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

protocol PresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear(animated: Bool)
    func viewDidAppear(animated: Bool)
    func viewWillDisappear(animated: Bool)
    func viewDidDisappear(animated: Bool)
}

extension PresenterInterface {
    func viewDidLoad() {
        fatalError("Implementation pending")
    }

    func viewWillAppear(animated: Bool) {
        fatalError("Implementation pending")
    }

    func viewDidAppear(animated: Bool) {
        fatalError("Implementation pending")
    }

    func viewWillDisappear(animated: Bool) {
        fatalError("Implementation pending")
    }

    func viewDidDisappear(animated: Bool) {
        fatalError("Implementation pending")
    }
}

