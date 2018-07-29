enum Route: String
{
    case Register           = "/api/register"
    case Login              = "/api/EmployeesLogin"
    case Checklist          = "/api/IncidentTypes"
    case ChecklistDetails   = "/api/ChecklistDetails"
    case Reports            = "/api/ReportsAPI"
    case CreateReport       = "/api/CreateReport/"
    case SingleChecklist    = "/api/Checklists"
    case UpdateEmployees    = "/api/UpdateEmployees"
    case UploadImage        = "/api/UploadImage/"
    case UpdateReport       = "/api/UpdateReport/"
    case LocationsList      = "/api/LocationsList/"
    
    case Notifications      = "/api/NotificationsAPI"
    case AllReports         = "/api/AllReports/"
    case PolicyProcedures   = "/api/PolicyAndProcedures/"
    case Trainings          = "/api/Trainings/"
    case SummaryStatsCount  = "/api/SummaryReportsCount/"
    case SummaryStatsDetail = "/api/SummaryStatiticsReports/"
    
    func url() -> String
    {
        return Constants.BaseURL + self.rawValue
    }
}
