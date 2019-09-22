//
//  ReflectionNoteViewController.swift
//  NanoChallenge2
//
//  Created by Arnold Tjiawi on 23/09/19.
//  Copyright © 2019 ArnoldTjiawi. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ReflectionNoteViewController: UIViewController{
    
    var titleReflection: String!
    

    @IBOutlet weak var textView: UITextView!
    
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(titleReflection)
    }
    @IBAction func doneTapped(){
        let text = String(textView.text)
        let date = Date()
        let title = String(titleReflection)
        print(text)
        print(date)
        print(title)
        
//        let reflection = Reflection(context: PersistentService.context)
//        reflection.date = Date()
//        reflection.title = title
//        reflection.text = text
//        PersistentService.saveContext()
        print("save done")
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
  
}
    

