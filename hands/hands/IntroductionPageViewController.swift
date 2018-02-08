//
//  IntroductionPageViewController.swift
//  hands
//
//  Created by 山浦功 on 2018/02/08.
//  Copyright © 2018年 KoYamaura. All rights reserved.
//

import UIKit

class IntroductionPageViewController: UIPageViewController {

    @IBOutlet var skipButtonView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView: UIImageView!
        //set background view
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        let image = UIImage(named: "IntroductionBackground.jpg")
        let imageWidth = image?.size.width
        let imageHeight = image?.size.height
        
        imageView = UIImageView(image: image)
        
        let scale:CGFloat = screenHeight / imageHeight!
        let rect: CGRect = CGRect(x: 0, y: 0, width: imageWidth! * scale, height: imageHeight! * scale)
        
        imageView.frame = rect
        imageView.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
        self.view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
        
        self.setViewControllers([getFirst()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.view.addSubview(self.skipButtonView)
        self.skipButtonView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: self.skipButtonView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width,
            multiplier: 1.0, constant: 0))
        self.skipButtonView.addConstraint(NSLayoutConstraint(item: self.skipButtonView, attribute: .height,
            relatedBy: .equal,
            toItem: nil, attribute: .notAnAttribute,
            multiplier: 1.0, constant:  100.0))
        self.skipButtonView.topAnchor.constraint(equalTo: self.view.topAnchor)
////        constraint(equalTo: , constant: <#T##CGFloat#>)
//        self.view.addConstraint(NSLayoutConstraint(
//            item: self.skipButtonView, attribute: .top,
//            relatedBy: .equal,
//            toItem: self.view.safeAreaLayoutGuide.topAnchor, attribute: .top,
//            multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(
            item: self.skipButtonView, attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view, attribute: .centerX,
            multiplier: 1.0, constant: 0))
        self.view.updateConstraintsIfNeeded()
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
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
