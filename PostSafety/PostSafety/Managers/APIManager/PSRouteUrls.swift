enum Route: String
{
    
    case Register           = "/api/register"
    case Login              = "/api/EmployeesLogin"
    case Checklist          = "/api/Checklists"
    case ChecklistDetails   = "/api/ChecklistDetails"
    case Notifications      = "/api/NotificationsAPI"
    case Reports            = "/api/ReportsAPI"
    case CreateReport       = "/api/CreateReport"
    case ReportType         = "/api/IncidentTypes"
    case UpdateEmployees    = "/api/UpdateEmployees"
    
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
