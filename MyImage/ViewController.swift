//
//  ViewController.swift
//  MyImage
//
//  Created by Yuma Sato on 2020/05/31.
//  Copyright © 2020 Yuma Sato. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var kouhoImageView: UIImageView!
    
    @IBOutlet weak var commenttextView: UITextView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commenttextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
            case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
                
            }
        }
        // Do any additional setup after loading the view.
        
        getImages(keyword: "nice")
    }

    //検索キーワードをもとに画像を引っ張ってくる
    //API key: 16351992-4404b54614686a659b9710a6e
    
    func getImages(keyword:String){
        
        let url = "https://pixabay.com/api/?key=16351992-4404b54614686a659b9710a6e&q=\(keyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{
            
            (response) in
            
            switch response.result{
                
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webFormatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webFormatURL"].string
                    self.kouhoImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }else{
                    
                     self.kouhoImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                    
                }
                
               
                
            case .failure(let error):
                
                print(error)
                
            
            
        }
        
    }
    
}
    
    @IBAction func nextImage(_ sender: Any) {
    
    count = count + 1
        
        if searchTextField.text == ""{
            
            getImages(keyword: "good")
            
        }else{
            
            getImages(keyword:searchTextField.text!)
            
        }
        
    
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        
        if searchTextField.text == ""{
                   
                   getImages(keyword: "good")
                   
               }else{
                   
                   getImages(keyword:searchTextField.text!)
                   
               }
        
        
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
        
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commenttextView.text
        shareVC?.resultImage = kouhoImageView.image!
    
    }
    
}
