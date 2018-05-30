import Foundation
public class EmpVac{
     public var exitrentry : String = ""
     public var extradays : String = ""
     public var Emp_Id : Int = 0
     public var Emp_Ename : String = ""
     public var Emp_AName : String = ""
     public var Job_Num : String = ""
     public var Job_English : String = ""
     public var Job_Arabic : String = ""
     public var Sub_Job_Num : String = ""
     public var Sub_Job_English : String = ""
     public var Sub_Job_Arabic : String = ""
     public var Nationality_Num : String = ""
     public var Nationality_English : String = ""
     public var Nationality_Arabic : String = ""
     public var Manager_Id : String = ""
     public var Manager_English : String = ""
     public var Manager_Arabic : String = ""
     public var Department_Num : String = ""
     public var Department_English : String = ""
     public var JoinDate : String = ""
     public var StartDate : String = ""
     public var Leave_Start_Dt : String = ""
     public var Leave_Return_Dt : String = ""
     public var Balance_Vacation : String = ""
     public var Number_Days : String = ""
     public var ExitReEntry : String = ""
     public var ExtraDays : String = ""
     public var Vac_Type : String = ""
     public var Vac_Desc : String = ""
     public var SettlementAmount : String = ""
     public var Dependent_Ticket : String = ""
}

extension EmpVac: CustomStringConvertible{
    public var description: String{
        return """
        
        exitrentry = \(exitrentry)
        extradays = \(extradays)
        Emp_Id = \(Emp_Id)
        Emp_Ename = \(Emp_Ename)
        Emp_AName = \(Emp_AName)
        Job_Num = \(Job_Num)\n
        Job_English = \(Job_English)
        Job_Arabic = \(Job_Arabic)
        Sub_Job_Num = \(Sub_Job_Num)
        Sub_Job_English = \(Sub_Job_English)
        Sub_Job_Arabic = \(Sub_Job_Arabic)
        Nationality_Num = \(Nationality_Num)
        Nationality_English = \(Nationality_English)
        Nationality_Arabic = \(Nationality_Arabic)
        Manager_Id = \(Manager_Id)
        Manager_English = \(Manager_English)
        Manager_Arabic = \(Manager_Arabic)
        Department_Num = \(Department_Num)
        Department_English = \(Department_English)
        JoinDate = \(JoinDate)
        StartDate = \(StartDate)
        Leave_Start_Dt = \(Leave_Start_Dt)
        Leave_Return_Dt = \(Leave_Return_Dt)
        Balance_Vacation = \(Balance_Vacation)
        Number_Days = \(Number_Days)
        ExitReEntry = \(ExitReEntry)
        ExtraDays = \(ExtraDays)
        Vac_Type = \(Vac_Type)
        Vac_Desc = \(Vac_Desc)
        SettlementAmount = \(SettlementAmount)
        Dependent_Ticket = \(Dependent_Ticket)
        """
    }
}
