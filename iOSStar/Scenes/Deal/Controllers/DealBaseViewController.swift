//
//  DealBaseViewController.swift
//  iOSStar
//
//  Created by J-bb on 17/6/12.
//  Copyright © 2017年 YunDian. All rights reserved.
//

import UIKit

class DealBaseViewController: UIViewController {
    var starListModel:StarSortListModel?
    var realTimeData:RealTimeModel?
    var positionCount = 0
    var totalCount = 0
    var indexBlock: CompleteBlock?
    
    var dealType:AppConst.DealType = AppConst.DealType.sell
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
