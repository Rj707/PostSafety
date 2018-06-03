enum Route: String
{
    
    case Register = "/api/register"
    case Login = "/api/EmployeesLogin"
    case Checklist = "/api/Checklists"
    case ChecklistDetails = "/api/ChecklistDetails"
    case UpdateEmployees = "/api/UpdateEmployees"
    
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
