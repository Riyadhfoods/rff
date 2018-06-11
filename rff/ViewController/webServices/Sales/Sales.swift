 import Foundation 
 public class Sales {
    public var Url:String = "http://82.118.166.164/ios_hrms/sales.asmx"
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
    
    let dateFormatter = ISO8601DateFormatter()
    public func SalesArrFromXMLString(xmlToParse:String)->[SalesModel] {
        
        let xml = SWXMLHash.lazy(xmlToParse)
        let xmlRoot = xml.children.first
        let xmlBody = xmlRoot?.children.last
        let xmlResponse: XMLIndexer? = xml.children.first?.children.first?.children.first
        let xmlResult0: XMLIndexer?  = xmlResponse?.children.last
        var strVal = ""
        var elemName = ""
        var returnValue:[SalesModel] = [SalesModel]()
        if elemName == "" {
            // Array Property For returnValue
            let itemCount1: Int = (xmlResult0?.children.count)!
            for i1 in 0 ..< itemCount1 {
                let rItem1 = SalesModel()
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
                    if elemName == "totalrows" {
                        rItem1.totalrows = strVal.toInt()!
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "currentrows" {
                        rItem1.currentrows =  strVal
                    }
                    else if elemName == "OrderID" {
                        rItem1.OrderID =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReqDate" {
                        rItem1.ReqDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "DeliveryDate" {
                        rItem1.DeliveryDate =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_EmpCreated" {
                        rItem1.SO_EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Comment" {
                        rItem1.SO_Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_CustomerName" {
                        rItem1.SO_CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Items" {
                        rItem1.SO_Items =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Status" {
                        rItem1.SO_Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "SO_Url" {
                        rItem1.SO_Url =  strVal
                    }
                    // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ID" {
                        rItem1.ID = strVal.toInt()!
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "EmpCreated" {
                        rItem1.EmpCreated =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "CustomerName" {
                        rItem1.CustomerName =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Items" {
                        rItem1.Items =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Date" {
                        
                        rItem1.date = strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Status" {
                        rItem1.Status =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "PendingBy" {
                        rItem1.PendingBy =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "Comment" {
                        rItem1.Comment =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "URL" {
                        rItem1.URL =  strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "RequestDate" {
                        rItem1.RequestDate = strVal
                    }
                        // Array Propert of returnValue subProperty for rItem1
                    else if elemName == "ReturnDate" {
                        rItem1.ReturnDate = strVal
                    }
                    
                }
                returnValue.append(rItem1)
                
            }
        }
        return returnValue
    }
    public func SalesArrFromXML(data: Data)-> [SalesModel] {
        
        let xmlToParse   = String.init(data: data, encoding: String.Encoding.utf8)!
        return SalesArrFromXMLString( xmlToParse : xmlToParse)
    }
    
    public func SalesOrder(empno:Int)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<SalesOrder xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<empno>"
        soapReqXML += String(empno)
        soapReqXML += "</empno>"
        soapReqXML += "</SalesOrder>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/SalesOrder"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel] = SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func GetSalesInbox(id:Int, emp_id:String, searchtext:String, index:Int)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"

        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSalesInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<id>"
        soapReqXML += String(id)
        soapReqXML += "</id>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<searchtext>"
        soapReqXML += searchtext
        soapReqXML += "</searchtext>"
        soapReqXML += "<index>"
        soapReqXML += String(index)
        soapReqXML += "</index>"
        soapReqXML += "</GetSalesInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"

        let soapAction :String = "http://tempuri.org/GetSalesInbox"

        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
    
    public func GetSalesInbox(id:Int, emp_id:String, searchtext:String, index:Int, activityIndicator: UIActivityIndicatorView)-> [SalesModel]{
        var soapReqXML:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
        
        soapReqXML  += "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\""
        soapReqXML  += " xmlns:xsd =\"http://www.w3.org/2001/XMLSchema\""
        soapReqXML  += " xmlns:soap =\"http://schemas.xmlsoap.org/soap/envelope/\">"
        soapReqXML += " <soap:Body>"
        soapReqXML += "<GetSalesInbox xmlns=\"http://tempuri.org/\">"
        soapReqXML += "<id>"
        soapReqXML += String(id)
        soapReqXML += "</id>"
        soapReqXML += "<emp_id>"
        soapReqXML += emp_id
        soapReqXML += "</emp_id>"
        soapReqXML += "<searchtext>"
        soapReqXML += searchtext
        soapReqXML += "</searchtext>"
        soapReqXML += "<index>"
        soapReqXML += String(index)
        soapReqXML += "</index>"
        soapReqXML += "</GetSalesInbox>"
        soapReqXML += "</soap:Body>"
        soapReqXML += "</soap:Envelope>"
        
        let soapAction :String = "http://tempuri.org/GetSalesInbox"
        
        let responseData:Data = SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML, activityIndicator: activityIndicator)
        //SoapHttpClient.callWS(Host : self.Host,WebServiceUrl:self.Url,SoapAction:soapAction,SoapMessage:soapReqXML)
        let returnValue:[SalesModel]=SalesArrFromXML(data : responseData)
        return returnValue
    }
 }
