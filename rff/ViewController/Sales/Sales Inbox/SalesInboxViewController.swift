//
//  SalesInboxViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 26/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SalesInboxViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // -- MARK: IBOutlets
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var ListTextfield: UITextField!
    @IBOutlet weak var showListPickerTextfield: UITextField!
    @IBOutlet weak var seachTextfield: UITextField!
    @IBOutlet weak var searchOutlet: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // -- MARK: variables
    
    let screenSize = AppDelegate().screenSize
    let segueId_transferStyle = "showTransferStyle"
    let segueId_orderStyle = "showOrderStyle"
    let segueId_returnStyle = "showReturnStyle"
    
    let selectListPickerView: UIPickerView = UIPickerView()
    let selectListArray = ["Select a list", "Order List", "Transfer List", "Return List"]
    var selectedListIndex: Int = 0
    
    let salesWebservice: Sales = Sales()
    var salesArray: [SalesModel] = [SalesModel]()
    var transferArray: [SalesModel] = [SalesModel]()
    var returnArray: [SalesModel] = [SalesModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ListTextfield.tintColor = .clear
        showListPickerTextfield.tintColor = .clear
        
        searchOutlet.setTitle(getString(englishString: "Search", arabicString: "ابحث", language: LoginViewController.languageChosen), for: .normal)
        
        setCustomNav(navItem: navigationItem)
        setUpPickerView()
        sideMenus()
    }
    
    // -- MARK: Setups
    
    func setUpPickerView(){
        PickerviewAction().showPickView(txtfield: showListPickerTextfield, pickerview: selectListPickerView, viewController: self, cancelSelector: #selector(cancelClick), doneSelector: #selector(doneClick))
    }
    
    // -- MARK: objc functions
    
    @objc func cancelClick(){
        showListPickerTextfield.resignFirstResponder()
    }
    
    @objc func doneClick(){
        ListTextfield.text = selectListArray[selectedListIndex]
        showListPickerTextfield.resignFirstResponder()
    }
    
    // -- MARK: Pickerview data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectListArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectListArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedListIndex = row
    }
    
    //To show the slide menu
    func sideMenus () {
        if revealViewController() != nil {
            menuBtn.target = revealViewController()
            menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = screenSize.width * 0.75
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func signOutBuuttonTapped(_ sender: Any) {
        AuthServices().logout(self)
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        //activityIndicator.startAnimating()
        if let userId = AuthServices.currentUserId, let searchText = seachTextfield.text{
            salesArray = salesWebservice.GetSalesInbox(id: selectedListIndex, emp_id: userId, searchtext: searchText, activityIndicator: activityIndicator)
        } else {
            return
        }
        switch selectedListIndex {
        case 1:
            performSegue(withIdentifier: segueId_orderStyle, sender: nil)
        case 2:
            performSegue(withIdentifier: segueId_transferStyle, sender: nil)
        case 3:
            performSegue(withIdentifier: segueId_returnStyle, sender: nil)
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case segueId_orderStyle:
            if let vc = segue.destination as? OrderStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                if let search = seachTextfield.text{
                   vc.searchMessage = search
                }
                vc.salesArray = salesArray
            }
        case segueId_transferStyle:
            if let vc = segue.destination as? TansferStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                if let search = seachTextfield.text{
                    vc.searchMessage = search
                }
                vc.salesArray = salesArray
            }
        case segueId_returnStyle:
            if let vc = segue.destination as? ReturnStyleTableViewController{
                vc.listIndexSelected = self.selectedListIndex
                if let search = seachTextfield.text{
                    vc.searchMessage = search
                }
                vc.salesArray = salesArray
            }
        default:
            break
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}









