//
//  ViewController.swift
//  CoreDataSample
//
//  Created by 副山俊輔 on 2022/03/25.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // 永続コンテナへの参照を保持する変数
    var container: NSPersistentContainer!
    
    // 取得した情報を保持する配列
    var PersonData: [NSManagedObject] = []
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        // 永続コンテナのnilチェック
//                guard container != nil else {
//                    fatalError("This view needs a persistent container.")
//                }
    }
    
    @IBAction func pressCreateButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let personObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        personObject.setValue(nameTextField.text, forKey: "name")
        personObject.setValue(Int(ageTextField.text ?? ""), forKey: "age")
        appDelegate.saveContext()
    }
    
    @IBAction func pressReadButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            // 保存した画像情報を取得
            PersonData = try managedContext.fetch(fetchRequest)
            
            nameTextField.text = "\(String(describing: PersonData[0].value(forKey: "name")!))"
            ageTextField.text = "\(String(describing: PersonData[0].value(forKey: "age")!))"
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}


