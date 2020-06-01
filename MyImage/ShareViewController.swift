//
//  ShareViewController.swift
//  MyImage
//
//  Created by Yuma Sato on 2020/05/31.
//  Copyright © 2020 Yuma Sato. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    
    var screenShotImage = UIImage()
    
    @IBOutlet weak var resultimageView: UIImageView!
    
    @IBOutlet weak var commentLAbel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        resultimageView.image = resultImage
        commentLAbel.text = commentString
        commentLAbel.adjustsFontSizeToFitWidth = true
        
        
    }
    
    @IBAction func share(_ sender: Any) {
    
        //スクリーンショットを撮る
        takeScreenShot()
        
        
        let items = [screenShotImage] as [Any]
        //アクティビティビューに載せてシェアする
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    func takeScreenShot(){
        
        let width = CGFloat(UIScreen.main.bounds.width)
        let height = CGFloat(UIScreen.main.bounds.height/1.3)
        let size = CGSize(width: width, height: height)
    
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
