//
//  FeedViewController.swift
//  ViewControllersAndLogs
//
//  Created by Ilya Aleshin on 21.06.2018.
//  Copyright © 2018 Bakh. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var feedList: UITableView!
    
    private var feeds: [Feed] = []
    
    private var items: [String] = ["Разговор о beta Xcode 10", "Шарим в логах и создаем классы вьюхам!", "TabBar - это то что нужно", "Switch, If Else и Ночной режим", "Вывод и Позиционирование"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nibs : Array = Bundle.main.loadNibNamed("FeedItem", owner: self, options: nil)!
        let cell:FeedItem = nibs[0] as! FeedItem
        cell.setTitle(title: feeds[indexPath.row].title)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("this view was loaded")
        let url = URL(string: "http://triangleye.com/bakh/lessons/swift/s6/")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) {data, response, error in
            if (error != nil) {
                print("Server error is", error ?? "unknow")
                return
            }
            print("Server returns: ", String(data: data!, encoding: String.Encoding.utf8) ?? "")
            let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let responseJSON = responseJSON as? [Any] {
                print(responseJSON)
                self.feeds.removeAll()
                for f in responseJSON {
                    self.feeds.append(Feed(data: f as! [String:Any]))
                }
                DispatchQueue.main.async {
                    self.feedList.reloadData()
                }
            } else {
                print("json error")
                // TODO: if server not json format response return standrd error json
            }
        }.resume()
    }
    
}
