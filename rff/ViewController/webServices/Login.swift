 import Foundation
 public class Login {
    public var Url:String = "http://82.118.166.164/ios_hrms/login.asmx"
    public var Host:String = "82.118.166.164"
    public func dataToBase64(data:NSData)->String{
        
        let result = data.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return result;
    }
    public func dataToBase64(data: Data)->String {
        let result = data.base64EncodedString()
        return result
    }
    public func byteArrayToBase64(data:[UInt])->String{
        let nsdata = NSData(bytes: data, length: data.count)
        let data  = Data.init(referencing: nsdata)
        if let str = String.init(data: data, encoding: String.Encoding.utf8){
            return str
        }
        return "";
    }
    public func timeToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    public func dateToString(date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public func base64ToByteArray(base64String: String) -> [UInt8] {
        let data = Data.init(base64Encoded: base64String)
        let dataCount = data!.count
        var bytes = [UInt8].init(repeating: 0, count: dataCount)
        data!.copyBytes(to: &bytes, count: dataCount)
        return bytes
    }
    func stringFromXMLString(xmlToParse:String)->String {
        do
        {
            let xml = SWXMLHash.lazy(xmlToParse)
            let xmlResponse : XMLIndexer? = xml.children.first?.children.first?.children.first
            let xmlResult: XMLIndexer?  = xmlResponse?.children.last
            
            let xmlElement = xmlResult?.element
            let str = xmlElement?.text
            let xmlElementFirst = xmlElement?.children[0] as!TextElement
            return xmlElementFirst.text
        }
        catch
        {
        }
        //NOT IMPLETEMENTED!
        var returnValue:String!
        return returnValue
    }
    func stringFromXML(data:Data)-> String
    {
        
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return ""
        }
        if xmlToParse!.count == 0 {
            return ""
        }
        let  stringVal = stringFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
        
    }
    func stringArrFromXMLString(xmlToParse :String)->[String?]{
        let xml  = SWXMLHash.lazy(xmlToParse)
        let xmlRoot  = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse : XMLIndexer? =  xmlBody?.children.first
        let xmlResult : XMLIndexer?  = xmlResponse?.children.last
        
        var strList = [String?]()
        let childs = xmlResult!.children
        for child in childs {
            let text = child.element?.text
            strList.append(text)
        }
        
        return strList
    }
    func stringArrFromXML(data:Data)->[String?]{
        let xmlToParse :String? = String.init(data: data, encoding: String.Encoding.utf8)
        if xmlToParse == nil {
            return [String?]()
        }
        if xmlToParse!.count == 0 {
            return [String?]()
        }
        
        let  stringVal = stringArrFromXMLString(xmlToParse:  xmlToParse!)
        return stringVal
    }
    
    func byteArrayToBase64(bytes: [UInt8]) -> String {
        
        let data = Data.init(bytes: bytes)
        let base64Encoded = data.base64EncodedString()
        return base64Encoded;
        
    }
    
    func base64ToByteArray(base64String: String) -> [UInt8]? {
        if let data = Data.init(base64Encoded: base64String){
            var bytes = [UInt8](repeating: 0, count: data.count)
            data.copyBytes(to: &bytes, count: data.count)
            return bytes;
        }
        return nil // Invalid input
    }
    
    public func HelloWorld()-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<HelloWorld xmlns=\"http://tempuri.org/\">"
        soapReqXML += "</HelloWorld>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/HelloWorld"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func CheckLogin(username:String, password:String, error:String, langid:Int)-> [String?]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<CheckLogin xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<username>"
        soapReqXML += username
        soapReqXML += "</username>"
        soapReqXML += "<password>"
        soapReqXML += password
        soapReqXML += "</password>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</CheckLogin>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/CheckLogin"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVals :[String?] = stringArrFromXML(data : responseData);
        var vals = [String?]()
        for i in 0  ..< strVals.count {
            let xVal =  strVals[i]
            vals.append(xVal)
        }
        let returnValue:[String?] = vals
        return returnValue
    }
    public func ChangePassword(emp_id:String, oldpassword:String, newpassword:String, error:String)-> String{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<ChangePassword xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<oldpassword>"
        soapReqXML += oldpassword
        soapReqXML += "</oldpassword>"
        soapReqXML += "<newpassword>"
        soapReqXML += newpassword
        soapReqXML += "</newpassword>"
        soapReqXML += "<error>"
        soapReqXML += error
        soapReqXML += "</error>"
        soapReqXML += "</ChangePassword>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/ChangePassword"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let strVal :String? = stringFromXML(data : responseData);
        if strVal == nil {
            
            return  ""
        }
        let returnValue:String = strVal!
        return returnValue
    }
    public func ListTypeArrFromXMLString(xmlToParse:String)->[ListType] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[ListType] = [ListType]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = ListType()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = ""
                    if elem1?.children.first is TextElement {
                        let elemText:TextElement = elem1?.children.first as! TextElement
                        strVal = elemText.text
                        
                    }
                    elemName = elem1!.name
                    // Array Propert of returnValue subProperty for rItem1
                    if elemName == "listtype" {
                        rItem1.listtype =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "listname" {
                        rItem1.listname =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func ListTypeArrFromXML(data: Data)-> [ListType] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return ListTypeArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func Bind_ddlReqType(langid:Int)-> [ListType]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<Bind_ddlReqType xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</Bind_ddlReqType>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/Bind_ddlReqType"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[ListType]=ListTypeArrFromXML(data : responseData)
        return returnValue
    }
    public func InboxGridArrFromXMLString(xmlToParse:String)->[InboxGrid] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[InboxGrid] = [InboxGrid]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = InboxGrid()
                let xmlResult_Parent1:XMLIndexer? = xmlResult0?.children[i1]
                let childCount1 :Int = (xmlResult_Parent1?.children.count)!
                for j1 in 0 ..< childCount1 {
                    
                    let xmlResult1: XMLIndexer? =  xmlResult_Parent1?.children[j1]
                    let elem1: XMLElement? =  xmlResult1?.element
                    strVal = ""
                    if elem1?.children.first is TextElement {
                        let elemText:TextElement = elem1?.children.first as! TextElement
                        strVal = elemText.text
                        
                    }
                    elemName = elem1!.name
                    // Array Propert of returnValue subProperty for rItem1
                    if elemName == "pid" {
                        rItem1.pid =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "empname" {
                        rItem1.empname =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "empid" {
                        rItem1.empid =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "date" {
                        rItem1.date =  strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func InboxGridArrFromXML(data: Data)-> [InboxGrid] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return InboxGridArrFromXMLString( xmlToParse : xmlToParse)
    }
    public func SearchInbox(empid:Int, formid:String, drpdwnvalue:String, search:String, langid:Int)-> [InboxGrid]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SearchInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empid>"
        soapReqXML += String(empid)
        soapReqXML += "</empid>"
        soapReqXML += "<formid>"
        soapReqXML += formid
        soapReqXML += "</formid>"
        soapReqXML += "<drpdwnvalue>"
        soapReqXML += drpdwnvalue
        soapReqXML += "</drpdwnvalue>"
        soapReqXML += "<search>"
        soapReqXML += search
        soapReqXML += "</search>"
        soapReqXML += "<langid>"
        soapReqXML += String(langid)
        soapReqXML += "</langid>"
        soapReqXML += "</SearchInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SearchInbox"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[InboxGrid]=InboxGridArrFromXML(data : responseData)
        return returnValue
    }
 }
