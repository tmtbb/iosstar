//
//  AppConfigHelper.swift
//  iOSStar
//
//  Created by J-bb on 17/5/26.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit
import UserNotifications
import SVProgressHUD

// 个推信息
let kGtAppId:String = "STxLopLZK0AFPvAcnu7o67"
let kGtAppKey:String = "SIbhyImzug9sjKteFtLrj8"
let kGtAppSecret:String = "TgaFdlcYMX5QVhH1CkP1k2"

class AppConfigHelper: NSObject {
    private static var helper = AppConfigHelper()
    class func shared() -> AppConfigHelper {
        
        return helper
    }
    
     // MARK: - 网易云信
    func setupNIMSDK(sdkConfigDelegate:NTESSDKConfigDelegate?) {
        // //在注册 NIMSDK appKey 之前先进行配置信息的注册，如是否使用新路径,是否要忽略某些通知，是否需要多端同步未读数
        
        setupReceiveMatching()
        NIMSDKConfig.shared().delegate = sdkConfigDelegate
        NIMSDKConfig.shared().shouldSyncUnreadCount = true//0d0f4b452de9695f91b0e4dc949d54cc
        //9c3a406f233dea0d355c6458fb0171b8
        NIMSDK.shared().register(withAppID: "9c3a406f233dea0d355c6458fb0171b8", cerName: "")
        NIMKit.shared().registerLayoutConfig(NTESCellLayoutConfig.self)
        
        NIMCustomObject.registerCustomDecoder(NTESCustomAttachmentDecoder.init())
        
    }
    
    // MARK: -个推
    func setupGeTuiSDK(sdkDelegate : AppDelegate)  {
        
        // [ GTSdk ]：是否允许APP后台运行
        GeTuiSdk.runBackgroundEnable(true);
        
        // [ GTSdk ]：是否运行电子围栏Lbs功能和是否SDK主动请求用户定位
        // GeTuiSdk.lbsLocationEnable(true, andUserVerify: true);
        
        // [ GTSdk ]：自定义渠道
        GeTuiSdk.setChannelId("GT-Channel")
        
        // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT启动个推
        GeTuiSdk.start(withAppId: kGtAppId, appKey: kGtAppKey, appSecret: kGtAppSecret, delegate: sdkDelegate)
        
        // 注册APNs - custom method - 开发者自定义的方法
        self.registerRemoteNotification(sdkDelegate: sdkDelegate)
        
    }
    
    // MARK: - 注册用户通知(推送)
    func registerRemoteNotification(sdkDelegate:AppDelegate) {
        /*
         警告：Xcode8的需要手动开启“TARGETS -> Capabilities -> Push Notifications”
         */
        
        /*
         警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。
         以下为演示代码，仅供参考，详细说明请参考苹果开发者文档，注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken。
         */
        
        let systemVer = (UIDevice.current.systemVersion as NSString).floatValue;
        if systemVer >= 10.0 {
            if #available(iOS 10.0, *) {
                let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
                center.delegate = sdkDelegate;
                center.requestAuthorization(options: [.alert,.badge,.sound], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        print("注册通知成功") //点击允许
                    } else {
                        print("注册通知失败") //点击不允许
                    }
                })
                
                UIApplication.shared.registerForRemoteNotifications()
            } else {
                if #available(iOS 8.0, *) {
                    let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                    UIApplication.shared.registerUserNotificationSettings(userSettings)
                    
                    UIApplication.shared.registerForRemoteNotifications()
                }
            };
        }else if systemVer >= 8.0 {
            if #available(iOS 8.0, *) {
                let userSettings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
                UIApplication.shared.registerUserNotificationSettings(userSettings)
                
                UIApplication.shared.registerForRemoteNotifications()
            }
        }else {
            if #available(iOS 7.0, *) {
                UIApplication.shared.registerForRemoteNotifications(matching: [.alert, .sound, .badge])
            }
        }
    }
    
    // MARK: - 友盟
    func share(type:UMSocialPlatformType, shareObject:UMShareWebpageObject, viewControlller:UIViewController) {
        
        let messageObject = UMSocialMessageObject()

        messageObject.shareObject = shareObject

        UMSocialManager.default().share(to: type, messageObject: messageObject, currentViewController: viewControlller) { (data, error) in
            
            
        }
        
    }
    
    func setupUMSDK() {
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "592fbfb09f06fd64b0001fdb"
//        UMSocialManager.default().umSocialAppSecret = ""
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wx9dc39aec13ee3158", appSecret: "a12a88f2c4596b2726dd4ba7623bc27e", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.sina, appKey: "3921700954", appSecret: "04b48b094faeb16683c32669824ebdad", redirectURL: "www.baidu.com")
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1105821097", appSecret: nil, redirectURL: "www.baidu.com")

    }
    
    func setupRealmConfig() {
        
    }
    
    func setupReceiveMatching() {
        AppAPIHelper.dealAPI().setReceiveMatching { (response) in
            SVProgressHUD.showSuccess(withStatus: "收到通知")
        }

    }
}
