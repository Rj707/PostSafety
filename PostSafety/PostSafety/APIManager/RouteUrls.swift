enum Route: String
{
    
    case Register = "/api/register"
    case Login = "/api/EmployeesLogin"
    case DeviceToken = "/api/updatedeviceinfo"
    case UpdateProfile = "/api/user/update"
    case ForgotPassword = "/api/forgotpassword"
    
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
