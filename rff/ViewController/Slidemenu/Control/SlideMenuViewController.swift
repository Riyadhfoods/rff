//
//  SlideMenuViewController.swift
//  rff
//
//  Created by Riyadh Foods Industrial Co. on 21/08/1439 AH.
//  Copyright © 1439 Riyadh Foods Industrial Co. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // -- MARK: IBOutlets
    @IBOutlet weak var listTableview: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var employeeLabel: UILabel!
    @IBOutlet weak var holderViewRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var tableViewRightAnchor: NSLayoutConstraint!
    @IBOutlet weak var profileHolder: UIView!
    @IBOutlet weak var profileImageHeight: NSLayoutConstraint!
    @IBOutlet weak var profileImageWidth: NSLayoutConstraint!
    
    // -- MARK: variables
    let slideMenuScreenWidth = (AppDelegate().screenSize.width * 0.75)
    let screenHeight = AppDelegate().screenSize.height
    let contentWidth = AppDelegate().screenSize.width * 0.19
    let cellId_header = "cellId_header"
    let cell_list = "cell_list"
    var sectionsEnglish = [Section]()
    var sectionsArabic = [Section]()
    var menuImages = [MenuImage]()
    
    //let language = LoginViewController
    let languageChosen = LoginViewController.languageChosen
    
    // -- MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userName = AuthServices.currentUserName {
            employeeLabel.text = userName
        }
        
        listTableview.delegate = self
        listTableview.dataSource = self
        
        setupListMenuData()
        setupListMenuImage()
        
        setupWidth()
        
        print("Slide menu language selected \(languageChosen)")
    }
    
    // -- MARK: Setups
    func setupListMenuData(){
        sectionsEnglish = [
            Section(name: "HOME", items: []),
            Section(name: "MASTER", items: ["Change Password"], isExpanded: false),
            Section(name: "TRACKING", items: ["Inbox"]),
            Section(name: "EMPLOYEE MOVEMENT", items: [
                    "New Employee",
                    "Employee Vacation",
                    "Loan",
                    "Loan List",
                    "Resign",
                    "Employee violation",
                    "Return from Vacation",
                    "Salary Preview",
                    "Employee Info",
                    "Salary Change",
                    "Vacation Days Update",
                    "Ticket Change",
                    "Job Title Change",
                    "Business Trip",
                    "In Out Deduction"
                ], isExpanded: false),
            Section(name: "ATTENDANCE", items: [
                    "Attendance Details",
                    "OverTime Calculation",
                    "Settle Calculation",
                    "Attendance Clearance"
                ], isExpanded: false),
            Section(name: "ADMIN", items: [
                    "Approval Action",
                    "Assign Approval Action",
                    "Add Forms",
                    "Salary Calculation",
                    "Salary Deduction Rule",
                    "HR Doc Expiry"
                ], isExpanded: false),
            Section(name: "PURCHASE SYSTEM", items: [
                    "Purchase Inbox",
                    "Purchase",
                    "Purchase System-Riyadh Food"
                ], isExpanded: false),
            Section(name: "IT DEPARTMENT", items: [
                    "IT Request",
                    "IT-Master File",
                    "Add Category",
                    "My Requests",
                    "Device Details"
                ], isExpanded: false),
            Section(name: "PAYMENT REQUISITION", items: [
                    "New Payment-Req",
                    "Track Payment-Req",
                    "Update Bank Status"
                ], isExpanded: false),
            Section(name: "TASK", items: [
                    "New Task",
                    "Task Details"
                ], isExpanded: false),
            Section(name: "COMPLAIN", items: [
                    "New Complain",
                    "My Complains"
                ], isExpanded: false),
            Section(name: "SALES", items: [
                    "Sales Inbox",
                    "Sales Order Approval",
                    "Sales Return Approval",
                    "Sales Promotion Approval",
                    "Sales Order Requests",
                    "Return Order Requests",
                    "Promotion Request",
                    "Othaim Sales Status",
                    "Sales Plan Summary",
                    "Sales Person Area Setup",
                    "Sales Store Update"
                ]),
            Section(name: "CITRIX", items: [], isExpanded: false),
            Section(name: "REPORT", items: [], isExpanded: false)
        ]
        
        sectionsArabic = [
            Section(name: "الرئيسية", items: [], isExpanded: false),
            Section(name: "الصلاحيات", items: ["تغيير كلمة السر"], isExpanded: false),
            Section(name: "قائمة المهام", items: ["البريد الوارد"], isExpanded: false),
            Section(name: "إجراءات الموظف", items: [
                    "موظف جديد",
                    "نموذج اجازه",
                    "سلفة",
                    "قائمة السلف",
                    "استقالة",
                    "المخالفات",
                    "نموذج العودة من الاجازه",
                    "عرض الراتب",
                    "معلومات الموظف",
                    "تعديل الراتب",
                    "تحديث ايام الاجازه",
                    "تغيير تذكرة",
                    "تغيير المسمى الوظيفي",
                    "رحلة عمل",
                    "طلب اذن خروج"
                ], isExpanded: false),
            Section(name: "الحضور و الانصراف", items: [
                    "تفاصيل الحضور",
                    "حساب العمل الاضافي",
                    "إحتساب التصفية",
                    "الحضور و الانصراف"
                ], isExpanded: false),
            Section(name: "الإعتمادات", items: [
                    "الموافقة",
                    "ترحيل الرواتب",
                    "إضافة نماذج",
                    "احتساب الرواتب",
                    "خصومات الراتب",
                    "برنامج المستندات"
                ], isExpanded: false),
            Section(name: "المشتريات", items: [
                    "اوامر الشراء",
                    "المشتريات",
                    "نظام الشراء لشركة الرياض للاغذية"
                ], isExpanded: false),
            Section(name: "تقنية المعلومات", items: [
                    "طلبات التقنية",
                    "القائمة الرئيسية",
                    "إضافة صنف",
                    "طلباتي",
                    "تفاصيل الجهاز"
                ], isExpanded: false),
            Section(name: "طلبات الصرف", items: [
                    "طلب صرف جديد",
                    "متابعة طلبات الصرف",
                    "تحديث حالة البنك"
                ], isExpanded: false),
            Section(name: "المهام", items: [
                    "مهمة جديدة",
                    "تفاصيل المهمة",
                ], isExpanded: false),
            Section(name: "الشكاوي", items: [
                    "شكوى جديدة",
                    "شكوى",
                ], isExpanded: false),
            Section(name: "المبيعات", items: [
                    "المبيعات",
                    "الموافقة على طلب المبيعات",
                    "الموافقة على طلبات المرتجعات",
                    "الموافقة على عروض البيع",
                    "طلبات شركة الرياض للاغذية",
                    "طلبات ارجاع شركة الرياض للاغذية",
                    "برنامج العروض",
                    "حالة مبيعات العثيم",
                    "ملخض خطة المبيعات",
                    "إعداد منطقة مندوب مبيعات",
                    "تحديث مستودع المبيعات"
                ], isExpanded: false),
            Section(name: "برنامج الستركس", items: [], isExpanded: false),
            Section(name: "التقارير", items: [], isExpanded: false)
        ]
    }
    
    func setupListMenuImage(){
        menuImages = [
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "home"), listImage: []),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "master"), listImage: [#imageLiteral(resourceName: "password")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "tracking"), listImage: [#imageLiteral(resourceName: "inbox")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "employeeMovement"), listImage: [#imageLiteral(resourceName: "newEmployee"), #imageLiteral(resourceName: "employeeVacation"), #imageLiteral(resourceName: "loan"), #imageLiteral(resourceName: "loanList"), #imageLiteral(resourceName: "resign"), #imageLiteral(resourceName: "EmployeeViolation"), #imageLiteral(resourceName: "flight"), #imageLiteral(resourceName: "loan"), #imageLiteral(resourceName: "employeeInfo"), #imageLiteral(resourceName: "loan"), #imageLiteral(resourceName: "VacationDaysUpdate"), #imageLiteral(resourceName: "TicketChange"), #imageLiteral(resourceName: "JobTitleChange"), #imageLiteral(resourceName: "businessTrip"), #imageLiteral(resourceName: "InOutDeducation")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "attendance"), listImage: [#imageLiteral(resourceName: "attendanceDetails"), #imageLiteral(resourceName: "overTimeCalc"), #imageLiteral(resourceName: "salaryCalc"), #imageLiteral(resourceName: "approvalAction")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "admin"), listImage: [#imageLiteral(resourceName: "approvalAction"), #imageLiteral(resourceName: "approvalAction"), #imageLiteral(resourceName: "AddForms"), #imageLiteral(resourceName: "salaryCalc"), #imageLiteral(resourceName: "InOutDeducation"), #imageLiteral(resourceName: "hrDoc")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "purchseSystem"), listImage: [#imageLiteral(resourceName: "inbox"), #imageLiteral(resourceName: "purchase"), #imageLiteral(resourceName: "PurchaseSystemRF")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "itDepartment"), listImage: [#imageLiteral(resourceName: "request"), #imageLiteral(resourceName: "itMasterFile"), #imageLiteral(resourceName: "AddForms"), #imageLiteral(resourceName: "request"), #imageLiteral(resourceName: "DeviceDetials")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "paymentRequisition"), listImage: [#imageLiteral(resourceName: "request"), #imageLiteral(resourceName: "request"), #imageLiteral(resourceName: "UpdateBackStatus")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "task"), listImage: [#imageLiteral(resourceName: "AddForms"), #imageLiteral(resourceName: "details")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "complain"), listImage: [#imageLiteral(resourceName: "AddForms"), #imageLiteral(resourceName: "details")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "sales"), listImage: [#imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon"), #imageLiteral(resourceName: "salesIcon")]),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "citrix"), listImage: []),
            MenuImage(headerTitleImage: #imageLiteral(resourceName: "report"), listImage: []),
        ]
    }
    
    func setupWidth(){
        let porfileImageArea = AppDelegate().screenSize.width * 0.16
        
        holderViewRightAnchor.constant = contentWidth
        profileHolder.layoutIfNeeded()
        
        profileImageHeight.constant = porfileImageArea
        profileImageWidth.constant = porfileImageArea
        profileImage.layer.cornerRadius = porfileImageArea / 2
        profileImage.layoutIfNeeded()
        
        tableViewRightAnchor.constant = contentWidth
        listTableview.layoutIfNeeded()
    }
    
    // -- MARK: tableview datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsEnglish.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsEnglish[section].items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if sectionsEnglish[indexPath.section].isExpanded{
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let header = tableView.dequeueReusableCell(withIdentifier: cellId_header) as? HeaderTableViewCell{
            if languageChosen == 2{
                header.headerTitle.text = sectionsArabic[section].name
            } else {
                header.headerTitle.text = sectionsEnglish[section].name
            }
            header.headerIcon.image = menuImages[section].headerTitleImage
            header.expandButton.tag = section
            header.expandButton.addTarget(self, action: #selector(toggleSection(sender:)), for: .touchUpInside)
            
            if (section == 0 || section == 12 || section == 13){
                header.expandedIcon.isHidden = true
            }
            
            header.contentView.backgroundColor = UIColor(red: 105/255, green: 132/255, blue: 92/255, alpha: 1.0)
            return header.contentView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cell_list, for: indexPath) as? ListTableViewCell{
            if languageChosen == 2{
                cell.itemTitle.text = sectionsArabic[indexPath.section].items[indexPath.row]
            } else {
                cell.itemTitle.text = sectionsEnglish[indexPath.section].items[indexPath.row]
            }
            cell.accessoryType = .disclosureIndicator
            cell.ItemIcon.image = menuImages[indexPath.section].listImage[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let identifier = getRowIdentifier(indexPath) else {return}
        performSegue(withIdentifier: identifier, sender: nil)
    }
}











