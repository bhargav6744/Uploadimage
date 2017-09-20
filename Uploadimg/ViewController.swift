//
//  ViewController.swift
//  Uploadimg
//
//  Created by Hitesh V-PI on 30/05/17.
//  Copyright © 2017 Pixabit Infotech. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate   {
    
    
    var img = UIImage()
    let Picker = UIImagePickerController()
    let headers : HTTPHeaders = ["Content-Type": "application/json","Authorization" : "Token abcd"]
    
    @IBAction func btnBrowse(_ sender: UIButton) {
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        Picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            Picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(Picker, animated: true, completion: nil)
        }else{
            let alert = UIAlertView()
            alert.title = "Warning"
            alert.message = "You don't have camera"
            alert.addButton(withTitle: "OK")
            alert.show()
        }
    }
    func openGallary(){
        Picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(Picker, animated: true, completion: nil)
    }
    //MARK:UIImagePickerControllerDelegate
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        picker .dismiss(animated: true, completion: nil)
        self.img=(info[UIImagePickerControllerOriginalImage] as? UIImage)!
    }
    private func imagePickerControllerDidCancel(picker: UIImagePickerController){
        print("picker cancel.")
    }
    
    
    @IBAction func imgUpload(_ sender: UIButton) {
        
        
        let parameters: Parameters = [
                                      "username": "9998010990"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let imageData = UIImageJPEGRepresentation(self.img, 0.5){
                     multipartFormData.append(imageData, withName: "file")
                }
                for (key,value) in parameters {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
        },
            to: "http://103.240.162.213/NewGym/Webservice.asmx/Useruploadimage",method: .post, headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        if let JSON = response.result.value{
                            
                            
                            print("JSON: \(JSON)")
                        }

                    print("hello")
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        
        
        
        
        
        
        
        
        
        }
        
        
        
        
        
        

        

        
        
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        Picker.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

