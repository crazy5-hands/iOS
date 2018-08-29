//
//  RootViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/08/21.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    init() {
        let wireframe = SplashWireframe()
        current = wireframe.configureModule()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(self.current)
        current.view.frame = self.view.bounds
        view.addSubview(current.view)
        current.didMove(toParentViewController: self)
    }
    
    override func childViewControllerForHomeIndicatorAutoHidden() -> UIViewController? {
        return self.childViewControllers.last
    }
    
    func showLoginScreen() {
        let wireframe = LoginWireframe()
        let new = wireframe.configureModule()
        
        new.view.frame = self.view.bounds
    }
    
    func showMainScreen() {
        
    }
}
