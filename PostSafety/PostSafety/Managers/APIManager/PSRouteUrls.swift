enum Route: String
{
    
    case Register           = "/api/register"
    case Login              = "/api/EmployeesLogin"
    case Checklist          = "/api/IncidentTypes"
    case ChecklistDetails   = "/api/ChecklistDetails"
    case Notifications      = "/api/NotificationsAPI"
    case Reports            = "/api/ReportsAPI"
    case CreateReport       = "/api/CreateReport/"
    case SingleChecklist    = "/api/Checklists"
    case UpdateEmployees    = "/api/UpdateEmployees"
    case UploadImage    = "/api/UploadImage/"
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
