//
//  ViewController.swift
//  TwelveWork
//
//  Created by student on 2018/12/6.
//  Copyright © 2018年 2016110305. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var habit: UITextField!
    @IBOutlet weak var notice: UILabel!
    
    //本应用的代理(强转为自己的AppDelegate)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //数据库中的上下文
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func back(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        appDelegate.saveContext()
    }
    
    @IBAction func addPlayer(_ sender: Any) {
        let p = Player(context: context)
        p.name = name.text
        p.habit = habit.text
        dismiss(animated: true, completion: nil)
    }
    @IBAction func updatePlayer(_ sender: Any) {
        let fetch:NSFetchRequest<Player> = Player.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@",name.text!)
        let players = try? context.fetch(fetch)
        if let p = players?.first {
           p.habit = habit.text
           notice.text = "更新成功"
        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func deletePlayer(_ sender: Any) {
        let fetch:NSFetchRequest<Player> = Player.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@",name.text!)
        let players = try? context.fetch(fetch)
        if let p = players?.first {
            context.delete(p)
            notice.text = "删除成功"
        }
    }
    
    //查询操作完成,更新删除就很简单了
    @IBAction func queryPlayer(_ sender: Any) {
        let fetch:NSFetchRequest<Player> = Player.fetchRequest()
        fetch.predicate = NSPredicate(format: "name=%@",name.text!)
        let players = try? context.fetch(fetch)
        if let p = players?.first {
            name.text = p.name
            habit.text = p.habit
            notice.text = "查询成功"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

