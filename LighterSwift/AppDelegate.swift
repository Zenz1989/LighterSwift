//
//  AppDelegate.swift
//  LighterSwift
//
//  Created by quezhen on 2018/1/4.
//  Copyright © 2018年 quezhen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    static let versionKey = "lastVersionString"
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setRootVC()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

//MARK: - set root vc
extension AppDelegate {
    fileprivate func setRootVC() {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let lastVersion = (UserDefaults.standard.value(forKey: AppDelegate.versionKey) ?? "") as! String
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        if lastVersion == currentVersion {
//            window?.rootViewController = DXMMainViewController()
            window?.rootViewController = UIStoryboard(name: "NewFeature", bundle: nil).instantiateViewController(withIdentifier: "NewFeatureViewController")
        }else{
            window?.rootViewController = UIStoryboard(name: "NewFeature", bundle: nil).instantiateViewController(withIdentifier: "NewFeatureViewController")
            UserDefaults.standard.set(currentVersion, forKey: AppDelegate.versionKey)
            UserDefaults.standard.synchronize()
        }
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate {
    
    func checkAppUpdate() {
        
        //每天只检查一次
//        let date = NSDate()
//        let dformatter = DateFormatter()
//        dformatter.dateFormat = "yyyy-MM-dd"
//        let today = dformatter.string(from: date as Date)
//
//        let key = "needUpdate"
//        if let val = UserDefaults.standard.object(forKey: key) {
//            if (val as! String) == today {
//                return
//            }
//        }
//        UserDefaults.standard.set(today, forKey: key)
//        DXMRequestManage.rx.post_request(DXMPostProvider(.api_appVersion), params: nil, modelType: DXMAppUpdateModel.self).subscribe(onNext: { [weak self] result in
//            self?.handleResult(result)
//            }, onError: { [weak self] e in
//                self?.handleError(e)
//        }).addDisposableTo(self.bags)
        
    }
    
//    fileprivate func handleResult(_ result: DXMCommonModel<DXMAppUpdateModel>.StatusType) {
//        switch result {
//        case .singleModelSuccess(let r):
//            if let m = r.model {
//                if m.have_new_version == false {break}
//                let path = DXWPathAssemble.alertPathWithParams("提示", message: m.version_desc)
//                let r = DXWRouter(path, configType: DXMPathConfig.self, params: nil, modelParam: nil)
//                r.viewControllerAppare(animated: true, beforAppare: { vc -> (vc: UIViewController?, canHandle: Bool) in
//                    if let alertVc = vc as? UIAlertController {
//                        alertVc.addAction(UIAlertAction(title: "更新", style: .default, handler: {
//                            _ in
//                            if let url = URL(string: m.down_url ?? "") {
//                                UIApplication.shared.openURL(url)
//                            }else {
//                                UIApplication.shared.openURL(URL(string: "itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id1128831243?mt=8")!)
//                            }
//                            if !m.force_update {
//                                alertVc.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { _ in
//                                    alertVc.dismiss(animated: true, completion: nil)
//                                }))
//                            }
//
//                        }))
//                    }
//                    return (vc: vc, canHandle: false)
//                })
//            }
//        default:
//            break
//        }
//    }
//
//    fileprivate func handleError(_ error: Error) {
//
//    }
//
//    func uploadUserLog() {
//        DXMRequestManage().post_request(DXMPostProvider(DXMPostProvider.DXMPath.api_user_app_log), params: [:], successClosure: {
//            result in
//        }, modelType: DXMNull.self)
//    }
}

