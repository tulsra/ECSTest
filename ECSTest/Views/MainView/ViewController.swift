//
//  ViewController.swift
//  ECSTest
//
//  Created by Tulasi on 03/08/19.
//  Copyright © 2019 Assignment. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let cellReuseIdendifier = "ViewedTableViewCell"
    var viewResp :ViewsAPIResponse = ViewsAPIResponse()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Setup UI
        self.setupUI()
        //Fetch dara from API
        self.fetchView()
    }
    
    func setupUI() {
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib.init(nibName: cellReuseIdendifier, bundle: nil), forCellReuseIdentifier: cellReuseIdendifier)
    }

    func fetchView() {
        self.showLoader()
        NetworkManager().req(method: .viewed, parameters: ["api-key":"MrB8akGSY5ddGbelEQlSHvOYyZGaLuVK"]) { (response, error) in
            if error == nil {
                if let result = response {
                    DispatchQueue.main.async {
                        self.dismissLoader()
                        //Group all Results as per requirement
                        if let kView = (result as? ViewsAPIResponse) {
                            self.viewResp = kView
                            self.tableView.reloadData()
                        }
                        else {
                            //Handle Error
                        }
                    }
                }
                else {
                    //Handle Error
                }
            }
            else {
                //Handle Error
            }
        }
    }
    //Prepare segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Detail") {
            let detailViewController = (segue.destination as! DetailViewController)
            detailViewController.url = sender as? String ?? ""
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewResp.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdendifier, for: indexPath) as! ViewedTableViewCell
       
        //Setup cell
        if let viewObj = self.viewResp.results?[indexPath.row] {
            let viewModel = MainViewViewModel(viewObj: viewObj)
            cell.titleLabel.text = viewModel.titleText()
            cell.detailLabel.attributedText = viewModel.byText()
            cell.dateLabel.text = viewModel.dateText()
            cell.imgView?.imageFromServerURL(urlString: viewModel.imgURL())
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let viewObj = self.viewResp.results?[indexPath.row] {
            let viewModel = MainViewViewModel(viewObj: viewObj)
            performSegue(withIdentifier: "Detail", sender: viewModel.detailURL())
        }
    }
}

