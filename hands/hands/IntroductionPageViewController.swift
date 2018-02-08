//
//  IntroductionPageViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/02/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class IntroductionPageViewController: UIPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipIntroduction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginViewController", bundle: nil)
        let next = storyboard.instantiateViewController(withIdentifier: "loginViewController            ") as! LoginViewController
        self.present(next, animated: true, completion: nil)
    }
    
}

extension IntroductionPageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: FirstIntroductionViewController) {
            //1 -> 2
            return getSecond()
        }else if viewController.isKind(of: SecondIntroductionViewController){
            return getThird()
        }else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: ThirdIntroductionViewController){
            // 3 -> 2
            return getSecond()
        }else if viewController.isKind(of: SecondIntroductionViewController){
            //2 -> 1
            return getFirst()
        }else {
            return nil
        }
    }
}


extension IntroductionPageViewController{
    
    func getFirst() -> FirstIntroductionViewController{
        let storyboard = UIStoryboard(name: "FirstIntroductionViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "firstIntroductionViewController") as! FirstIntroductionViewController
    }
    
    func getSecond() -> SecondIntroductionViewController{
        let storyboard = UIStoryboard(name: "SecondIntroductionViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "secondIntroductionViewController") as! SecondIntroductionViewController
    }
    
    func getThird() -> ThirdIntroductionViewController{
        let storyboard = UIStoryboard(name: "ThirdIntroductionViewController", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "thirdIntroductionViewController") as! ThirdIntroductionViewController
    }
}
