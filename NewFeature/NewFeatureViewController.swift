//
//  NewFeatureViewController.swift
//  LighterSwift
//
//  Created by quezhen on 2018/1/7.
//  Copyright © 2018年 quezhen. All rights reserved.
//
import UIKit

class NewFeatureViewController: UIViewController {
    
    var pageVC: UIPageViewController!
    var pageVCchildren = [UIViewController]()
    private let infos = [("手动记录", "让你全面了解身体状况", #imageLiteral(resourceName: "newFeature1")), ("运动饮食", "每日一测，能多吃一个汉堡", #imageLiteral(resourceName: "newFeature2")), ("身体报告", "你的蜕变，从分析报告开始", #imageLiteral(resourceName: "newFeature3")), ("见证奇迹", "每日的坚持，才有见证奇迹的时刻", #imageLiteral(resourceName: "newFeature4"))]
    var pageCount: Int {
        return infos.count
    }
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var loginBtn: UIButton!
    
    //timer
    fileprivate var timeInterval : CGFloat = 2.5
    fileprivate var timer: Timer? = nil
    fileprivate var currentDisplayingVCIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pageVC
        guard let unwrapedPageVC = childViewControllers.first as? UIPageViewController else { return }
        pageVC = unwrapedPageVC
        pageVC.delegate = self
        pageVC.dataSource = self
        
        if pageCount < 0 { return }
        for i in 0..<pageCount {
            guard let vc = UIStoryboard.init(name: "NewFeature", bundle: nil).instantiateViewController(withIdentifier: "NewFeatureSubVC") as? NewFeatureSubVC else { return }
            vc.tag = i
            vc.info = infos[i]
            pageVCchildren.append(vc)
        }
        
        guard let firstChildVC = pageVCchildren.first else { return }
        pageVC.setViewControllers([firstChildVC], direction: .forward, animated: true, completion: nil)
        
        //timer
        creatTimer()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
}



//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension NewFeatureViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if pendingViewControllers.count != 0 {
            // set btns status
            timerPause()
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if finished {
            timerStart()
        }
        guard let vc = previousViewControllers.first as? NewFeatureSubVC else { return }
        currentDisplayingVCIndex = vc.tag
        pageControl.currentPage = vc.tag
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pageVCchildren.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return self.pageVCchildren.last
        }
        
        guard self.pageVCchildren.count > previousIndex else {
            return nil
        }
        return self.pageVCchildren[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pageVCchildren.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = self.pageVCchildren.count
        
        guard orderedViewControllersCount != nextIndex else {
            return self.pageVCchildren.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return self.pageVCchildren[nextIndex]
    }
}

extension NewFeatureViewController {
    
    //MARK: - Create timer
    fileprivate func creatTimer() -> Void {
        timer?.invalidate()
        timer = nil
        if (timer == nil && pageCount > 1) {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(timeInterval), target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            timerStart()
        }
    }
    
    //MARK: - Timer action
    @objc fileprivate func timerAction() -> Void {
        let index = currentDisplayingVCIndex+1 > pageCount-1 ? pageCount-1 : currentDisplayingVCIndex+1
        pageVC.setViewControllers([pageVCchildren[index]], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: - Timer pause
    func timerPause() -> Void {
        if (timer != nil) {
            timer?.fireDate = Date.distantFuture
        }
    }
    
    //MARK: - Timer start
    func timerStart() -> Void {
        if (timer != nil) {
            timer?.fireDate = NSDate(timeIntervalSinceNow: TimeInterval(timeInterval)) as Date
        }
    }
    
}

//--------------------------------------------------------------- sub vc --------------------------------------------------------------------------------

class NewFeatureSubVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    var info = ("", "", UIImage())
    var tag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = info.0
        descLabel.text = info.1
        imageView.image = info.2
    }
    
//    let animation = CATransition()
//    animation.duration = 0.7 ;
//    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//    animation.type = "rippleEffect";
//    view.layer.add(animation, forKey: "animation")
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//    UIView.animate(withDuration: 0.7, animations: {
//
//    }, completion: { _ in
//    UIApplication.shared.keyWindow?.rootViewController = DXMMainViewController()
//    })
//    }

}
