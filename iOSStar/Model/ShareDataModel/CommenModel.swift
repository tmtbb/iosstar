//
//  CommenModel.swift
//  iOSStar
//
//  Created by J-bb on 17/6/20.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import Foundation

class UpdateParam: BaseModel{
    var appName = ""
    var newAppSize = 0
    var newAppVersionCode: Double = 0
    var newAppVersionName = ""
    var newAppUpdateDesc = ""
    var newAppReleaseTime = ""
    var newAppUrl = ""
    var isForceUpdate = 0
    var haveUpate = false
}

class UpdateDeviceTokenModel:BaseModel  {
    
    
}