//
//  SecondScreenController.swift
//  NanoChallenge2
//
//  Created by Arnold Tjiawi on 19/09/19.
//  Copyright © 2019 ArnoldTjiawi. All rights reserved.
//

import UIKit
import CloudKit
import CoreData


class SecondScreenViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
   
    
    var textPass: String!
    

    var reflection = [Reflection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetchRequest: NSFetchRequest<Reflection> = Reflection.fetchRequest()
        
        do{
            let reflection = try PersistentService.context.fetch(fetchRequest)
            self.reflection = reflection
            self.collectionView.reloadData()
        }catch {}
        
        let nib = UINib(nibName: "ReflectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ReflectionCell")
        

    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let reflectionVC = segue.destination as? ReflectionNoteViewController else{ return }
        reflectionVC.titleReflection = textPass
    }
    
    @IBAction func addNewTapped() {
        alertNewReflection()
    }
    

//    @IBAction func didUnwinFromReflectionVC(_ sender: UIStoryboardSegue){
//        guard let reflectionVC = sender.source as? ReflectionNoteViewController else { return }
//        foodDisplayLabel.text = drinkVC.foodTextField.text
//    }
    
    func alertNewReflection() {
        let alert = UIAlertController(title: "Today Reflection", message: "Let's give a name to this reflection", preferredStyle: .alert)
        alert.addTextField {(textField) in
            textField.placeholder = "put something to remember"
        }
        let cancel = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
        let post = UIAlertAction(title: "Post", style: .default) { (_)in
            guard let text = alert.textFields?.first?.text else{return}
            if text == "" {
                alert.dismiss(animated: true, completion: nil)
                self.alertNewReflection()
               
            }else {
                self.textPass = text
                self.performSegue(withIdentifier: "NewReflectionSegue", sender: self)
            }
           
            
            
        }
        
        
        // If the text contains non whitespace characters, enable the OK Button
       
        alert.addAction(cancel)
        alert.addAction(post)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveToCloud(reflectName: String, date: Date, reflection: String){
        let newReflection = CKRecord(recordType: "Reflection")
        newReflection.setValue(reflection, forKey: "content")
        
        
    }
    
}


extension SecondScreenViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reflection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dateFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM dd, yyyy 'at' h:mm a"
            return dateFormatter
        }()
        let reflect = reflection[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReflectionCell", for: indexPath) as! ReflectionCell
        cell.reflectionTitleLabel.text = reflection[indexPath.row].title
        cell.reflectionDateLabel.text = dateFormatter.string(from: reflection[indexPath.row].date!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let cellSize = width - 16
        return CGSize(width: cellSize, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowReflectionSegue", sender: indexPath)
    }
}
