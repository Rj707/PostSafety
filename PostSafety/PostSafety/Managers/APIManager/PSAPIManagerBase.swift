import UIKit
import Alamofire
import SwiftyJSON


class PSAPIManagerBase: NSObject
{
    var alamoFireManager : SessionManager!
    let baseURL = Constants.BaseURL
    let defaultRequestHeader = ["Content-Type": "application/json"]
    let defaultError = NSError(domain: "ACError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request Failed."])
    
    // MARK:- Implementation
    
    override init()
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getAuthorizationHeader () -> Dictionary<String,String>
    {
        
        if(PSDataManager.sharedInstance.isUserLoggedIn())
        {
            if let token = PSAPIManager.sharedInstance.serverToken
            {
                var str = "bearer "
                str.append(token)
                return ["Authorization":str,"Accept":"application/json"]
            }
        }
        return ["Content-Type":"application/json"]
    }
    
    func getVerificationHeader () -> Dictionary<String,String>
    {
        
        if(PSDataManager.sharedInstance.isUserLoggedIn())
        {
            if let token = PSAPIManager.sharedInstance.serverToken
            {
                var str = "bearer "
                str.append(token)
                return ["Authorization":str,"Accept":"application/json"]
            }
        }
        return ["Content-Type":"application/json"]
    }
    
    
    func getErrorFromResponseData(data: Data) -> NSError?
    {
        do
        {
            let result = try JSONSerialization.jsonObject(with: data,options: JSONSerialization.ReadingOptions.mutableContainers) as? Array<Dictionary<String,AnyObject>>
            if let message = result?[0]["message"] as? String
            {
                let error = NSError(domain: "GCError", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
                return error;
            }
        }
        catch
        {
            NSLog("Error: \(error)")
        }
        
        return nil
    }
    
    // MARK: - URLs
    
    func URLforRoute(route: String,params:Parameters) -> NSURL?
    {
        
        if let components: NSURLComponents  = NSURLComponents(string: (Constants.BaseURL+route))
        {
            var queryItems = [NSURLQueryItem]()
            for(key,value) in params
            {
                queryItems.append(NSURLQueryItem(name:key,value: value as? String))
            }
            components.queryItems = queryItems as [URLQueryItem]?
            
            return components.url as NSURL?
        }
        
        return nil;
    }
    
    
    func POSTURLforRoute(route:String) -> URL?
    {
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route))
        {
            return components.url! as URL
        }
        return nil
    }
    
    
    func GETURLfor(route:String) -> URL?
    {
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route))
        {
            return components.url! as URL
        }
        return nil
    }
    
    // Pass paramaters same as post request. (But in string)
    func GETURLfor(route:String, parameters: Parameters) -> URL?
    {
        var queryParameters = ""
        for key in parameters.keys
        {
            if queryParameters.isEmpty
            {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else
            {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)
            
        }
        
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route+queryParameters))
        {
            return components.url! as URL
        }
        return nil
    }
    
    // MARK:  URLs Post Safety
    
    func GETURLforPS(route:String, parameters: [String]) -> URL?
    {
        var queryParameters = ""
        for object in parameters
        {
            queryParameters += String(format: "/%@", object)
        }
        
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route+queryParameters))
        {
            return components.url! as URL
        }
        return nil
    }
    
    // MARK:- REQUESTs
    
    // MARK: GET
    
    func getRequestWith(route: URL,parameters: [String],
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        alamoFireManager.request(route, method: .get, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON
        {
            response in
            guard response.result.error == nil else
            {
                var statusCode = response.response?.statusCode
                print("error in calling get request")
                if errorPopup
                {
                    //                    self.showErrorMessage(error: response.result.error!)
                }
                if statusCode==nil
                {
                    statusCode = 0
                }
                failure(response.result.error! as NSError,statusCode!)
                
                return;
            }
            
            if response.result.isSuccess
            {
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else if let jsonResponse = response.result.value as? Int
                {
                    let parameters: [String:Any] =
                        [
                            "ReportID":jsonResponse,
                        ]
                    success(parameters as Dictionary<String, AnyObject>)
                }
                else
                {
                    var finalArray:[Any] = []
                    if let jsonResponse = response.result.value as? [Any]
                    {
                        for peopleDict in jsonResponse
                        {
//                            if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String]
                            if let dict = peopleDict as? [String: Any]
                            {
                                finalArray.append(dict)
                            }
                        }
                    }
                    var dic = Dictionary<String, AnyObject>()
                    dic["array"] = finalArray as AnyObject
                    success(dic)
                }
            }
        }
    }
    
    // MARK: POST
    
    func postRequestWith(route: URL,parameters: Parameters,
                         success:@escaping DefaultArrayResultAPISuccessClosure,
                         failure:@escaping DefaultAPIFailureClosure,
                         errorPopup: Bool)
    {
        alamoFireManager.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getAuthorizationHeader()).responseJSON
            {
            response in
            guard response.result.error == nil else
            {
                let statusCode = response.response?.statusCode
                print("error in calling post request")
                
                if errorPopup
                {
//                    self.showErrorMessage(error: response.result.error!)
                }

                failure(response.result.error! as NSError,statusCode!)
                return;
            }
            
            if let value = response.result.value
            {
                print (value)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else
                {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    func postRequestWithBearer(route: URL,parameters: Parameters,
                               success:@escaping DefaultArrayResultAPISuccessClosure,
                               failure:@escaping DefaultAPIFailureClosure,
                               errorPopup: Bool)
    {
        alamoFireManager.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getVerificationHeader()).responseJSON
        {
            response in
            guard response.result.error == nil else
            {
                let statusCode = response.response?.statusCode
                print("error in calling post request")
                if errorPopup
                {
//                    self.showErrorMessage(error: response.result.error!)
                }
                failure(response.result.error! as NSError,statusCode!)
                return;
            }
            
            if let value = response.result.value
            {
                print (value)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else
                {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    func postVerificationRequestWith(route: URL,parameters: Parameters,
                                     success:@escaping DefaultArrayResultAPISuccessClosure,
                                     failure:@escaping DefaultAPIFailureClosure,
                                     errorPopup: Bool)
    {
        alamoFireManager.request(route, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: getVerificationHeader()).responseJSON
        {
            response in
            guard response.result.error == nil else
            {
                let statusCode = response.response?.statusCode
                print("\n- Error in calling post request")
                if errorPopup
                {
//                    self.showErrorMessage(error: response.result.error!)
                }
                failure(response.result.error! as NSError,statusCode!)
                return;
            }
        
            if let value = response.result.value
            {
                print (value)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else
                {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    func postRequestWithMultipart_General(route: URL,parameters: Parameters,
                                          success:@escaping DefaultArrayResultAPISuccessClosure,
                                          failure:@escaping DefaultAPIFailureClosure,
                                          errorPopup: Bool)
    {
        
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.post, headers: getAuthorizationHeader())
        
        requestWithMultipart(URLSTR: URLSTR, route: route, parameters: parameters, success: success, failure: failure, errorPopup: errorPopup)
    }
    
    func postRequestWithMultipart(route: URL,parameters: Parameters,
                                  success:@escaping DefaultArrayResultAPISuccessClosure,
                                  failure:@escaping DefaultAPIFailureClosure,
                                  errorPopup: Bool)
    {
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.post, headers: getAuthorizationHeader())
        
        Alamofire.upload(multipartFormData:
        {
            multipartFormData in
            
            var subParameters = Dictionary<String, AnyObject>()
            let keys: Array<String> = Array(parameters.keys)
            let values = Array(parameters.values)
            
            for i in 0..<keys.count
            {
                //                if ((keys[i] != "file") && (keys[i] != "images")) {
                subParameters[keys[i]] = values[i] as AnyObject
            }
            
            for (key, value) in subParameters
            {
                if let data:Data = value as? Data
                {
                    multipartFormData.append(data, withName: "file", fileName: "image.png", mimeType: "image/png")
                }
                else
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
        }, with: URLSTR, encodingCompletion:
        
        {
            result in
            switch result
            {
                case .success(let upload, _, _):
                    upload.responseJSON
                    { response in
                        
                        guard response.result.error == nil else
                        {
                            if errorPopup
                            {
                                //                            self.showErrorMessage(error: response.result.error!)
                            }
                            let statusCode = response.response?.statusCode
                            print("error in calling post request")
                            failure(response.result.error! as NSError,statusCode!)
                            return;
                        }
                        
                        if let value = response.result.value
                        {
                            print (value)
                            if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                            {
                                success(jsonResponse)
                            }
                            else
                            {
                                success(Dictionary<String, AnyObject>())
                            }
                        }
                        
                    }
                case .failure(let encodingError):
                    if errorPopup
                    {
                        //                    self.showErrorMessage(error: encodingError)
                    }
                    
                    failure(encodingError as NSError,0)
                
                
            }
        })
    }
    
    func postRequestWithMultipartWithBearer(route: URL,parameters: Parameters,
                                            success:@escaping DefaultArrayResultAPISuccessClosure,
                                            failure:@escaping DefaultAPIFailureClosure,
                                            errorPopup: Bool)
    {
        
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.post, headers: getVerificationHeader())
        
        Alamofire.upload(multipartFormData:
        {
            multipartFormData in
            
            var subParameters = Dictionary<String, AnyObject>()
            let keys: Array<String> = Array(parameters.keys)
            let values = Array(parameters.values)
            
            for i in 0..<keys.count
            {
                //                if ((keys[i] != "file") && (keys[i] != "images")) {
                subParameters[keys[i]] = values[i] as AnyObject
            }
            
            for (key, value) in subParameters
            {
                if let data:Data = value as? Data
                {
                    multipartFormData.append(data, withName: "file", fileName: "image.png", mimeType: "image/png")
                }
                else
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
        }, with: URLSTR, encodingCompletion:
        {
            result in
            
            switch result
            {
                case .success(let upload, _, _):
                    upload.responseJSON
                    {
                        response in
                        guard response.result.error == nil else
                        {
                            let statusCode = response.response?.statusCode
                            print("error in calling post request")
                            if errorPopup
                            {
                                //                            self.showErrorMessage(error: response.result.error!)
                            }
                            
                            failure(response.result.error! as NSError,statusCode!)
                            return;
                        }
                        
                        if let value = response.result.value
                        {
                            print (value)
                            if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                            {
                                success(jsonResponse)
                            }
                            else
                            {
                                success(Dictionary<String, AnyObject>())
                            }
                        }
                    }
                case .failure(let encodingError):
                    if errorPopup
                    {
                        //                    self.showErrorMessage(error: encodingError)
                    }
                    failure(encodingError as NSError,0)
            }
        })
    }
    
    // MARK: Upload Image

    func requestWith(endUrl: String,
                     imageData: Data?,
                     parameters: [String : Any],
                     onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil)
    {
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                for (key, value) in parameters
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
                
                if let data = imageData
                {
                    multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
                }
                
        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: nil)
        {
            (result) in
            switch result
            {
            case .success(let upload, _, _):
                upload.responseJSON
                    {
                        response in
                        print("Succesfully uploaded")
                        //                    if let err = response.de
                        //                    {
                        //                        onError?(err)
                        //                        return
                        //                    }
                        onCompletion?(nil)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }
    
//    func requestWith(endUrl: String,
//                     imageData: Data?,
//                     parameters: [String : Any],
//                     onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil)
//    {
//        Alamofire.upload(multipartFormData:
//        {
//            (multipartFormData) in
//            for (key, value) in parameters
//            {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//
//            if let data = imageData
//            {
//                multipartFormData.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
//            }
//
//        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: nil)
//        {
//            (result) in
//            switch result
//            {
//            case .success(let upload, _, _):
//            upload.responseJSON
//            {
//                response in
//                print("Succesfully uploaded")
////                    if let err = response.de
////                    {
////                        onError?(err)
////                        return
////                    }
//                onCompletion?(nil)
//            }
//            case .failure(let error):
//            print("Error in upload: \(error.localizedDescription)")
//            onError?(error)
//            }
//        }
//    }
    
    // MARK: PUT
    
    func putRequestWith(route: URL,parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool)
    {
        Alamofire.request(route, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON
        {
            response in
            guard response.result.error == nil else
            {
                let statusCode = response.response?.statusCode
                print("error in calling post request")
                if errorPopup
                {
//                    self.showErrorMessage(error: response.result.error!)
                }

                failure(response.result.error! as NSError,statusCode!)
                return;
            }
            
            if let value = response.result.value
            {
                print (value)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else
                {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    func putRequestWithMultipart_General(route: URL,parameters: Parameters,
                                         success:@escaping DefaultArrayResultAPISuccessClosure,
                                         failure:@escaping DefaultAPIFailureClosure,
                                         errorPopup: Bool)
    {
        let URLSTR = try! URLRequest(url: route.absoluteString, method: HTTPMethod.put, headers: getAuthorizationHeader())
        
        requestWithMultipart(URLSTR: URLSTR, route: route, parameters: parameters, success: success, failure: failure , errorPopup: errorPopup)
    }
    
    
    // MARK: DELETE
    
    func deleteRequestWith(route: URL,parameters: Parameters,
                           success:@escaping DefaultArrayResultAPISuccessClosure,
                           failure:@escaping DefaultAPIFailureClosure,
                           errorPopup: Bool)
    {
        Alamofire.request(route, method: .delete, parameters: parameters, encoding: JSONEncoding.default).responseJSON
        {
            response in
            guard response.result.error == nil else
            {
                let statusCode = response.response?.statusCode
                print("error in calling post request")
                if errorPopup
                {
//                    self.showErrorMessage(error: response.result.error!)
                }
                
                failure(response.result.error! as NSError,statusCode!)
                return;
            }
            
            if let value = response.result.value
            {
                print (value)
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                {
                    success(jsonResponse)
                }
                else
                {
                    success(Dictionary<String, AnyObject>())
                }
            }
        }
    }
    
    // MARK: MULTIPART
    
    func requestWithMultipart(URLSTR: URLRequest, route: URL,parameters: Parameters,
                              success:@escaping DefaultArrayResultAPISuccessClosure,
                              failure:@escaping DefaultAPIFailureClosure,
                              errorPopup: Bool)
    {
        Alamofire.upload(multipartFormData:
        {
            multipartFormData in
            if parameters.keys.contains("photobase64")
            {
                let fileURL = URL(fileURLWithPath: parameters["photobase64"] as! String)
                multipartFormData.append(fileURL, withName: "profile_picture", fileName: "image.png", mimeType: "image/png")
            }
            
            var subParameters = Dictionary<String, AnyObject>()
            let keys: Array<String> = Array(parameters.keys)
            let values = Array(parameters.values)
            
            for i in 0..<keys.count
            {
                if ((keys[i] != "photobase64") && (keys[i] != "images"))
                {
                    subParameters[keys[i]] = values[i] as AnyObject
                }
            }
            
            if parameters.keys.contains("images")
            {
                let images = parameters["images"] as! Array<String>
                for i in 0  ..< images.count
                {
                    let fileURL = URL(fileURLWithPath: images[i])
                    multipartFormData.append(fileURL, withName: "image\(i+1)", fileName: "image\(i).png", mimeType: "image/png")
                }
            }
            
            for (key, value) in subParameters
            {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                //debug
                print(value)
            }
            
        }, with: URLSTR, encodingCompletion:
            {result in
            
            switch result
            {
            case .success(let upload, _, _):
                upload.responseJSON
                {
                    response in
                    guard response.result.error == nil else
                    {
                        let statusCode = response.response?.statusCode
                        print("error in calling post request")
                        if errorPopup
                        {
//                            self.showErrorMessage(error: response.result.error!)
                        }

                        failure(response.result.error! as NSError,statusCode!)
                        return;
                    }
                    
                    
                    
                    if let value = response.result.value
                    {
                        print (value)
                        if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>
                        {
                            success(jsonResponse)
                        }
                        else
                        {
                            success(Dictionary<String, AnyObject>())
                        }
                    }
                    
                }
            case .failure(let encodingError):
                if errorPopup
                {
//                    self.showErrorMessage(error: encodingError)
                }

                failure(encodingError as NSError,0)
            }
        })
    }
    
    fileprivate func multipartFormData(parameters: Parameters)
    {
        let formData: MultipartFormData = MultipartFormData()
        if let params:[String:AnyObject] = parameters as [String : AnyObject]?
        {
            for (key , value) in params
            {
                if let data:Data = value as? Data
                {
                    formData.append(data, withName: "profile_picture", fileName: "image.png", mimeType: "image/png")
                }
                else
                {
                    formData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            print("\(formData)")
        }
    }
    
    
}

public extension Data
{
    public var mimeType:String
    {
        get
        {
            var c = [UInt32](repeating: 0, count: 1)
            (self as NSData).getBytes(&c, length: 1)
            switch (c[0]) {
            case 0xFF:
                return "image/jpeg";
            case 0x89:
                return "image/png";
            case 0x47:
                return "image/gif";
            case 0x49, 0x4D:
                return "image/tiff";
            case 0x25:
                return "application/pdf";
            case 0xD0:
                return "application/vnd";
            case 0x46:
                return "text/plain";
            default:
                print("mimeType for \(c[0]) in available");
                return "application/octet-stream";
            }
        }
    }
}



